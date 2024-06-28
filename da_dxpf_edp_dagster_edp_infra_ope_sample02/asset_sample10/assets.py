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
# asset_sample10の検証内容
# 1. アラートの設定を確認
#    ジョブにTagsを付けることでアラートを出すターゲットを絞れることを確認する
# =================================================================================================

@asset(group_name="asset_sample10")
def asset10_04(context):
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(group_name="asset_sample10", deps=["asset10_04"])
def asset10_05(context):
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(group_name="asset_sample10", deps=["asset10_05"])
def asset10_06(context):
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )