from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# VLTオーダー確定日チェックEUC
schedule_stg_vlt_ord = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_vlt_ord",
    schedule_name="VLT_ORD",
    cron_schedule="00 04 * * 2-6",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_line_kadokeitai +stg_orderkakutei_shihan +stg_orderkakutei_yusyutu +stg_vltsohutaisho",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_vlt_ord"},
                                    source_test_list=["source:*,+stg_line_kadokeitai",
                                                      "source:*,+stg_orderkakutei_shihan",
                                                      "source:*,+stg_orderkakutei_yusyutu",
                                                      "source:*,+stg_vltsohutaisho"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_vlt_ord"},
)
