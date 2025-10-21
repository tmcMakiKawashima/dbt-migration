from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 需給情報基盤_地域マスタ
schedule_d_jyukyujyoho_cam2502 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_jyukyujyoho_cam2502",
    schedule_name="JYUKYUJYOHO_CAM2502",
    cron_schedule="00 07 * * 1-6",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_tiikimst_jyukyujyoho",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_jyukyujyoho_cam2502"})
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_d_jyukyujyoho_cam2502"},
)