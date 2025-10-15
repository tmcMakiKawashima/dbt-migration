from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection

# MIKADO_JUDGEV
schedule_stg_mikado_judgev = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_mikado_judgev",
    schedule_name="MIKADO_JUDGEV",
    cron_schedule="00 01 * * 6",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_saikendenpyo_joho_judgev +stg_saikenmaeuke_meisai_judgev +stg_saikentorihikisaki_meisai_judgev +stg_saimudenpyo_meisai_judgev +stg_hinmoku_meisai_judgev +stg_torihikisaki_masta_judgev +stg_furikomikoza_masta_judgev +stg_torihikitanto_kaigai_masta_judgev +stg_seikyusofu_kokunai_masta_judgev +stg_shinsei_header_judgev +stg_torihiki_tekiyo_judgev +stg_torihiki_meisai_judgev +stg_kosaihijizen_meisai_judgev +stg_busyo_meisai_judgev +stg_zeimu_himoduke_judgev +stg_zeimu_meisai_judgev +stg_jugyoin_masta_judgev +stg_jcard_meisai_judgev +stg_bumonctl_masta_judgev +stg_yosankbn_masta_judgev +stg_yosankmk_masta_judgev +stg_yosanhmk_masta_judgev",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_mikado_judgev"})

                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
          "job_name": "job_build_stg_mikado_judgev"},
)
