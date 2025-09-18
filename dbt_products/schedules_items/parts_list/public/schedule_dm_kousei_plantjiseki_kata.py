from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 品番工場生産実績(搭載型式)
schedule_dm_kousei_plantjiseki_kata = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_kousei_plantjiseki_kata",
    schedule_name="kousei_plantjiseki_kata",
    cron_schedule="00 12 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+dm_kousei_plantjiseki_kata",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_kousei_plantjiseki_kata"})
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_dm_kousei_plantjiseki_kata"},
)
