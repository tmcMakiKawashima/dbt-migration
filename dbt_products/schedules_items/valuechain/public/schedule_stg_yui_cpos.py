from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# YUI_CPOS
schedule_stg_yui_cpos = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_yui_cpos",
    schedule_name="yui_cpos",
    cron_schedule="0 5 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_anken +stg_dairitenkey +stg_cpos_chiiki +stg_shochihinban +stg_kuni +stg_monitorjokyo +stg_shochihinbantaishodaisuu +stg_kunimaster +stg_chiikimaster",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_yui_cpos"},
                                    source_test_list=["source:*,+stg_anken",
                                                      "source:*,+stg_dairitenkey",
                                                      "source:*,+stg_cpos_chiiki",
                                                      "source:*,+stg_shochihinban",
                                                      "source:*,+stg_kuni",
                                                      "source:*,+stg_monitorjokyo",
                                                      "source:*,+stg_shochihinbantaishodaisuu",
                                                      "source:*,+stg_kunimaster",
                                                      "source:*,+stg_chiikimaster"])
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_yui_cpos"},
)
