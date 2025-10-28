from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# D層GSPS_0600
schedule_d_gsps_0600 = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_gsps_0600",
    schedule_name="D_SOU_GSPS_0600",
    cron_schedule="00 06 * * 0,2,3,4,5,6",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_hinbanjyohohinmei_gsps +stg_hokyujyoho_gsps +stg_hinbanjyoho_gsps +stg_hinbanseppenjyohosiki_gsps +stg_hanbaitiiki_gsps +stg_jigyotai_gsps +stg_ordersakisyoninzumi_ordersaki_gsps +stg_daitaikirikaebi_gsps +stg_daitaiordersakiroot_gsps +stg_daitai_gsps",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_gsps_0600"},
                                    source_test_list=["source:*,+stg_hinbanjyohohinmei_gsps",
                                                      "source:*,+stg_hokyujyoho_gsps",
                                                      "source:*,+stg_hinbanjyoho_gsps",
                                                      "source:*,+stg_hinbanseppenjyohosiki_gsps",
                                                      "source:*,+stg_hanbaitiiki_gsps",
                                                      "source:*,+stg_jigyotai_gsps",
                                                      "source:*,+stg_ordersakisyoninzumi_ordersaki_gsps",
                                                      "source:*,+stg_daitaikirikaebi_gsps",
                                                      "source:*,+stg_daitaiordersakiroot_gsps",
                                                      "source:*,+stg_daitai_gsps"])
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_d_gsps_0600"},
)
