from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# T-LINX_EPC 品番検索TYPE2 ハイブリッドテーブルテスト merge
schedule_stg_t_linx_epc_merge_ht_test = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="stg_t_linx_epc_merge_ht_test",
    schedule_name="T_LINX_EPC_MERGE_HT_TEST",
    cron_schedule="00 00 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_hinbankensakutype2_merge_ht_test",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_t_linx_epc_merge_ht_test"},
                                    source_test_list=["source:*,+stg_hinbankensakutype2_merge_ht_test"])
                          }
                     ),
    default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_stg_t_linx_epc_merge_ht_test"},
)
