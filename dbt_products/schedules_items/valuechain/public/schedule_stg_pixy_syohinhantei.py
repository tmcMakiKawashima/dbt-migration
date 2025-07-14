from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# PIXY_選択可能商品判定
schedule_stg_pixy_syohinhantei = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_pixy_syohinhantei",
    schedule_name="pixy_syohinhantei",
    cron_schedule="45 10,13,15,17 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_hinbanjoho_pixy_view +stg_tuikousotyakujokenjoho_pixy_view +stg_batchsyorijokyo_pixy_view +stg_syaryojoho_yohinsyameino_pixy_view +stg_avnsyohinhinmokumeisyo_pixy_view +stg_syasyubetulineupjoho_pixy_view",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_pixy_syohinhantei"})
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_pixy_syohinhantei"},
)