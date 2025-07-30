from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# GCAS_2
schedule_stg_gcas_2 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_gcas_2",
    schedule_name="gcas_2",
    cron_schedule="30 19 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_syasyufuzoku_gcas +stg_irofuzoku_gcas +stg_yohinfuzoku_gcas",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_gcas_2"})
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_gcas_2"},
)