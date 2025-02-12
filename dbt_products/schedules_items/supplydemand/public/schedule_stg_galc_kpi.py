from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 物流管理KPI
schedule_stg_galc_kpi = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_galc_kpi",
    schedule_name="GLAC_KPI",
    cron_schedule="00 23 * * *",
    execution_timezone="Asia/Tokyo",

    dbt_select="+*stg_hostalc_1?_erasure_achievements +*stg_hostalc_1?_production_progress +*stg_hostalc_1?_reject_vehicle +*stg_hostalc_1?_vehicle_specification +*stg_hostalc_1?_virtual_line +stg_hostalc_allsfh +stg_hostalc_allsfp +stg_hostalc_allsfl +stg_hostalc_allsft +stg_hostalc_allsfvam",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_galc_kpi"},
                                    source_test_list=["source:*,+*stg_hostalc_1?_erasure_achievements",
                                                      "source:*,+*stg_hostalc_1?_production_progress",
                                                      "source:*,+*stg_hostalc_1?_reject_vehicle",
                                                      "source:*,+*stg_hostalc_1?_vehicle_specification",
                                                      "source:*,+*stg_hostalc_1?_virtual_line",
                                                      "source:*,+stg_hostalc_allsfh",
                                                      "source:*,+stg_hostalc_allsfp",
                                                      "source:*,+stg_hostalc_allsfl",
                                                      "source:*,+stg_hostalc_allsft",
                                                      "source:*,+stg_hostalc_allsfvam"])
                          }
                     ),

    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_galc_kpi"},
)
