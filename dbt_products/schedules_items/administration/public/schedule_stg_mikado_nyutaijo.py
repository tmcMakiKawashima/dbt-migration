from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

# MIKADO 入退場システム
schedule_stg_mikado_nyutaijo = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_mikado_nyutaijo",
    schedule_name="MIKADO_NYUTAIJO",
    cron_schedule="30 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_nyutaijo",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_mikado_nyutaijo"},
                                    source_test_list=["source:*,+stg_nyutaijo"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_mikado_nyutaijo"},
)
