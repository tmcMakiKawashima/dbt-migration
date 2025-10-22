from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# JPASS
schedule_stg_jpass = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_jpass",
    schedule_name="jpass",
    cron_schedule="00 02 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_jyuchu_shosai_seiyakukakunin_jpass +stg_jyuchu_seiyakukinosyukei_seiyakukakunin_jpass +stg_haishayoubo_jpass +stg_jyuchu_kinosyukei_seiyakukakunin_jpass",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_jpass"},
                                    source_test_list=["source:*,+stg_jyuchu_shosai_seiyakukakunin_jpass",
                                                      "source:*,+stg_jyuchu_seiyakukinosyukei_seiyakukakunin_jpass",
                                                      "source:*,+stg_haishayoubo_jpass",
                                                      "source:*,+stg_jyuchu_kinosyukei_seiyakukakunin_jpass"])
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_jpass"},
)
