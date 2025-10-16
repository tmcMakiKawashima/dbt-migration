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
    dbt_select="+stg_nbkyotenplanhaisha_vlc +stg_nbkyotenresult_vlc +stg_noukitougoujyoho_shihanho_vlc +stg_noukitougoujyoho_shihandtlho_vlc +stg_noukitougoujyoho_yusyutuho_vlc +stg_noukitougoujyoho_yusyutudtlho_vlc +stg_kbnmst_vlc +stg_kyotenmstfuzoku_vlc +stg_funadumiresult_vlc +stg_funahimoduke_vlc +stg_shipnamemst_vlc",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_vlc_0500"})
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_d_vlc_0500"},
)
