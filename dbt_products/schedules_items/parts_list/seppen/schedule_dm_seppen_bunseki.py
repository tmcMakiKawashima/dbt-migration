from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

# 認証不正防止対応(設変分析)
schedule_dm_seppen_bunseki = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_seppen_bunseki",
    schedule_name="seppen_bunseki",
    cron_schedule="00 07 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+dm_hinban_all +dm_yousi_all +dm_zokusei_all +dm_tekiyohani_all",
    dbt_exclude="stg_syasyu",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_seppen_bunseki"})
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_dm_seppen_bunseki"},
)