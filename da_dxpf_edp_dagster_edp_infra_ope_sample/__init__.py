from dagster import (
    Definitions,
    load_assets_from_modules,
    load_assets_from_package_module,
)

from da_dxpf_edp_dagster_edp_infra_ope_sample import asset_sample01

defs = Definitions(
    assets=load_assets_from_package_module(asset_sample01),
)
