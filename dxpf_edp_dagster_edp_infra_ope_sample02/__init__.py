import os

from dagster import (
    Definitions,
    load_assets_from_modules,
    load_assets_from_package_module,
    define_asset_job,
    sensor,
    RunRequest,
    RunConfig,
    MaterializeResult,
    MetadataValue,
    asset,
    AssetSelection,
    ScheduleDefinition
)

from dagster_fivetran import (
    FivetranResource,
    load_assets_from_fivetran_instance
)

from dagster_dbt import DbtCliResource

from . import asset_sample08
from .asset_sample08.constants import dbt_project_dir
from . import asset_sample09
from . import asset_sample10

#############################
# 以下はすべて待ち行列検証のための一時的なコード
from . import asset_sample07
from dagster import op, job, Config, OpExecutionContext

asset_sample07_job = define_asset_job(name="asset_sample07_job", selection=AssetSelection.groups("asset_sample07"))

@sensor(job=asset_sample07_job, minimum_interval_seconds=400)
def asset_sample07_sensor():
    yield RunRequest(run_key=None, run_config={})

#############################

asset09_job = define_asset_job(name="asset09_job", selection=AssetSelection.groups("asset_sample09"))

# アラート用のタグを設定する
asset10_job = define_asset_job(name="asset10_job", selection=AssetSelection.groups("asset_sample10"), tags={"code_location": "sample02", "job_name": "asset_sample10"})

@sensor(job=asset09_job)
def asset09_sensor():
    yield RunRequest(run_key=None, run_config={})

@sensor(job=asset10_job)
def asset10_sensor():
    yield RunRequest(run_key=None, run_config={})

# Asset Groupの読み込み定義
# load_assets_from_package_module() = asset.pyに記述されたアセット全てロードする関数
# load_assets_from_modules() = モジュールで読み込んだ情報をアセットとしてロードする関数
defs = Definitions(
    assets
    = load_assets_from_package_module(asset_sample07)
    + load_assets_from_package_module(asset_sample08)
    + load_assets_from_package_module(asset_sample09)
    + load_assets_from_package_module(asset_sample10),
    jobs
    = [asset_sample07_job, asset09_job, asset10_job],
    sensors
    = [asset_sample07_sensor, asset09_sensor, asset10_sensor],
    resources
    ={"dbt": DbtCliResource(project_dir=os.fspath(dbt_project_dir))},
)
