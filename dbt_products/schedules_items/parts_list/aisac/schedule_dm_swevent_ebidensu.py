from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# イベント変更内容一覧_車種
schedule_dm_swevent_ebidensu = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_swevent_ebidensu",
    schedule_name="swevent_ebidensu",
    cron_schedule="00 05 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+dm_swevent_ebidensu",
    dbt_exclude="stg_syasyu",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_swevent_ebidensu"})
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_dm_swevent_ebidensu"},
)
