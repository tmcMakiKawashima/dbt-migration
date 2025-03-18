from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

# UDC　設変情報追加　認証不正対応
schedule_stg_gijutsu_sms = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_gijutsu_sms_0600",
    schedule_name="gijutsu_sms_0600",
    cron_schedule="00 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_eci_yousi",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_gijutsu_sms_0600"},
                                    source_test_list=["source:*,+stg_eci_yousi"])
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_gijutsu_sms_0600"},
)
