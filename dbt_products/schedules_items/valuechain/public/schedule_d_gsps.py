from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# D層GSPS
schedule_d_gsps = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_gsps",
    schedule_name="D_SOU_GSPS",
    cron_schedule="00 02 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_kiken +stg_hazmat +stg_ykiken +stg_tikisyasyu_gsps +stg_hinbansyasyu_gsps",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_gsps"})
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_d_gsps"},
)
