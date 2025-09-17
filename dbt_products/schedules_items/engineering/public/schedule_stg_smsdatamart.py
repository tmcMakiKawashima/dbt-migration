from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# SMSデータマート
schedule_stg_smsdatamart = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_smsdatamart",
    schedule_name="SMSDATAMART",
    cron_schedule="00 04 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_variationname +stg_kumitatename +stg_buiname +stg_mokuji +stg_kouteifugo_gijutsusms +stg_seisanbasyoseisiki_kouteisms +stg_mokujisitu_gijutsusms +stg_jtaizokusei_gijutsusms +stg_tiikizokusei_gijutsusms +stg_kunizokusei_gijutsusms +stg_honsisitu_gijutsusms +stg_mokujibuijun_gijutsusms +stg_syutudenpyotbl_kouteisms +stg_seppenst_gijutsusms +stg_glseppenst_kouteisms",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_smsdatamart"})
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_smsdatamart"},
)
