import os
from typing import Any

import requests
from dagster import op
from dagster_snowflake import SnowflakeResource
from snowflake.connector.pandas_tools import write_pandas
import pandas as pd

# snowflake columns
req_column_name = "request_json"
res_column_name = "response_json"
# header
headers = {
    "X-TMC-Client-Id": os.getenv("X_TMC_CLIENT_ID"),
    "X-TMC-Client-secret": os.getenv("X_TMC_CLIENT_SECRET"),
    "Content-Type": "application/json",
    "X-TMC-ZDFW-USERID": os.getenv("X_TMC_ZDFW_USERID"),
    "X-TMC-ZDFW-COMPCODE": os.getenv("X_TMC_ZDFW_COMPCODE")
}
# response table
res_table = {
    "database_name": "",
    "schema_name": "",
    "table_name": "",
    "auto_create_table": True,
    "overwrite": True,
    "quote_identifiers": False
}

# url switch
prod_stg = ["prod", "stg"]
prod = ["prod"]

# リクエストデータ抽出
@op
def get_request_data_from_snowflake(snowflake: SnowflakeResource, table_full_name: str) -> pd.DataFrame:
    column_name = req_column_name
    with snowflake.get_connection() as conn:
        # 接続エラー時には、Exceptionが投げられる
        request_body_df = pd.DataFrame(
            conn.cursor().execute(
                f"""
                    select
                        {column_name}
                    from
                        {table_full_name};
                """
            ),
            columns=[column_name]
        )

    return request_body_df


# Web-APIコール
@op
def post_web_api_call_to_kitora(url: str, headers: dict[str, Any], dataframe: pd.DataFrame, env) -> pd.DataFrame:
    # 非本番と本番でKITORAのURLが異なる
    if os.getenv("dbt_deploy_env", "") in env:
        url_base = "https://webapi-gw-g01.kitora.toyota.co.jp/tmc/"
    else:
        url_base = "https://webapi-gw-t01.kitora.toyota.co.jp/tmc/"

    response_list = []
    session = requests.Session()

    # DataFrameから列番号０のみを抽出
    for request_json in dataframe.iloc[:,0]:
        # リクエスト送信
        response = session.post(url=url_base+url, headers=headers, data=request_json, timeout=60)
        response.raise_for_status() # 400~599 -> Exception
        response_list.append(response.text)

    # リストをDataFrame化し、カラム名を付与
    response_body_df = pd.DataFrame(
        response_list
        , columns=[res_column_name]
    )

    return response_body_df


# レスポンスデータ書き込み
@op
def put_response_data_to_snowflake(snowflake: SnowflakeResource, res_table: dict, dataframe: pd.DataFrame) -> int:
    with snowflake.get_connection() as conn:
        success, number_chunks, rows_inserted, output = write_pandas(
            conn = conn,
            # DataFrame
            df = dataframe,
            # DB
            database = res_table["database_name"],
            schema = res_table["schema_name"],
            table_name = res_table["table_name"],
            # option
            auto_create_table = res_table["auto_create_table"],
            overwrite = res_table["overwrite"],
            quote_identifiers = res_table["quote_identifiers"],
        )

    if success != True:
        msg = "Error occurred while copying into Snowflake"
        raise Exception(msg, output)

    return rows_inserted