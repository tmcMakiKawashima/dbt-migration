import base64
import json
import os
from io import BytesIO
from pathlib import Path
from dagster import ( 
    MaterializeResult,
    MetadataValue,
    asset,
    RunRequest,
    EnvVar
)

# =================================================================================================
# asset_sample09の検証内容
# 1. 環境変数の取り込み方を確認
#    環境変数の定義
#      ローカル環境は.envファイルに定義する
#      クラウド環境はUIから手動で登録する
#    環境変数へのアクセス
#      方法が2つあるので差異がないか確認
# =================================================================================================

@asset(
    group_name="asset_sample09", 
    description="環境変数取得サンプル3", 
    key_prefix=[os.getenv("code_location_sample01")])
def asset09_01(context):
    return MaterializeResult(
        metadata={
            "getenv_1": os.getenv("code_location_sample01"),
            "envvar_2": EnvVar("code_location_sample02").get_value()
        }
    )