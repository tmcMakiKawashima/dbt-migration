import json
import os
from dagster import AssetExecutionContext, Config
from dagster_dbt import DbtCliResource, dbt_assets

from .constants import dbt_manifest_path


class DbtConfig(Config):
    # 環境変数にdbt test実行結果格納のスキーマ指定用の値を設定
    dbt_vars: dict = {
        "DBT_JOB_NAME": ""
    }
    # dbt test --select source:* で指定する範囲を設定
    source_test_list: list = []


@dbt_assets(manifest=dbt_manifest_path)
def dbt_products_assets(context: AssetExecutionContext, dbt: DbtCliResource, config: DbtConfig):
    # dbt test --select source:* 実行
    if len(config.source_test_list) > 0:
        dbt_test_args = ["test", "--select"]
        dbt_test_args += config.source_test_list
        dbt_test_args += ["--target", os.getenv('dbt_profile_enterprise')]
        # エラー出力用schemaの指定
        if len(config.dbt_vars["DBT_JOB_NAME"]) > 0:
            dbt_test_args += ["--vars", json.dumps(config.dbt_vars)]
        yield from dbt.cli(dbt_test_args, manifest=dbt_manifest_path).stream()
        
    # dbt build 実行
    dbt_build_args = ["build"]
    dbt_build_args += ["--target", os.getenv('dbt_profile_enterprise')]
        # エラー出力用schemaの指定
    if len(config.dbt_vars["DBT_JOB_NAME"]) > 0:
        dbt_build_args += ["--vars", json.dumps(config.dbt_vars)]
    yield from dbt.cli(dbt_build_args, context=context).stream()


# @dbt_assets(manifest=dbt_manifest_path)
# def dbt_products_assets(context: AssetExecutionContext, dbt: DbtCliResource):
#     yield from dbt.cli(["build"], context=context).stream()
    