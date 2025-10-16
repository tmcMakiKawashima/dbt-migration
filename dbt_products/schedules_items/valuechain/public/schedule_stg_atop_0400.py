from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# ATOP_0400
schedule_stg_atop_0400 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_atop_0400",
    schedule_name="ATOP_0400",
    cron_schedule="00 04 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_sonekikanri_atop +stg_sonekikanri_atop",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_atop_0400"},
                                    source_test_list=["source:*,stg_sonekikanri_atop",
                                                      "source:*,stg_ukeirejisseki_atop"])
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_atop_0400"},
)