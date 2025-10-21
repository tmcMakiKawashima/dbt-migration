from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))


# D層補給SMS_出荷先
schedule_stg_smshokyu = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_smshokyu",
    schedule_name="D_SOU_SMSHOKYU",
    cron_schedule="00 02 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_hokyusettei_smshokyu +stg_hokyusetteisyoku_smshokyu +stg_daitaijoho_smshokyu +stg_hokyuhinbanjoho_smshokyu +stg_hokyuhinbancomment_smshokyu +stg_hokyusyukkabasyo_smshokyu +stg_hinbantikibetsutaiouhinban_smshokyu +stg_tikibetsuhokyutyotatsujoho_smshokyu",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_smshokyu"})
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_smshokyu"},
)