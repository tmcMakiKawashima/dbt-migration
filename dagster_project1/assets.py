from pathlib import Path
from dagster import MaterializeResult, asset, AssetExecutionContext
from dagster_dbt import DbtCliResource, dbt_assets


@asset(group_name="asset_sample1")
def asset01() -> MaterializeResult:
    return MaterializeResult(
        matedata={
            "test": "1,2,3"
        }
    )


@dbt_assets(manifest=Path("dbt_project","target","manifest.json"))
def dbt_model_exeute(context: AssetExecutionContext):
    dbt = DbtCliResource(Path("dbt_project"))
    yield from dbt.cli(["run"], context=context).stream()
    
     



