from ....enterprise_data_products_assets.assets import DbtConfig, dbt_products_assets
from dagster import DefaultScheduleStatus, RunConfig
from dagster_dbt import build_schedule_from_dbt_selection
from pathlib import Path
import sys
sys.path.append(str(Path(__file__).resolve().parent.parent))

# 資材調達システム_UDC公開用
schedule_stg_maps = build_schedule_from_dbt_selection(
    [dbt_products_assets],
    job_name="job_build_stg_maps",
    schedule_name="MAPS",
    cron_schedule="00 06 * * *",
    execution_timezone="Asia/Tokyo",
    dbt_select="+stg_nyusyukkokensaku_maps_view +stg_syukko_keirihokan_maps_view +stg_juryo_keirihokan_maps_view +stg_hachu_keirihokan_maps_view +stg_yhinban_master_maps_view +stg_yhinban_shiiresaki_master_maps_view +stg_gashokanbasyo_maps_view +stg_calendar_master_maps_view +stg_postnodaihyosya_master_maps_view +stg_kijunhyo_kouzaitehai_maps_view +stg_kijunhyo_zaiko_maps_view +stg_kijunhyo_shikakenaiji_maps_view +stg_keiryohyo_maps_view +stg_chotatsuirai_kojokannai_maps_view +stg_kozaitehai_maps_view +stg_zaikotorihiki_maps_view +stg_sizainaiji_maps_view +stg_syuriyhinban_master_maps_view +stg_tokorobanchi_tetsu_maps_view +stg_tokorobanchi_tetsuigai_maps_view +stg_daitaihin_master_maps_view +stg_hachuirai_maps_view +stg_hachuhuka_maps_view +stg_tokorobanchi_tetsuigai_haishi_maps_view +stg_yojozai_tetsu_master_maps_view +stg_hachuhenko_maps_view +stg_yhinbanhenko_maps_view +stg_kessairoute_maps_view",
    config=RunConfig(ops={"dbt_products_assets":
                          DbtConfig(dbt_vars={"DBT_JOB_NAME": "_stg_maps"})
                          }
                     ),
    # default_status=DefaultScheduleStatus.RUNNING,
    tags={"ecs/cpu": "512", "ecs/memory": "2048",
            "job_name": "job_build_stg_maps"},
)
