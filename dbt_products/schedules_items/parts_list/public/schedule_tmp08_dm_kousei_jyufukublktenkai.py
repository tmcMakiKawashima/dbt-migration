from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

# 現導入国データ(Ci-SPEC)　公開(tmp)
schedule_tmp08_dm_kousei_jyufukublktenkai = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_tmp08_dm_kousei_jyufukublktenkai",
    schedule_name="kousei_jyufukublktenkai_tmp",
    cron_schedule="00 07 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+tmp08_dm_kousei_jyufukublktenkai",
    dbt_exclude="dm_kousei_blktenkai tmp_junkanri_blktenkai stg_kouseicom",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_tmp08_dm_kousei_jyufukublktenkai"})
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_tmp08_dm_kousei_jyufukublktenkai"},
)