from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# SMS API(部品情報) REQUEST
schedule_tmp_sms_api_parts_info_req_json = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_tmp_sms_api_parts_info_req_json",
    schedule_name="SMS_API_PARTS_INFO_REQUEST",
    cron_schedule="00 05 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+tmp_sms_api_parts_info_req_json",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_tmp_sms_api_parts_info_req_json"},
                                    source_test_list=["source:*,+tmp_sms_api_parts_info_req_json"])
                          }
                     ),
    default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_tmp_sms_api_parts_info_req_json"},
)
