from dagster import define_asset_job
from .. import job_util
from ..job_util import job_name_base_call


""" api models """
model_list_sms_api_parts_info = [{"name": "tmp_sms_api_parts_info_res_relational", "snapshot": None}]

# SMS API（品番情報） call用ジョブ
job_call_sms_api_parts_info = define_asset_job(
    name=job_name_base_call + "sms_api_parts_info",
    selection="sms_api_parts_info_asset"
)
# SMS API（品番情報） response用ジョブ
job_list_sms_api_parts_info = job_util.make_job_list_bd(model_list_sms_api_parts_info)
job_list_sms_api_parts_info.append(job_call_sms_api_parts_info)