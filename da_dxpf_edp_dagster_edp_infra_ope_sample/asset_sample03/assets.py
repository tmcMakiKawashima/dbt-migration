import base64
import json
import os
from io import BytesIO
from pathlib import Path

#import matplotlib.pyplot as plt
#import pandas as pd
#import requests
from dagster import AssetExecutionContext, MaterializeResult, asset
from dagster_dbt import DbtCliResource, dbt_assets

from .constants import dbt_manifest_path

# key_prefixは階層を表す prefixはアセットの一つ上の階層までを表す
# 階層凡例=group名/asset名(関数名)
# 階層具体例=asset_sample03 / asset03
@asset(group_name="asset_sample03", description="パイプライン用アセット", key_prefix=["public"])
def asset03() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

@dbt_assets(manifest=dbt_manifest_path)
def dbt_model_exeute(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()