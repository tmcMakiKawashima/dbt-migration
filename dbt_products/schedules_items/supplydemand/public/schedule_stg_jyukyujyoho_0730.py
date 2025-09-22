from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 需給情報基盤_0730
schedule_stg_jyukyujyoho_0730 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_jyukyujyoho_0730",
    schedule_name="JYUKYUJYOHO_0730",
    cron_schedule="30 07 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_getsudo_vct_n1_jyukyujyoho +stg_sfx_kihonjyoho_tbl_jyukyujyoho",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_jyukyujyoho_0730"})
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_jyukyujyoho_0730"},
)
