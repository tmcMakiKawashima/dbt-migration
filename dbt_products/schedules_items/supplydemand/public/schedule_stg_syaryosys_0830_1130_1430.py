from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 車両システム_0830_1130_1430
schedule_stg_syaryosys_0830_1130_1430 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_syaryosys_0830_1130_1430",
    schedule_name="SYARYOSYS_0830_1130_1430",
    cron_schedule="30 08,11,14 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_order_daisu_summary_syaryosys +stg_kinobetsu_noryoku_waku_syaryosys +stg_dfsc_x_kinomeisai_syaryosys +stg_juchushiyo_kanri_syaryosys",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_syaryosys_0830_1130_1430"},
                                    source_test_list=["source:*,stg_order_daisu_summary_syaryosys",
                                                      "source:*,+stg_kinobetsu_noryoku_waku_syaryosys",
                                                      "source:*,+stg_dfsc_x_kinomeisai_syaryosys",
                                                      "source:*,+stg_juchushiyo_kanri_syaryosys"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_syaryosys_0830_1130_1430"},
)