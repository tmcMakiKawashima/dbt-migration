from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# VLC本体_0130
schedule_d_vlc_0130 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_vlc_0130",
    schedule_name="vlc_0130",
    cron_schedule="30 01 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_cubc001key_vlc +stg_cubc024plodplan_vlc +stg_cubc028plodresult_vlc +stg_cubc025logkyotenplan_vlc +stg_cubc029logkyotenresult_vlc +stg_cubc026logopeplan_vlc +stg_cubc030logoperesult_vlc +stg_cubd001shihan_vlc +stg_cubd002shihandtl_vlc +stg_cubc101kyoten_vlc",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_vlc_0130"},
                                    source_test_list=["source:*,+stg_cubc001key_vlc",
                                                      "source:*,+stg_cubc024plodplan_vlc",
                                                      "source:*,+stg_cubc028plodresult_vlc",
                                                      "source:*,+stg_cubc025logkyotenplan_vlc",
                                                      "source:*,+stg_cubc029logkyotenresult_vlc",
                                                      "source:*,+stg_cubc026logopeplan_vlc",
                                                      "source:*,+stg_cubc030logoperesult_vlc",
                                                      "source:*,+stg_cubd001shihan_vlc",
                                                      "source:*,+stg_cubd002shihandtl_vlc",
                                                      "source:*,+stg_cubc101kyoten_vlc"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_d_vlc_0130"},
)
