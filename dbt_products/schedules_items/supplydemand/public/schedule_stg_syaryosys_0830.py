from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 車両システム_0830
schedule_stg_syaryosys_0830 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_syaryosys_0830",
    schedule_name="SYARYOSYS_0830",
    cron_schedule="30 08 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_shamei_master_syaryosys +stg_order_db_syaryosys +stg_warning_list_syaryosys +stg_knm_nrksortjun_syaryosys +stg_kinomeisai_master_syaryosys +stg_kinobetsu_noryoku_daisusyukei_syaryosys +stg_kinomeisai_code_meisho_master_syaryosys +stg_kinomeisai_code_hikiate_master_syaryosys",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_syaryosys_0830"},
                                    source_test_list=["source:*,stg_shamei_master_syaryosys",
                                                      "source:*,+stg_order_db_syaryosys",
                                                      "source:*,+stg_warning_list_syaryosys",
                                                      "source:*,+stg_knm_nrksortjun_syaryosys",
                                                      "source:*,+stg_kinomeisai_master_syaryosys",
                                                      "source:*,stg_kinobetsu_noryoku_daisusyukei_syaryosys",
                                                      "source:*,+stg_kinomeisai_code_meisho_master_syaryosys",
                                                      "source:*,+stg_kinomeisai_code_hikiate_master_syaryosys"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_syaryosys_0830"},
)