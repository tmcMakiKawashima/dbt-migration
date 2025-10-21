from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 車両INDEX
schedule_stg_syaryoindex = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_syaryoindex",
    schedule_name="SYARYO_INDEX",
    cron_schedule="00 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_syaryoindex +stg_seisanjisseki +stg_buhinserialno",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_syaryoindex"},
                                    source_test_list=["source:*,+stg_syaryoindex",
                                                      "source:*,+stg_seisanjisseki",
                                                      "source:*,+stg_buhinserialno"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_syaryoindex"},
)
