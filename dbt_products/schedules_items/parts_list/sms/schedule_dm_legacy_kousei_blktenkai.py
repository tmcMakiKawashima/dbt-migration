from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 部品表データ活用(dm)
schedule_dm_legacy_kousei_blktenkai = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_legacy_kousei_blktenkai",
    schedule_name="sms_legacy_kousei_dm",
    cron_schedule="00 07 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="dm_legacy_kousei_blktenkai tmp_legacy_junkanri_blktenkai",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "dm_legacy_kousei_blktenkai"})
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_dm_legacy_kousei_blktenkai"},
)
