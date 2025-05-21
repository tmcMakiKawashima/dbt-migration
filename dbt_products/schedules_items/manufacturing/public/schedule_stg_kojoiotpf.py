from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 工場IoT
schedule_stg_kojoiotpf = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_kojoiotpf",
    schedule_name="kojoiotpf",
    cron_schedule="00 04,16 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_denchijoho_trm_kojoiotpf +stg_denchijoho_ptr_kojoiotpf",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_kojoiotpf"},
                                    source_test_list=["source:*,+stg_denchijoho_trm_kojoiotpf",
                                                      "source:*,+stg_denchijoho_ptr_kojoiotpf"])
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_kojoiotpf"},
)
