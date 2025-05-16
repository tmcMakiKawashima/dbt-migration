from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 仕様マスタ
schedule_stg_siyou_soubi_siyoumst = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_siyou_soubi_siyoumst",
    schedule_name="SIYOU_SOUBI_SIYOUMST",
    cron_schedule="00 04 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_siyoumst_katashiki +stg_siyoumst_check +stg_siyoumst_generate",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_siyou_soubi_siyoumst"},
                                    source_test_list=["source:*,+stg_siyoumst_katashiki",
                                                      "source:*,+stg_siyoumst_check",
                                                      "source:*,+stg_siyoumst_generate"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_siyou_soubi_siyoumst"},
)