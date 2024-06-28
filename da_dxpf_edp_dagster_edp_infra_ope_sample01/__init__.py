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

from da_dxpf_edp_dagster_edp_infra_ope_sample01 import asset_sample01
from da_dxpf_edp_dagster_edp_infra_ope_sample01 import asset_sample02
from da_dxpf_edp_dagster_edp_infra_ope_sample01 import asset_sample03
from da_dxpf_edp_dagster_edp_infra_ope_sample01 import asset_sample04
from .asset_sample03.constants import dbt_project_dir
from .asset_sample05 import fivetran_assets
from da_dxpf_edp_dagster_edp_infra_ope_sample01 import asset_sample06
from da_dxpf_edp_dagster_edp_infra_ope_sample01 import asset_sample09
from da_dxpf_edp_dagster_edp_infra_ope_sample01 import asset_sample10

# ジョブ設定
# 全てのジョブを1つのセンサーに紐づけ
#all_assets_job = define_asset_job(name="all_assets_job")

# 個別アセットとジョブ定義を1:1で紐づけ
# asset04_01_job = define_asset_job(name="asset04_01_job", selection="asset04_01")

# 個別アセットとジョブ定義を1:nで紐づけ
# asset04_01_job = define_asset_job(name="asset04_01_job", selection=["asset04_01", "asset04_02"])

# 個別アセットとジョブ定義をグループで紐づけ
asset04_job = define_asset_job(name="asset04_job", selection=AssetSelection.groups("asset_sample04"))

# dbtモデルをjob化する
asset03_dbt_job = define_asset_job(name="asset03_dbt_job", selection=["my_third_dbt_model", "my_fourth_dbt_model"])

# 起動順序検証用アセットをjob化する
asset06_job = define_asset_job(name="asset06_job", selection=AssetSelection.groups("asset_sample06"), tags={"ecs/cpu": "256", "ecs/memory": "1024"})

# Fivetran, dbt, Dagster assetをまとめてjob化する
pipeline01_job = define_asset_job(name="pipeline01_job", selection=AssetSelection.groups("pipeline01"))

# アラート用のタグを設定する
asset10_job = define_asset_job(name="asset10_job", selection=AssetSelection.groups("asset_sample10"), tags={"code_location": "sample01", "job_name": "asset_sample10"})

# センサー定義(デフォルト30秒)
@sensor(job=asset04_job)
def asset04_01_sensor():
    yield RunRequest(run_key=None, run_config={})

# センサー定義(間隔指定※秒で指定、最小値5秒)
@sensor(job=asset04_job, minimum_interval_seconds=400)
def asset04_02_sensor():
    yield RunRequest(run_key=None, run_config={})

@sensor(job=asset10_job)
def asset10_sensor():
    yield RunRequest(run_key=None, run_config={})

# スケジュール定義
asset03_dbt_job_schedule = ScheduleDefinition(job=asset03_dbt_job, cron_schedule="*/5 * * * *", execution_timezone="Asia/Tokyo")
asset06_job_schedule = ScheduleDefinition(job=asset06_job, cron_schedule="*/5 * * * *", execution_timezone="Asia/Tokyo")
pipeline01_job_schedule = ScheduleDefinition(job=pipeline01_job, cron_schedule="*/10 * * * *", execution_timezone="Asia/Tokyo")

# Asset Groupの読み込み定義
# load_assets_from_package_module() = asset.pyに記述されたアセット全てロードする関数
# load_assets_from_modules() = モジュールで読み込んだ情報をアセットとしてロードする関数
defs = Definitions(
    assets
    = load_assets_from_package_module(asset_sample01)
    + load_assets_from_package_module(asset_sample02)
    + load_assets_from_package_module(asset_sample03)
    + load_assets_from_package_module(asset_sample04)
    + load_assets_from_modules([fivetran_assets])
    + load_assets_from_package_module(asset_sample06)
    + load_assets_from_package_module(asset_sample09)
    + load_assets_from_package_module(asset_sample10),
    jobs
    = [asset04_job, asset03_dbt_job, pipeline01_job, asset10_job],
    sensors
    = [asset04_01_sensor, asset04_02_sensor, asset10_sensor],
    schedules
    = [asset03_dbt_job_schedule, asset06_job_schedule, pipeline01_job_schedule],
    resources
    ={"dbt": DbtCliResource(project_dir=os.fspath(dbt_project_dir))},
)
