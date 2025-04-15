from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# PIXY
schedule_stg_pixy = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_pixy",
    schedule_name="pixy",
    cron_schedule="00 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_yohinmaster_pixy_view +stg_katashikihenkanmaster_pixy_view +stg_tuikouoyakokanren_pixy_view +stg_battingjoho_pixy_view +stg_yohinsyameino_pixy_view +stg_katashikibit_pixy +stg_tuikouzenkakumeisyou_pixy +stg_oyakotuikoukanrenzenkakumeisyou_pixy",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_pixy"},
                                    source_test_list=["source:*,+stg_yohinmaster_pixy_view",
                                                      "source:*,+stg_katashikihenkanmaster_pixy_view",
                                                      "source:*,+stg_tuikouoyakokanren_pixy_view",
                                                      "source:*,+stg_battingjoho_pixy_view",
                                                      "source:*,+stg_yohinsyameino_pixy_view",
                                                      "source:*,+stg_katashikibit_pixy",
                                                      "source:*,+stg_tuikouzenkakumeisyou_pixy",
                                                      "source:*,+stg_oyakotuikoukanrenzenkakumeisyou_pixy"])
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_pixy"},
)
