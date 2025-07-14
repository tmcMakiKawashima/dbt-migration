from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# PIXY_Web公開
schedule_stg_pixy_web = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_pixy_web",
    schedule_name="pixy_web",
    cron_schedule="30 19 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_lineupmaster_pixy_view +stg_categorymaster_pixy_view +stg_tagmaster_pixy_view +stg_sethinlineupmaster_pixy_view +stg_tagjoho_pixy_view",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_pixy_web"})
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_pixy_web"},
)