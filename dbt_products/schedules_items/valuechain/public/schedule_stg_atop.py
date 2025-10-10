from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# ATOP
schedule_stg_atop = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_atop",
    schedule_name="ATOP",
    cron_schedule="00 05 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_nonyult_atop +stg_syoruihanyo_atop +stg_hunadumijisseki_atop +stg_mitsumori_ordersyorikekka_atop +stg_kaigaidistbetsujutyujisseki_daily_atop +stg_hankahinban_atop +stg_hankakaigai_atop +stg_kaigaitokkafob_atop +stg_kaigaitekiyouhankadistenzan_atop +stg_kaigaitekiyouhankafobshisuu_atop +stg_syaryomodelshikibetsu_atop +stg_kaigaitekiyouhankakawasetsuuka_atop +stg_hokyubuhinhinbanjoho_atop +stg_syoruigaikokusanhin_atop +stg_jutyuu_atop +stg_syukkosagyohinban_atop +stg_seisankokumeicheck_atop +stg_zaiko_atop +stg_kokunaijutyujisseki_daily_atop +stg_noukikanri_atop +stg_naiji_atop +stg_syoruihinbankihon_atop",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_atop"},
                                    source_test_list=["source:*,stg_nonyult_atop",
                                                      "source:*,stg_syoruihanyo_atop",
                                                      "source:*,stg_hunadumijisseki_atop",
                                                      "source:*,stg_mitsumori_ordersyorikekka_atop",
                                                      "source:*,stg_kaigaidistbetsujutyujisseki_daily_atop",
                                                      "source:*,stg_hankahinban_atop",
                                                      "source:*,stg_hankakaigai_atop",
                                                      "source:*,stg_kaigaitokkafob_atop",
                                                      "source:*,stg_kaigaitekiyouhankadistenzan_atop",
                                                      "source:*,stg_kaigaitekiyouhankafobshisuu_atop",
                                                      "source:*,stg_syaryomodelshikibetsu_atop",
                                                      "source:*,stg_kaigaitekiyouhankakawasetsuuka_atop",
                                                      "source:*,stg_hokyubuhinhinbanjoho_atop",
                                                      "source:*,stg_syoruigaikokusanhin_atop",
                                                      "source:*,stg_jutyuu_atop",
                                                      "source:*,stg_syukkosagyohinban_atop",
                                                      "source:*,stg_seisankokumeicheck_atop",
                                                      "source:*,stg_zaiko_atop",
                                                      "source:*,stg_kokunaijutyujisseki_daily_atop",
                                                      "source:*,stg_noukikanri_atop",
                                                      "source:*,stg_naiji_atop",
                                                      "source:*,stg_syoruihinbankihon_atop"])
                          }
                     ),
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_atop"},
)