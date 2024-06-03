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
# =================================================================================================

@asset(group_name="asset_sample06")
def asset06_01() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(group_name="asset_sample06", deps=[asset06_01])
def asset06_02() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(group_name="asset_sample06", key_prefix=["edp_db"])
def asset06_03() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(group_name="asset_sample06", deps=["asset06_02", "my_fifth_dbt_model"])
def asset06_04() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3,4"
        }
    )