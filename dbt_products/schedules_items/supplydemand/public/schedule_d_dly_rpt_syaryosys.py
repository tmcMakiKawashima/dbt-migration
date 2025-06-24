from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 生産日報_車両システム
schedule_d_dly_rpt_syaryosys = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_dly_rpt_syaryosys",
    schedule_name="DLY_RPT_2_SYARYOSYS",
    cron_schedule="00 22 * * 1-5",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_vlt_syaryosys +stg_oem_syaryosys +stg_cmf_syaryosys",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_dly_rpt_syaryosys"},
                                    source_test_list=["source:*,+stg_vlt_syaryosys",
                                                      "source:*,+stg_oem_syaryosys",
                                                      "source:*,+stg_cmf_syaryosys"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_d_dly_rpt_syaryosys"},
)