from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# D層補給SMS_0600
schedule_d_hokyusms_0600 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_hokyusms_0600",
    schedule_name="D_SOU_HOKYUSMS_0600",
    cron_schedule="00 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_kyoku_hokyusms",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_hokyusms_0600"},
                                    source_test_list=["source:*,+stg_kyoku_hokyusms"])
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_d_hokyusms_0600"},
)
