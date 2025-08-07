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
    dbt_select="+stg_kanseisyabuturyukey_vlc +stg_syaryoplseisaneplan_vlc +stg_syaryoplseisanresult_vlc +stg_syaryoplbuturyukyotenplan_vlc +stg_syaryoplbuturyukyotenresult_vlc +stg_syaryoplbuturyuopeplan_vlc +stg_syaryoplbuturyuoperesult_vlc +stg_noukitougoujyoho_shihan_vlc +stg_noukitougoujyoho_shihandtl_vlc +stg_kyotenmst_vlc",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_vlc_0130"},
                                    source_test_list=["source:*,+stg_kanseisyabuturyukey_vlc",
                                                      "source:*,+stg_syaryoplseisaneplan_vlc",
                                                      "source:*,+stg_syaryoplseisanresult_vlc",
                                                      "source:*,+stg_syaryoplbuturyukyotenplan_vlc",
                                                      "source:*,+stg_syaryoplbuturyukyotenresult_vlc",
                                                      "source:*,+stg_syaryoplbuturyuopeplan_vlc",
                                                      "source:*,+stg_syaryoplbuturyuoperesult_vlc",
                                                      "source:*,+stg_noukitougoujyoho_shihan_vlc",
                                                      "source:*,+stg_noukitougoujyoho_shihandtl_vlc",
                                                      "source:*,+stg_kyotenmst_vlc"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_d_vlc_0130"},
)
