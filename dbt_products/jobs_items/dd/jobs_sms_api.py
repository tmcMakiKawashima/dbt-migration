from dagster import define_asset_job
from .. import job_util
from ..job_util import job_name_base_call, tags_base


""" api models """
model_sms_api_parts_info_req = [{"name": "tmp_sms_api_parts_info_req_json", "snapshot": None}]
model_sms_api_parts_info_res = [{"name": "tmp_sms_api_parts_info_res_relational", "snapshot": None}]

# SMS API（品番情報） call用ジョブ
job_call_sms_api_parts_info = define_asset_job(
    name=job_name_base_call + "sms_api_parts_info",
    selection="sms_api_parts_info_asset",
    tags=tags_base
)
# SMS API（品番情報） sensor monitoredジョブ（request用ジョブ、api call用ジョブ）
job_sms_api_parts_info_req = job_util.make_job_list_bd(model_sms_api_parts_info_req)
mnt_jobs_sms_api_parts_info = job_sms_api_parts_info_req.copy()
mnt_jobs_sms_api_parts_info.append(job_call_sms_api_parts_info)
# SMS API（品番情報） sensor requestジョブ（api call用ジョブ、response用ジョブ）
job_sms_api_parts_info_res = job_util.make_job_list_bd(model_sms_api_parts_info_res)
req_jobs_sms_api_parts_info = job_sms_api_parts_info_res.copy()
req_jobs_sms_api_parts_info.append(job_call_sms_api_parts_info)