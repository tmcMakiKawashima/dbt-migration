from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# GCAS
schedule_stg_gcas = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_gcas",
    schedule_name="gcas",
    cron_schedule="30 10,13,15,17 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_syasyusiji_gcas +stg_hinmokuhiki_gcas",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_gcas"})
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_gcas"},
)