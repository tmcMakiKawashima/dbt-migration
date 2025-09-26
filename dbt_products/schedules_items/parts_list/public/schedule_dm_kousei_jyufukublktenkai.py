from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

# 現導入国データ(Ci-SPEC)　公開
schedule_dm_kousei_jyufukublktenkai = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_kousei_jyufukublktenkai",
    schedule_name="dm_kousei_jyufukublktenkai",
    cron_schedule="00 08 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+dm_kousei_jyufukublktenkai +tmp_junkanri_jyufukublktenkai",
    dbt_exclude="tmp08_dm_kousei_jyufukublktenkai",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_kousei_jyufukublktenkai"})
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_dm_kousei_jyufukublktenkai"},
)