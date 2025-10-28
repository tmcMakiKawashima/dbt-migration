from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# VIN x 整備
schedule_dm_vinhis_maint = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_dm_vinhis_maint",
    schedule_name="VIN_SEIBI",
    cron_schedule="00 07 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+dm_vinhis_nyukodetail +dm_vinhis_buhinreki +dm_vinhis_seibireki +dm_vinhis_goyomei",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_dm_vinhis_maint"},
                                    source_test_list=["source:*,+dm_vinhis_nyukodetail",
                                                      "source:*,+dm_vinhis_buhinreki",
                                                      "source:*,+dm_vinhis_seibireki",
                                                      "source:*,+dm_vinhis_goyomei"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_dm_vinhis_maint"},
)
