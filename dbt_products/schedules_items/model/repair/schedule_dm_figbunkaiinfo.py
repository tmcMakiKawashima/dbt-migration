from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# FIG分解情報
schedule_dm_figbunkaiinfo = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_figbunkaiinfo",
    schedule_name="FIGBUNKAIJOHO",
    cron_schedule="00 05 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+dm_figbunkaiinfo",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_figbunkaiinfo"},
                                    source_test_list=["source:*,+dm_figbunkaiinfo"])
                          }
                     ),
    default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_dm_figbunkaiinfo"},
)
