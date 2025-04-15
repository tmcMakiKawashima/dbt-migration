from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))


# kodomo
schedule_stg_kodomo = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_kodomo",
    schedule_name="KODOMO",
    cron_schedule="00 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_seiyakuformat_kodomo",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_kodomo"},
                                    source_test_list=["source:*,+stg_seiyakuformat_kodomo"])
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_kodomo"},
)