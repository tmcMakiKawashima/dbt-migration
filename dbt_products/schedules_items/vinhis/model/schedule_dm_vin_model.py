from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# VIN x 車両情報
schedule_dm_vin_model = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_vin_model",
    schedule_name="VIN_SYARYOJOHO",
    cron_schedule="00 05 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+dm_vin_model",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_vin_model"},
                                    source_test_list=["source:*,+dm_vin_model"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_dm_vin_model"},
)
