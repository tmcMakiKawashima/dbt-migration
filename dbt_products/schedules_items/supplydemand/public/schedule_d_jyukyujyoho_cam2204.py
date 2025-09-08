from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 需給情報基盤_月度VCT
schedule_d_jyukyujyoho_cam2204 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_jyukyujyoho_cam2204",
    schedule_name="JYUKYUJYOHO_CAM2204",
    cron_schedule="00 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_monthvct_jyukyujyoho",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_jyukyujyoho_cam2204"})
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_d_jyukyujyoho_cam2204"},
)