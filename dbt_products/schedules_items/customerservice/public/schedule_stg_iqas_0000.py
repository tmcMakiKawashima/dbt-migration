from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# iQAS_0000
schedule_stg_iqas_0000 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_iqas_0000",
    schedule_name="IQAS_0000",
    cron_schedule="00 00 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_disp_partnm05_iqas +stg_disp_partnm10_iqas +stg_bosu_sum_ym_iqas +stg_disp_name_mst_iqas",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_iqas_0000"})
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_iqas_0000"},
)