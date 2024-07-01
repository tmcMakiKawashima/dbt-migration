import base64
import json
import os
from io import BytesIO
from pathlib import Path
from dagster import ( 
    MaterializeResult,
    MetadataValue,
    asset
)

from dagster_dbt import get_asset_key_for_model

# =================================================================================================
# asset_sample06の検証内容
# 1. アセットの処理順序性を確認する
#    asset06_04のアップストリームを2つ設定する
#    アップストリームが2つとも完了したのちにasset06_04が起動すること 
#    パイプライン1:(1)asset06_01 → (2)asset06_02
#    パイプライン2:(1)asset06_03 → (2)my_fifth_dbt_model
#    パイプライン1とパイプライン2の(2)が終わったらasset06_04が実行されるを確認する
#    my_fifth_dbt_modelのSnowflake認証をあえて失敗することで実行順序の確認が取れる
# =================================================================================================

@asset(
    group_name="asset_sample06",
    description="処理順序性サンプル1",
    key_prefix=[os.getenv("code_location_sample01")])
def asset06_01() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(
    group_name="asset_sample06", 
    description="処理順序性サンプル2", 
    deps=[asset06_01], 
    key_prefix=[os.getenv("code_location_sample01")])
def asset06_02() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

# my_fifth_dbt_modelのアップストリーム
@asset(
    group_name="asset_sample06", 
    description="処理順序性サンプル3", 
    key_prefix=[os.getenv("code_location_sample01"),"edp_db"])
def asset06_03() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(
    group_name="asset_sample06", 
    description="処理順序性サンプル4", 
    deps=["asset06_02", "my_fifth_dbt_model"], 
    key_prefix=[os.getenv("code_location_sample01")])
def asset06_04() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3,4"
        }
    )