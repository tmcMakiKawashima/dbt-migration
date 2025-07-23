from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 部品表データ活用(tmp)
schedule_tmp_legacy_kousei03_blktenkai = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_tmp_legacy_kousei03_blktenkai",
    schedule_name="sms_legacy_kousei_tmp",
    cron_schedule="00 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+tmp_legacy_kousei03_blktenkai",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "tmp_legacy_kousei03_blktenkai"})
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_tmp_legacy_kousei03_blktenkai"},
)
