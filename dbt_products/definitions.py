import os

from dagster import Definitions, EnvVar
from dagster_dbt import DbtCliResource
from dagster_snowflake import SnowflakeResource

from .enterprise_data_products_assets.assets import dbt_products_assets
from .enterprise_data_products_assets.constants import dbt_project_dir
from .schedules import schedules
from .assets import assets
from .sensors import sensors

defs = Definitions(
    assets=assets,
    schedules=schedules,
    resources={
        "dbt": DbtCliResource(project_dir=os.fspath(dbt_project_dir)),
        'snowflake': SnowflakeResource(
            account=os.getenv("DBT_SNOWFLAKE_ACCOUNT"),
            user=os.getenv("DBT_SNOWFLAKE_USER"),
            password=EnvVar('DBT_SNOWFLAKE_PASS'),
            role=os.getenv("DBT_SNOWFLAKE_ROLE"),
    },
    sensors=sensors
)