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

# 以下はすべて待ち行列検証のための一時的なコード
from da_dxpf_edp_dagster_edp_infra_ope_sample02 import asset_sample07
from dagster import op, job, Config, OpExecutionContext

MY_DIRECTORY = "D:\\Users\\da-misawa-04.00\\dagster\\da-dxpf-edp-dagster-edp_infra_ope-sample\\da_dxpf_edp_dagster_edp_infra_ope_sample01"
MY_DIRECTORY2 = "D:\\Users\\da-misawa-04.00\\dagster\\da-dxpf-edp-dagster-edp_infra_ope-sample\\da_dxpf_edp_dagster_edp_infra_ope_sample02" 

asset_sample07_job = define_asset_job(name="asset_sample07_job", selection=AssetSelection.groups("asset_sample07"))

@sensor(job=asset_sample07_job)
def asset_sample07_sensor():
    for filename in os.listdir(MY_DIRECTORY):
        filepath = os.path.join(MY_DIRECTORY, filename)
        if os.path.isfile(filepath):
            yield RunRequest(
                run_key=filename,
            )

asset_sample07_1_job = define_asset_job(name="asset_sample07_1_job", selection=["asset07_01", "asset07_02"])
asset_sample07_2_job = define_asset_job(name="asset_sample07_2_job", selection=["asset07_03", "asset07_04"])

@sensor(job=asset_sample07_1_job)
def asset_sample07_1_sensor():
    for filename in os.listdir(MY_DIRECTORY):
        filepath = os.path.join(MY_DIRECTORY, filename)
        if os.path.isfile(filepath):
            yield RunRequest(
                run_key=filename,
            )

@sensor(job=asset_sample07_2_job)
def asset_sample07_2_sensor():
    for filename in os.listdir(MY_DIRECTORY2):
        filepath = os.path.join(MY_DIRECTORY2, filename)
        if os.path.isfile(filepath):
            yield RunRequest(
                run_key=filename,
            )

# Asset Groupの読み込み定義
# load_assets_from_package_module() = asset.pyに記述されたアセット全てロードする関数
# load_assets_from_modules() = モジュールで読み込んだ情報をアセットとしてロードする関数
defs = Definitions(
    assets
    = load_assets_from_package_module(asset_sample07),
    jobs
    = [asset_sample07_job, asset_sample07_1_job, asset_sample07_2_job],
    sensors
    = [asset_sample07_sensor, asset_sample07_1_sensor, asset_sample07_2_sensor],
)
