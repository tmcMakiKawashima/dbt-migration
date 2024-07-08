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
#    dxpf_edp_dagster_edp_infra_ope_sample01にも同名のアセット、ジョブを用意しTagsで絞られていることを確認する
# =================================================================================================

@asset(
    group_name="asset_sample10", 
    description="jobにTagsを定義しているアセット", 
    key_prefix=os.getenv("layer_sample02"))
def asset10_01(context):
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(
    group_name="asset_sample10", 
    description="jobにTagsを定義しているアセット", 
    key_prefix=os.getenv("layer_sample02"), 
    deps=["asset10_01"])
def asset10_02(context):
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@asset(
    group_name="asset_sample10", 
    description="jobにTagsを定義しているアセット", 
    key_prefix=os.getenv("layer_sample02"), 
    deps=["asset10_02"])
def asset10_03(context):
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )