from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# VLC本体_0500
schedule_d_vlc_0500 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_vlc_0500",
    schedule_name="vlc_0500",
    cron_schedule="00 5 * * 1-5",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_cubc260nbkyotenplanhaisha_vlc +stg_cubc262nbkyotenjsk_vlc",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_vlc_0500"},
                                    source_test_list=["source:*,+stg_cubc260nbkyotenplanhaisha_vlc",
                                                      "source:*,+stg_cubc262nbkyotenjsk_vlc"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_d_vlc_0500"},
)
