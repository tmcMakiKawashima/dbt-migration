from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# VIN x 車両情報（車種コード指定なし）
schedule_dm_vin_model_nonesyasyu = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_vin_model_nonesyasyu",
    schedule_name="VIN_SYARYOJOHO_NONESYASYU",
    cron_schedule="00 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="tmp10_dm_vin_model_nonesyasyu tmp20_dm_vin_model_nonesyasyu dm_vin_model_nonesyasyu",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_vin_model_nonesyasyu"})
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_dm_vin_model_nonesyasyu"},
)
