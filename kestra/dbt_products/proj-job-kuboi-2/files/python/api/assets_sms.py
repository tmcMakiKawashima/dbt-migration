import os

import api_util
from api_util import headers, res_table, prod
import json

eng_db = "engineering_db"
pub_schema = "kestra_trial"


def sms_api_parts_info_asset():

    # --------------------
    # Parameters
    # --------------------
    # Request
    req_table_full_name = "engineering_db.kestra_trial.tmp_sms_api_parts_info_req_json"
    # Web-API call
    url = "engineering/GSMS/api/v2/registered/partsNo"
    headers_sms = headers.copy()
    headers_sms["X-TMC-Client-Id"] = os.environ["X_TMC_CLIENT_ID_SMS"]
    headers_sms["X-TMC-Client-secret"] = os.environ["X_TMC_CLIENT_SECRET_SMS"]
    headers_sms["X-TMC-ZDFW-USERID"] = os.environ["X_TMC_ZDFW_USERID_SMS"]
    headers_sms["X-TMC-ZDFW-COMPCODE"] = os.environ["X_TMC_ZDFW_COMPCODE_SMS"]
    # Response
    res_table_sms = res_table.copy()
    res_table_sms["database_name"] = eng_db
    res_table_sms["schema_name"] = pub_schema
    res_table_sms["table_name"] = "tmp_sms_api_parts_info_res_json"

    # リクエストデータ抽出
    request_body_df = api_util.get_request_data_from_snowflake(req_table_full_name)
    print(request_body_df)
    #パラメータが取得できた場合
    if len(json.loads(request_body_df.iat[0,0])["reqData"]) > 0:
      # Web-APIコール
      response_body_df = api_util.post_web_api_call_to_kitora(url, headers_sms, request_body_df, prod)
      print(response_body_df)
      # レスポンスデータ書き込み
      rows_inserted = api_util.put_response_data_to_snowflake(res_table_sms, response_body_df)
    #パラメータ取得できなかった場合
    else:
      rows_inserted = 0
      
    return rows_inserted

sms_api_parts_info_asset()