from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

# バリエーション台数
schedule_dm_variation_seisan_daisu = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_variation_seisan_daisu",
    schedule_name="variation_seisan_daisu",
    cron_schedule="00 09 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+dm_variation_seisan_daisu",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_variation_seisan_daisuc"})
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_dm_variation_seisan_daisu"},
)