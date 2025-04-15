from ....enterprise_data_products_assets.assets import dbtconfig, dbt_products_assets
from dagster import defaultschedulestatus, runconfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import path
import sys
sys.path.append(str(path(__file__).resolve().parent.parent))

# kodomo
schedule_stg_kodomo = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_kodomo",
    schedule_name="kodomo",
    # cron_schedule="0 6 * * *",
    execution_timezone="asia/tokyo",
    dbt_select="++stg_seiyakuformat_kodomo",
    config=runconfig(ops={"dbt_products_assets":
                          dbtconfig(dbt_vars={"dbt_job_name": "_stg_kodomo"},
                                    source_test_list=["source:*,+stg_seiyakuformat_kodomo"])
                          }
                     ),
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_kodomo"},
)