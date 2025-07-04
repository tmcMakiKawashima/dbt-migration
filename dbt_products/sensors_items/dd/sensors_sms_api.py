from dagster import run_status_sensor, RunRequest, DagsterRunStatus, RunStatusSensorContext, JobSelector
from ..sensor_util import tags_base, mini_interval_sec
from ...jobs_items.dd.jobs_sms_api import mnt_jobs_sms_api_parts_info, req_jobs_sms_api_parts_info


# SMS API（品番情報）
dict_sms_api_parts_info = {
    "job_req": "job_build_tmp_sms_api_parts_info_req_json",
    "job_api": "job_call_sms_api_parts_info",
    "job_res": "job_build_tmp_sms_api_parts_info_res_relational"
}

# run_status_sensorは１回の評価で１個しかトリガーできない

# SMS API（品番情報）センサー
@run_status_sensor(
        run_status=DagsterRunStatus.SUCCESS,
        monitored_jobs=mnt_jobs_sms_api_parts_info,
        request_jobs=req_jobs_sms_api_parts_info,
        minimum_interval_seconds=mini_interval_sec)
def dd_sms_api_parts_info_sensor(context: RunStatusSensorContext):
    job_name = context.dagster_run.job_name
    print(job_name)
    if job_name == dict_sms_api_parts_info["job_req"]:
        yield RunRequest(
            run_config={},
            job_name=dict_sms_api_parts_info["job_api"],
            tags=tags_base,
        )
    elif job_name == dict_sms_api_parts_info["job_api"]:
        yield RunRequest(
            run_config={},
            job_name=dict_sms_api_parts_info["job_res"],
            tags=tags_base,
        )