"""
To add a daily schedule that materializes your dbt assets, uncomment the following lines.
"""
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

from .enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets

schedules = [
    build_schedule_from_dbt_selection(
        [dbt_products_assets],
        job_name="dm_vinhis_specification_kokunai",
        schedule_name="VIN_SOUBI_KOKUNAI",
        cron_schedule="37 19 * * *",
        execution_timezone="Asia/Tokyo",
        dbt_select="+dm_vinhis_specification_kokunai",
        config=RunConfig(ops={
            "dbt_products_assets": DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_vinhis_specification_kokunai"})}),
        # default_status=DefaultScheduleStatus.RUNNING,
    ),
    build_schedule_from_dbt_selection(
        [dbt_products_assets],
        job_name="dm_vinhis_specification_kaigai",
        schedule_name="VIN_SOUBI_KAIGAI",
        cron_schedule="35 16 * * *",
        execution_timezone="Asia/Tokyo",
        dbt_select="+dm_vinhis_specification_kaigai",
        config=RunConfig(ops={
            "dbt_products_assets": DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_vinhis_specification_kaigai"})}),
        # default_status=DefaultScheduleStatus.RUNNING,
    ),
    build_schedule_from_dbt_selection(
        [dbt_products_assets],
        job_name="dm_vinhis_specification_oem",
        schedule_name="VIN_SOUBI_OEM",
        cron_schedule="35 16 * * *",
        execution_timezone="Asia/Tokyo",
        dbt_select="+dm_vinhis_specification_oem",
        config=RunConfig(ops={
            "dbt_products_assets": DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_vinhis_specification_oem"})}),
        # default_status=DefaultScheduleStatus.RUNNING,
    ),
    build_schedule_from_dbt_selection(
        [dbt_products_assets],
        job_name="snapshots",
        schedule_name="snapshot",
        cron_schedule="16 16 * * *",
        execution_timezone="Asia/Tokyo",
        dbt_select="resource_type:snapshot",
        dbt_exclude="scd_tbsmksk_noki",
        # default_status=DefaultScheduleStatus.RUNNING,
    ),
]