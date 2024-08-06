"""
To add a daily schedule that materializes your dbt assets, uncomment the following lines.
"""
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

from .enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets

schedules = [
    # 補給納期物流視える化
    build_schedule_from_dbt_selection(
        [dbt_products_assets],
        job_name="job_build_hokyunoki_mieruka",
        schedule_name="HOKYUNOKI_MIERUKA",
        cron_schedule="30 19 * * *",
        execution_timezone="Asia/Tokyo",
        dbt_select="+dm_yohin_daiatari +dm_hosyuhin_noukishitei",
        config=RunConfig(ops={"dbt_products_assets": 
                              DbtConfig(dbt_vars={"DBT_JOB_NAME": ""})
                             }
                        ),
        # default_status=DefaultScheduleStatus.RUNNING,
        tags={"ecs/cpu": "256", "ecs/memory": "1024",
              "job_name": "job_build_hokyunoki_mieruka"},
    ),
    # VIN装備（国内）
    build_schedule_from_dbt_selection(
        [dbt_products_assets],
        job_name="job_build_dm_vinhis_specification_kokunai",
        schedule_name="VIN_SOUBI_KOKUNAI",
        cron_schedule="30 16 * * *",
        execution_timezone="Asia/Tokyo",
        dbt_select="+dm_vinhis_specification_kokunai",
        config=RunConfig(ops={"dbt_products_assets": 
                              DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_vinhis_specification_kokunai"})
                             }
                        ),
        # default_status=DefaultScheduleStatus.RUNNING,
        tags={"ecs/cpu": "256", "ecs/memory": "1024",
              "job_name": "job_build_dm_vinhis_specification_kokunai"},
    ),
    # VIN装備（海外）
    build_schedule_from_dbt_selection(
        [dbt_products_assets],
        job_name="job_build_dm_vinhis_specification_kaigai",
        schedule_name="VIN_SOUBI_KAIGAI",
        cron_schedule="30 16 * * *",
        execution_timezone="Asia/Tokyo",
        dbt_select="+dm_vinhis_specification_kaigai",
        config=RunConfig(ops={"dbt_products_assets": 
                              DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_vinhis_specification_kaigai"})
                             }
                        ),
        # default_status=DefaultScheduleStatus.RUNNING,
        tags={"ecs/cpu": "256", "ecs/memory": "1024",
              "job_name": "job_build_dm_vinhis_specification_kaigai"},
    ),
    # VIN装備（OEM）
    build_schedule_from_dbt_selection(
        [dbt_products_assets],
        job_name="job_build_dm_vinhis_specification_oem",
        schedule_name="VIN_SOUBI_OEM",
        cron_schedule="30 16 * * *",
        execution_timezone="Asia/Tokyo",
        dbt_select="+dm_vinhis_specification_oem",
        config=RunConfig(ops={"dbt_products_assets": 
                              DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_vinhis_specification_oem"})
                             }
                        ),
        # default_status=DefaultScheduleStatus.RUNNING,
        tags={"ecs/cpu": "256", "ecs/memory": "1024",
              "job_name": "job_build_dm_vinhis_specification_oem"},
    ),
    # snapshot
    build_schedule_from_dbt_selection(
        [dbt_products_assets],
        job_name="job_snapshots",
        schedule_name="snapshot",
        cron_schedule="00 18 * * *",
        execution_timezone="Asia/Tokyo",
        dbt_select="resource_type:snapshot",
        dbt_exclude="scd_tbsmksk_noki",
        # default_status=DefaultScheduleStatus.RUNNING,
        tags={"ecs/cpu": "256", "ecs/memory": "1024",
              "job_name": "job_snapshots"},
    ),
]