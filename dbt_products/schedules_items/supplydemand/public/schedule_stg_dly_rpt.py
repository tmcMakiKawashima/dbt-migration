from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 生産日報STEP3(夜間 全て)
schedule_stg_dly_rpt = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_dly_rpt",
    schedule_name="DLY_RPT",
    cron_schedule="30 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_chiiki +stg_jigyotai_line +stg_seisanpattern_syasyu +stg_katashiki_syasyuteigi +stg_kd_cbu_henkan +stg_kadonissu +stg_nippo_hyojijun +stg_kudo +stg_chokukado_tact +stg_linekado_calender +stg_shihan_yusyutu_henkan +stg_seisanpattern_syasyumei +stg_line_nippo +stg_syameigroup_nippo +stg_line_nippo_tokki +stg_kokunaikatashiki_nippo +stg_jikkokeikaku +stg_gekkan_kadojisseki",
    # config=RunConfig(),
    default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
            "job_name": "job_build_stg_dly_rpt"},
)
