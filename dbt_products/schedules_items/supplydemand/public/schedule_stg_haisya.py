from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 仮々振当Step2
schedule_stg_haisya = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_haisya",
    schedule_name="haisya",
    cron_schedule="30 07 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_touchakuyoteikekkavct_month_n_haisya +stg_touchakuyoteikekkavct_month_n1_haisya +stg_touchakuyoteikekkavct_month_n2_haisya",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_haisya"},
                                    source_test_list=["source:*,+stg_touchakuyoteikekkavct_month_n_haisya",
                                                      "source:*,+stg_touchakuyoteikekkavct_month_n1_haisya",
                                                      "source:*,+stg_touchakuyoteikekkavct_month_n2_haisya"])
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_haisya"},
)