from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 車両システム_0200
schedule_d_syaryosys_0200 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_syaryosys_0200",
    schedule_name="syaryosys_0200",
    cron_schedule="00 02 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_jyuchuzan_dec_syaryosys +stg_coorder_dec_syaryosys +stg_karikarifuri_syaryosys +stg_juchuzan_shiyoerr_syaryosys +stg_noryokuwaku_date_syaryosys +stg_noryokuwaku_month_syaryosys +stg_dfsc_kinomeisaicd_syaryosys +stg_daisu_month_syaryosys +stg_maker_line_syaryosys +stg_line_cal_syaryosys +stg_fwaku_syaryosys +stg_roketa_syaryosys +stg_jukyustatus_syaryosys",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_syaryosys_0200"},
                                    source_test_list=["source:*,+stg_jyuchuzan_dec_syaryosys",
                                                      "source:*,+stg_coorder_dec_syaryosys",
                                                      "source:*,+stg_karikarifuri_syaryosys",
                                                      "source:*,+stg_juchuzan_shiyoerr_syaryosys",
                                                      "source:*,+stg_noryokuwaku_date_syaryosys",
                                                      "source:*,+stg_noryokuwaku_month_syaryosys",
                                                      "source:*,+stg_dfsc_kinomeisaicd_syaryosys",
                                                      "source:*,+stg_daisu_month_syaryosys",
                                                      "source:*,+stg_maker_line_syaryosys",
                                                      "source:*,+stg_line_cal_syaryosys",
                                                      "source:*,+stg_fwaku_syaryosys",
                                                      "source:*,+stg_roketa_syaryosys",
                                                      "source:*,+stg_jukyustatus_syaryosys"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_d_syaryosys_0200"},
)
