from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# D層EPC
schedule_d_epc = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_d_epc",
    schedule_name="D_SOU_EPC",
    cron_schedule="00 05 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_framekatashiki +stg_hinbankensakutype1 +stg_hinbankensakutype2 +stg_shiyopattern +stg_kirikaecodekensaku +stg_trimcodejoho +stg_syaryokatashikijoho +stg_tyotatsuhinbanjoho +stg_tokuchokigojoho +stg_buidaibunruikensakujoho +stg_buicyubunruikensakujoho +stg_buigroupkensakujoho +stg_buisyobunruikensakujoho",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_epc"},
                                    source_test_list=["source:*,+stg_framekatashiki",
                                                      "source:*,+stg_hinbankensakutype1",
                                                      "source:*,+stg_hinbankensakutype2",
                                                      "source:*,+stg_shiyopattern",
                                                      "source:*,+stg_kirikaecodekensaku",
                                                      "source:*,+stg_trimcodejoho",
                                                      "source:*,+stg_syaryokatashikijoho",
                                                      "source:*,+stg_tyotatsuhinbanjoho",
                                                      "source:*,+stg_tokuchokigojoho",
                                                      "source:*,+stg_buidaibunruikensakujoho",
                                                      "source:*,+stg_buicyubunruikensakujoho",
                                                      "source:*,+stg_buigroupkensakujoho",
                                                      "source:*,+stg_buisyobunruikensakujoho"])
                          }
                     ),
    default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_d_epc"},
)
