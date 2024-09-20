from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 補給納期物流視える化
schedule_hokyunoki_mieruka = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_hokyunoki_mieruka",
    schedule_name="HOKYUNOKI_MIERUKA",
    cron_schedule="20 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+dm_yohin_daiatari +dm_hosyuhin_noukishitei",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": ""},
                                    source_test_list=["source:*,+dm_yohin_daiatari",
                                                      "source:*,+dm_hosyuhin_noukishitei"])
                          }
                     ),
    default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_hokyunoki_mieruka"},
)
