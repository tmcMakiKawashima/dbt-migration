from dagster_fivetran import (
    FivetranResource,
    build_fivetran_assets
)
from dagster import with_resources

# =================================================================================================
# asset_sample05の検証内容
# 1. fivetranの特定のインスタンスだけロードする方法
# =================================================================================================

# 1. FivetranResourceを取得する
# api_keyとapi_secretは一時的に直書き
fivetran_instance = FivetranResource(
    api_key="IDbTFbyXa880Q2L0",
    api_secret="Q59BbLofnpyTd4CdLJDhBPhRAabroypP",
)

# 1. Fivetanのコネクタをロードする
#    connector_idはFivetranの各コネクトのセットアップから確認する
#    destination_tablesは"スキーマ名.テーブル名"で指定する
#    group_nameはグループ名文字列を設定する
#    「pipeline01」でFivetran, dbt, Dagster assetをグルーピングし、センサー実行まで実装済み
#    センサー実行で動かしたところFivetran assetでエラーが発生したため調査中
fivetran_assets = with_resources(
    build_fivetran_assets(
        connector_id="superglue_phenol",
        destination_tables=["fivetran_db.dagster_poc"],
        group_name="pipeline01",
        infer_missing_tables = False
    ),
    {"fivetran": fivetran_instance},
)
