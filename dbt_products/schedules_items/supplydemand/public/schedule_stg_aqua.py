from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# AQUA
schedule_stg_aqua = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_aqua",
    schedule_name="AQUA",
    cron_schedule="30 05 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_haisya +stg_kaigaitp +stg_kokunaitp +stg_konpou +stg_seisankeikaku",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_aqua"},
                                    source_test_list=["source:*,+stg_haisya",
                                                      "source:*,+stg_kaigaitp",
                                                      "source:*,+stg_kokunaitp",
                                                      "source:*,+stg_konpou",
                                                      "source:*,+stg_seisankeikaku"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_aqua"},
)
