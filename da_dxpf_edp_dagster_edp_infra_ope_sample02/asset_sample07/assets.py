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
from dagster import AutoMaterializePolicy, AutoMaterializeRule

# =================================================================================================
# asset_sample07の検証内容
# 1. 待ち行列の検証
# =================================================================================================

@asset(group_name="asset_sample07")
def asset07_01() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

def asset_sample07_sensor():
    for filename in os.listdir(MY_DIRECTORY):
        filepath = os.path.join(MY_DIRECTORY, filename)
        if os.path.isfile(filepath):
            yield RunRequest(
                run_key=filename,
            )

@asset(group_name="asset_sample07", deps=["asset07_01"])
def asset07_02() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(group_name="asset_sample07")
def asset07_03() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(group_name="asset_sample07", deps=["asset07_03"])
def asset07_04() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

# 待ち行列検証用コード(調査中のためコメントアウト)
# wait_for_all_parents_policy = AutoMaterializePolicy.eager().with_rules(
#     AutoMaterializeRule.skip_on_not_all_parents_updated()
# )
# @asset(group_name="asset_sample07", deps=["asset07_02", "asset07_04"], auto_materialize_policy=wait_for_all_parents_policy)

@asset(group_name="asset_sample07", deps=["asset07_02", "asset07_04"])
def asset07_05() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )



