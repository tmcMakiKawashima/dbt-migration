from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 用品品番明細
schedule_stg_yohinhinbanmeisai = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_yohinhinbanmeisai",
    schedule_name="YOHINHINBANMEISAI",
    cron_schedule="30 02 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_yohinhinbanmeisai",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_yohinhinbanmeisai"},
                                    source_test_list=["source:*,+stg_yohinhinbanmeisai"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_yohinhinbanmeisai"},
)
