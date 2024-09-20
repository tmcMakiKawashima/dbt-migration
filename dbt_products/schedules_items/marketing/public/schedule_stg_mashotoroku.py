from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# RISM 連携IF変更
schedule_stg_mashotoroku = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_mashotoroku",
    schedule_name="RISM_RENKEI_IF_HENKO",
    cron_schedule="45 10 * * 1,2,3,4,5",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_mashotoroku",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_mashotoroku"},
                                    source_test_list=["source:*,+stg_mashotoroku"])
                          }
                     ),
    default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_mashotoroku"},
)
