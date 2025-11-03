from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 車種コード,仕様変換
schedule_stg_siyou_soubi_syasyu_siyousyo = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_siyou_soubi_syasyu_siyousyo",
    schedule_name="SIYOU_SOUBI_SYASYU_SIYOUSYO",
    cron_schedule="00 02 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_siyouhenkan +stg_syasyu_siyousho",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_siyou_soubi_syasyu_siyousyo"},
                                    source_test_list=["source:*,+stg_siyouhenkan",
                                                      "source:*,+stg_syasyu_siyousho"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_siyou_soubi_syasyu_siyousyo"},
)