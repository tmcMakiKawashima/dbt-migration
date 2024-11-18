from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

# MIKADO JNET
schedule_stg_mikado_jnet = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_mikado_jnet",
    schedule_name="MIKADO_JNET",
    cron_schedule="00 08 * * 1-5",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_employee_shumu +stg_organization_english +stg_name_history +stg_employee_kubun +stg_syokusyu +stg_syokutakupart +stg_shikaku +stg_ido_history +stg_syokui +stg_syoninkubun +stg_location +stg_bu +stg_shitsuka +stg_kakarigroup +stg_syagaisya +stg_syozoku +stg_bumon +stg_kyumurigyo +stg_kyumurigyo_sk +stg_kyumurigyo_haken +stg_kintai_monthly +stg_kintai_daily +stg_pclog +stg_businesstrip",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_mikado_jnet"},
                                    source_test_list=["source:*,+stg_employee_shumu",
                                                      "source:*,+stg_organization_english",
                                                      "source:*,+stg_name_history",
                                                      "source:*,+stg_employee_kubun",
                                                      "source:*,+stg_syokusyu",
                                                      "source:*,+stg_syokutakupart",
                                                      "source:*,+stg_shikaku",
                                                      "source:*,+stg_ido_history",
                                                      "source:*,+stg_syokui",
                                                      "source:*,+stg_syoninkubun",
                                                      "source:*,+stg_location",
                                                      "source:*,+stg_bu",
                                                      "source:*,+stg_shitsuka",
                                                      "source:*,+stg_kakarigroup",
                                                      "source:*,+stg_syagaisya",
                                                      "source:*,+stg_syozoku",
                                                      "source:*,+stg_bumon",
                                                      "source:*,+stg_kyumurigyo",
                                                      "source:*,+stg_kyumurigyo_sk",
                                                      "source:*,+stg_kyumurigyo_haken",
                                                      "source:*,+stg_kintai_monthly",
                                                      "source:*,+stg_kintai_daily",
                                                      "source:*,+stg_pclog",
                                                      "source:*,+stg_businesstrip"])
                          }
                     ),
    default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_mikado_jnet"},
)
