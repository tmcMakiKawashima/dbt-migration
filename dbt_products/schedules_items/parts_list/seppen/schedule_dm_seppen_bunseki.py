from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

# SEPPEN_BUNSEKI
schedule_dm_seppen_bunseki = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_hinban_all",
    schedule_name="seppen_bunseki",
    cron_schedule="00 07 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+dm_hinban_all",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_hinban_all"},
                                    source_test_list=["source:*,+dm_hinban_all"])
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_dm_hinban_all"},
)
