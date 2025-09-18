from ....jobs_items.dd.jobs_sms_api import job_sms_api_parts_info_req
from dagster import ScheduleDefinition
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# SMS API(部品情報) REQUEST
schedule_tmp_sms_api_parts_info_req_json = ScheduleDefinition(
    name="SMS_API_PARTS_INFO_REQUEST",
    cron_schedule="00 03 * * *",
    execution_timezone="Asia/Tokyo",
    job=job_sms_api_parts_info_req[0],
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_tmp_sms_api_parts_info_req_json"},
)
