from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 従業員情報   
schedule_dm_jugyoinjoho = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_jugyoinjoho",
    schedule_name="JUGYOINJOHO",
    cron_schedule="00 03 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+dm_empmasterknm_view +dm_empmastershm_view",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_jugyoinjoho"})
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_dm_jugyoinjoho"},
)