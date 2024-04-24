from dagster import (
    Definitions,
    load_assets_from_modules,
    load_assets_from_package_module,
)

from da_dxpf_edp_dagster_edp_infra_ope_sample import asset_sample01
from da_dxpf_edp_dagster_edp_infra_ope_sample import asset_sample02
from da_dxpf_edp_dagster_edp_infra_ope_sample import asset_sample03

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

# Asset Groupの読み込み定義
defs = Definitions(
    assets
    = load_assets_from_package_module(asset_sample01)
    + load_assets_from_package_module(asset_sample02)
    + load_assets_from_package_module(asset_sample03),
)
