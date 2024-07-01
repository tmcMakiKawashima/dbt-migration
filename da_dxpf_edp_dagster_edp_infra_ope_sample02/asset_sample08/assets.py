import base64
import json
import os
from io import BytesIO
from pathlib import Path
from dagster import ( 
    MaterializeResult,
    MetadataValue,
    asset,
    SourceAsset,
    AssetKey,
    AssetExecutionContext
)

from dagster_dbt import (
    DbtCliResource,
    dbt_assets,
    get_asset_key_for_model,
    DagsterDbtTranslator
)
from .constants import dbt_manifest_path

from typing import Any, Mapping

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


class CustomeizedDagsterDbtTranslator(DagsterDbtTranslator):
    def get_asset_key(self, dbt_resource_props: Mapping[str, Any]) -> AssetKey:
        return super().get_asset_key(dbt_resource_props).with_prefix(os.getenv("code_location_sample02"))

@dbt_assets(manifest=dbt_manifest_path, dagster_dbt_translator=CustomeizedDagsterDbtTranslator())
def dbt_model_exeute(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["run"], context=context).stream()


# asset08_01 = SourceAsset(key=AssetKey("asset08_01")) 
# @asset(group_name="asset_sample08", deps=[asset08_01], key_prefix=[os.getenv("code_location_sample02")])
# def asset08_02() -> MaterializeResult:
#     return MaterializeResult(
#         metadata={
#             "test": "1,2,3"
#         }
#     )