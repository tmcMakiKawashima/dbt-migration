from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 需給情報基盤(オーダーDB)
schedule_d_jyukyujyoho_0530 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_jyukyujyoho_0530",
    schedule_name="jyukyujyoho_orderdb",
    cron_schedule="30 05 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_orderdb_order_jyukyujyoho +stg_orderdb_buturyu_jyukyujyoho",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_jyukyujyoho_0530"},
                                    source_test_list=["source:*,+stg_orderdb_order_jyukyujyoho",
                                                      "source:*,+stg_orderdb_buturyu_jyukyujyoho"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_d_jyukyujyoho_0530"},
)
