from ....enterprise_data_products_assets.assets import dbtconfig, dbt_products_assets
from dagster import defaultschedulestatus, runconfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import path
import sys
sys.path.append(str(path(__file__).resolve().parent.parent))

# 従業員情報   
schedule_dm_employee = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_jugyoinjoho",
    schedule_name="jugyoinjoho",
    cron_schedule="0 3 * * *",
    execution_timezone="asia/tokyo",
    dbt_select="+dm_empmasterknm_view dm_empmastershm_view",
    config=runconfig(ops={"dbt_products_assets":
                          dbtconfig(dbt_vars={"dbt_job_name": "_dm_jugyoinjoho"},
                                    source_test_list=["source:*,+dm_empmasterknm_view",
                                                      "source:*,+dm_empmastershm_view"])
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_dm_jugyoinjoho"},
)