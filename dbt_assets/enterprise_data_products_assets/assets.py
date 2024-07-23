import json
from dagster import AssetExecutionContext, Config
from dagster_dbt import DbtCliResource, dbt_assets

from .constants import dbt_manifest_path


class DbtConfig(Config):
    dbt_vars: dict = {
        "DBT_JOB_NAME": ""
    }


@dbt_assets(manifest=dbt_manifest_path)
def dbt_products_assets(context: AssetExecutionContext, dbt: DbtCliResource, config: DbtConfig):
    dbt_build_args = ["build"]
    if len(config.dbt_vars["DBT_JOB_NAME"]) > 0:
        dbt_build_args += ["--vars", json.dumps(config.dbt_vars)]
    yield from dbt.cli(dbt_build_args, context=context).stream()


# @dbt_assets(manifest=dbt_manifest_path)
# def dbt_products_assets(context: AssetExecutionContext, dbt: DbtCliResource):
#     yield from dbt.cli(["build"], context=context).stream()
    