from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 車両システム
schedule_stg_syaryosys_0945 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_syaryosys_0945",
    schedule_name="SYARYOSYS_0945",
    cron_schedule="45 09 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_hanbaiten_toriatukai_syasyu_master_syaryosys +stg_syasyu_master_syaryosys +stg_grade_info_tbl_syaryosys +stg_bodycolor_info_tbl_syaryosys +stg_option_info_tbl_syaryosys +stg_dfsc_master_syaryosys +stg_dfsc_kanrikino_meisai_kanren_master_syaryosys +stg_dfsc_option_master_syaryosys +stg_siyoumaster_syaryosys +stg_kanrikino_meisaihikiate_master_syaryosys +stg_hanbaiseiyaku_master_syaryosys +stg_chiikihyoujun_soubi_master_syaryosys +stg_uchibarisiyou_master_syaryosys +stg_gaihanshoku_master_syaryosys +stg_optionsiyo_master_syaryosys +stg_seisanwaku_syaryowaku_tbl_syaryosys +stg_seisanwaku_buhinwaku_tbl_syaryosys +stg_farmwaku_syaryosys +stg_koujou_calendar_tbl_syaryosys +stg_order_kakuteibi_tbl_syaryosys",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_syaryosys_0945"},
                                    source_test_list=["source:*,stg_hanbaiten_toriatukai_syasyu_master_syaryosys",
                                                      "source:*,+stg_syasyu_master_syaryosys",
                                                      "source:*,+stg_grade_info_tbl_syaryosys",
                                                      "source:*,+stg_bodycolor_info_tbl_syaryosys",
                                                      "source:*,+stg_option_info_tbl_syaryosys",
                                                      "source:*,+stg_dfsc_master_syaryosys",
                                                      "source:*,+stg_dfsc_kanrikino_meisai_kanren_master_syaryosys",
                                                      "source:*,+stg_dfsc_option_master_syaryosys",
                                                      "source:*,+stg_siyoumaster_syaryosys",
                                                      "source:*,+stg_kanrikino_meisaihikiate_master_syaryosys",
                                                      "source:*,+stg_hanbaiseiyaku_master_syaryosys",
                                                      "source:*,+stg_chiikihyoujun_soubi_master_syaryosys",
                                                      "source:*,+stg_uchibarisiyou_master_syaryosys",
                                                      "source:*,+stg_gaihanshoku_master_syaryosys",
                                                      "source:*,+stg_optionsiyo_master_syaryosys",
                                                      "source:*,+stg_seisanwaku_syaryowaku_tbl_syaryosys",
                                                      "source:*,+stg_seisanwaku_buhinwaku_tbl_syaryosys",
                                                      "source:*,+stg_farmwaku_syaryosys",
                                                      "source:*,+stg_koujou_calendar_tbl_syaryosys",
                                                      "source:*,+stg_order_kakuteibi_tbl_syaryosys"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_syaryosys_0945"},
)