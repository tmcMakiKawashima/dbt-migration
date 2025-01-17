from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# SMS構成(tmp)
schedule_stg_paint_iot = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_tmp_kousei03_blktenkai",
    schedule_name="sms_kousei_tmp",
    cron_schedule="00 06 * * 0-6",
    execution_timezone="Asia/Tokyo",
    dbt_select="+tmp_kousei03_blktenkai",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "tmp_kousei03_blktenkai"},
                                    source_test_list=["source:*,tmp_kousei03_blktenkai"])
                          }
                     ),
    default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_tmp_kousei03_blktenkai"},
)
