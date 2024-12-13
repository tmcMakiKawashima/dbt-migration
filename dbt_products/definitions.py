import os

from dagster import Definitions
from dagster_dbt import DbtCliResource

from .enterprise_data_products_assets.assets import dbt_products_assets, source_table_freshness_checks
from .enterprise_data_products_assets.constants import dbt_project_dir
from .schedules import schedules

defs = Definitions(
    assets=[dbt_products_assets],
    asset_checks=source_table_freshness_checks,
    schedules=schedules,
    resources={
        "dbt": DbtCliResource(project_dir=os.fspath(dbt_project_dir)),
    },
)