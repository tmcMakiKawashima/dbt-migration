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
    dbt_select="+stg_shiyopattern +stg_kirikaecodekensaku +stg_trimcodejoho +stg_tyotatsuhinbanjoho +stg_daitaihinbanjoho +stg_emokujikensaku +stg_figkensaku +stg_katashikipattern +stg_tactihinbanjoho +stg_tokuchokigojoho +stg_buidaibunruikensakujoho +stg_buicyubunruikensakujoho +stg_buigroupkensakujoho +stg_buisyobunruikensakujoho +stg_bunkaizuimagekanri +stg_bunkaizukensaku +stg_figmeisyo +stg_framekatashiki +stg_hinbankensakutype1 +stg_hinbankensakutype2 +stg_hinmei +stg_illustcomment +stg_syamei +stg_syaryokatashikijoho +stg_syaryoshiyosobijoho",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_d_epc"},
                                    source_test_list=["source:*,+stg_shiyopattern",
                                                      "source:*,+stg_kirikaecodekensaku",
                                                      "source:*,+stg_trimcodejoho",
                                                      "source:*,+stg_tyotatsuhinbanjoho",
                                                      "source:*,+stg_daitaihinbanjoho",
                                                      "source:*,+stg_emokujikensaku",
                                                      "source:*,+stg_figkensaku",
                                                      "source:*,+stg_katashikipattern",
                                                      "source:*,+stg_tactihinbanjoho",
                                                      "source:*,+stg_tokuchokigojoho",
                                                      "source:*,+stg_buidaibunruikensakujoho",
                                                      "source:*,+stg_buicyubunruikensakujoho",
                                                      "source:*,+stg_buigroupkensakujoho",
                                                      "source:*,+stg_buisyobunruikensakujoho",
                                                      "source:*,+stg_bunkaizuimagekanri",
                                                      "source:*,+stg_bunkaizukensaku",
                                                      "source:*,+stg_figmeisyo",
                                                      "source:*,+stg_framekatashiki",
                                                      "source:*,+stg_hinbankensakutype1",
                                                      "source:*,+stg_hinbankensakutype2",
                                                      "source:*,+stg_hinmei",
                                                      "source:*,+stg_illustcomment",
                                                      "source:*,+stg_syamei",
                                                      "source:*,+stg_syaryokatashikijoho",
                                                      "source:*,+stg_syaryoshiyosobijoho"])
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "256", "ecs/memory": "1024",
          "job_name": "job_build_d_epc"},
)
