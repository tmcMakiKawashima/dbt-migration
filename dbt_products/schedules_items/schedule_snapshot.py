from ..enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# snapshot
schedule_snapshot = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_snapshots",
    schedule_name="snapshot",
    cron_schedule="00 21 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="resource_type:snapshot",
    dbt_exclude="scd_tbsmksk_noki",
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_snapshots"},
)
