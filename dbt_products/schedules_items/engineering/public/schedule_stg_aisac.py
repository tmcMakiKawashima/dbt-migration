from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

# AISAC
schedule_stg_aisac = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_aisac",
    schedule_name="aisac",
    cron_schedule="00 04 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_syasyu",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_aisac"},
                                    source_test_list=["source:*,+stg_syasyu"])
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_aisac"},
)
