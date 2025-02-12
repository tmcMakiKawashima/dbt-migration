import os

from dagster import Definitions, EnvVar
from dagster_dbt import DbtCliResource
from dagster_snowflake import SnowflakeResource

from .enterprise_data_products_assets.assets import dbt_products_assets
from .enterprise_data_products_assets.constants import dbt_project_dir
from .schedules import schedules

defs = Definitions(
    assets=[dbt_products_assets],
    schedules=schedules,
    resources={
        "dbt": DbtCliResource(project_dir=os.fspath(dbt_project_dir)),
    },
)