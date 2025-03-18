from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

# UDC　設変情報追加　認証不正対応
schedule_dm_gijutsu_sms_0700 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_gijutsu_sms_0700",
    schedule_name="gijutsu_sms_0700",
    cron_schedule="00 07 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+dm_yousi_all",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_gijutsu_sms_0700"},
                                    source_test_list=["source:*,+dm_yousi_all"])
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_dm_gijutsu_sms_0700"},
)
