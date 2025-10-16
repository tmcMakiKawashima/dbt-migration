from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# TMK塗装IoT
schedule_stg_paint_iot = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_paint_iot",
    schedule_name="tmk_paint_iot",
    cron_schedule="00 05 * * 2-6",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_paint_maker_result +stg_paint_hinpo_result +stg_paint_material_criteria +stg_paint_material_controlband +stg_material_permission",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_paint_iot"},
                                    source_test_list=["source:*,+stg_paint_maker_result",
                                                      "source:*,+stg_paint_hinpo_result",
                                                      "source:*,+stg_paint_material_criteria",
                                                      "source:*,+stg_paint_material_controlband",
                                                      "source:*,+stg_material_permission"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_paint_iot"},
)
