from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 車両システム_0500
schedule_d_syaryosys_0500 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_syaryosys_0500",
    schedule_name="SYARYOSYS_0500",
    cron_schedule="00 05 * * 2-6",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_vlt_syaryosys +stg_oem_syaryosys +stg_cmf_syaryosys",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_syaryosys_0500"},
                                    source_test_list=["source:*,+stg_vlt_syaryosys",
                                                      "source:*,+stg_oem_syaryosys",
                                                      "source:*,+stg_cmf_syaryosys"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_d_syaryosys_0500"},
)