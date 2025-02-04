from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# D層SIAS
schedule_d_sias = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_sias",
    schedule_name="D_SOU_SIAS",
    cron_schedule="00 05 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_riyosyasyusedai +stg_riyoframemaster",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_sias"},
                                    source_test_list=["source:*,+stg_riyosyasyusedai",
                                                      "source:*,+stg_riyoframemaster"])
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_d_sias"},
)