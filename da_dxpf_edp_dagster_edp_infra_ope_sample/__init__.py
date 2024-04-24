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
    asset
)

from da_dxpf_edp_dagster_edp_infra_ope_sample import asset_sample01
from da_dxpf_edp_dagster_edp_infra_ope_sample import asset_sample02
from da_dxpf_edp_dagster_edp_infra_ope_sample import asset_sample03
from da_dxpf_edp_dagster_edp_infra_ope_sample import asset_sample04

# dagsterの構造
#
# Deployment = da_dxpf_edp_dagster_edp_infra_ope_sample
#
# Asset Group(assetの名称は重複できない)※Asset Groupはname spaceではない
#  group1 : asset_sample01
#       asset1 : asset01
#
#  group2 : asset_sample02
#       asset1 : asset02
#
#  group3 : asset_sample03
#       dbtプロジェクトロード
#
#  group4 : asset_sample04
#       asset1 : asset04_1(センサー実行サンプル用1) / 先発
#       asset2 : asset04_2(センサー実行サンプル用2) / 後発

# ジョブの設定

# 全てのジョブを1つのセンサーに紐づけ
#all_assets_job = define_asset_job(name="all_assets_job")

# 個別アセットとセンサー定義を1:1で紐づけ
asset04_01_job = define_asset_job(name="asset04_01_job", selection="asset04_01")

# センサー定義
@sensor(job=asset04_01_job)
def asset04_01_sensor():
    yield RunRequest(run_key=None, run_config={})

# Asset Groupの読み込み定義
defs = Definitions(
    assets
    = load_assets_from_package_module(asset_sample01)
    + load_assets_from_package_module(asset_sample02)
    + load_assets_from_package_module(asset_sample03)
    + load_assets_from_package_module(asset_sample04),
    jobs
    = [asset04_01_job],
    sensors
    = [asset04_01_sensor],
)
