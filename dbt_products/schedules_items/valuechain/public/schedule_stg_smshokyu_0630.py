from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 補給sms_0630
schedule_stg_smshokyu_0630 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_smshokyu_0630",
    schedule_name="smshokyu_0630",
    cron_schedule="30 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_hokyuhinbankouseikoute_smshokyu +stg_zissiziki_smshokyu +stg_hokyusetteitiikigenntei_smshokyu +stg_hokyusetteicltiikigenntei_smshokyu",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_smshokyu_0630"})
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_smshokyu_0630"},
)