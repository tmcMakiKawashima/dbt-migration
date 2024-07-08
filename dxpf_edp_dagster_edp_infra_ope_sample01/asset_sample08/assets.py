import base64
import json
import os
from io import BytesIO
from pathlib import Path
from dagster import ( 
    MaterializeResult,
    MetadataValue,
    asset,
    RunRequest
)

from dagster_dbt import (
    DbtCliResource,
    dbt_assets,
    get_asset_key_for_model
)

# =================================================================================================
# 検証中
# asset_sample08の検証内容
# 1. code locationをまたぐリネージュ
#    以下の4パターンを検証する
#       code location1 / code location2
#    1. Dagster アセット → Dagster アセット
#    2. dbt モデル → Dagster アセット
#    3. Dagster アセット → dbt モデル
#    4. dbt モデル → dbt モデル
#
#    やり方は検証でき次第追記
# =================================================================================================

@asset(
    group_name="asset_sample08", 
    description="(検証中)code_locationをまたぐリネージュ用サンプル1", 
    key_prefix=[os.getenv("layer_sample01")])
def asset08_01() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

# @asset(group_name="asset_sample08", deps=["my_sixth_dbt_model"], key_prefix=[os.getenv("layer_sample01")])
# def asset08_03() -> MaterializeResult:
#     return MaterializeResult(
#         metadata={
#             "test": "1,2,3"
#         }
#     )