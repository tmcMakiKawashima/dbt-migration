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
#    ローカル環境は.envファイルに定義されている環境変数が読み込まれる
#    環境変数へのアクセスの方法が2つある
#    os.getenv, EnvVar
# =================================================================================================

@asset(group_name="asset_sample09")
def asset09_01(context):
    return MaterializeResult(
        metadata={
            "getenv_1": os.getenv("env_1"),
            "envvar_2": EnvVar("env_2").get_value()
        }
    )