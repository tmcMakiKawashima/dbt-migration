import base64
import json
import os
from io import BytesIO
from pathlib import Path

from dagster import (
    AssetExecutionContext,
    MaterializeResult,
    asset,
    AssetKey
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
# asset_sample03の検証内容
# 1. dbtモデルのmanifest.jsonを読み込む方法
# 2. dbtモデルをdagsterアセットとしてロードする方法(dbtモデル側の記述方法は本プロジェクト内の「dagster_dbt」フォルダ参照のこと)
# 3. dbtモデルのアップストリームとしてdagster独自アセットを設定する方法(dbtモデル側の記述方法は本プロジェクト内の「dagster_dbt」フォルダ参照のこと)
# 4. dbtモデルのダウンストリームとしてdagster独自アセットを設定する方法(dbtモデル側の記述方法は本プロジェクト内の「dagster_dbt」フォルダ参照のこと)
# =================================================================================================

# 1. dbtモデルのmanifest.jsonを読み込む方法
# 同フォルダ内の「constants.py」参照のこと

# 2. dbtモデルをdagsterアセットとしてロードする方法
# CustomeizedDagsterDbtTranslatorは@dbt_assetsにアセットキー(dagster_dbt_translator)を付与するために定義している
# os.getenv("code_location_sample01")で環境変数を取得しアセットキーとしてreturnしている
class CustomeizedDagsterDbtTranslator(DagsterDbtTranslator):
    def get_asset_key(self, dbt_resource_props: Mapping[str, Any]) -> AssetKey:
        return super().get_asset_key(dbt_resource_props).with_prefix(os.getenv("code_location_sample01"))

@dbt_assets(manifest=dbt_manifest_path, dagster_dbt_translator=CustomeizedDagsterDbtTranslator())
def dbt_model_exeute(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["run", "--target", os.getenv('dbt_profile_sample')], context=context).stream()

# 3. dbtモデルのアップストリームとしてdagster独自アセットを設定する方法 (asset03_01 → snowflake_connect.sql)
# key_prefixは階層を表す prefixはアセットの一つ上の階層までを表す
# 階層凡例 = group名/asset名(関数名)
# 階層具体例 = asset_sample03 / asset03
# dbtモデルのアップストリームとしてdagster独自アセットを設定する場合は手動でテーブルを作る必要がある。(データベース名の指定がない場合の例)
#    snowflake_connectがアップストリーム(asset03_01)テーブルを必要とするため
# テーブルの作成場所およびテーブル名称は以下の通り
# データベース名、スキーマ名、テーブル名はsources.yml
@asset(
    group_name="asset_sample03", 
    description="パイプライン用アセット",
    key_prefix=[os.getenv("code_location_sample01"), os.getenv("dbt_resource_edp")])
def asset03_01() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )

# 4. dbtモデルのダウンストリームとしてdagster独自アセットを設定する方法
@asset(
    group_name="pipeline01", 
    description="パイプライン用アセット", 
    deps={get_asset_key_for_model([dbt_model_exeute], "my_second_dbt_model")}, 
    key_prefix=[os.getenv("code_location_sample01")])
def asset03_02() -> MaterializeResult:
    return MaterializeResult(
        metadata={
            "test": "1,2,3"
        }
    )