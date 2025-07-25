{{
    config (
        materialized = 'incremental',
        unique_key = ['vhc_key', 'kyoten_cd', 'kyoten_kaisu'],
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (vhc_key, kyoten_cd, kyoten_kaisu) in (select vhc_key, kyoten_cd, kyoten_kaisu
                from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc262nbkyotenjsk') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_cubc262nbkyotenjsk_vlc as (
    select
        vhc_key::varchar(15) as vhc_key, 
        kyoten_cd::varchar(20) as kyoten_cd, 
        kyoten_kaisu::varchar(1) as kyoten_kaisu, 
        keikaku_keiro_jun::varchar(3) as keikaku_keiro_jun, 
        kyoten_cd_fowd::varchar(20) as kyoten_cd_fowd, 
        kyoten_cd_next::varchar(20) as kyoten_cd_next, 
        hyouji_nm::varchar(24) as hyouji_nm, 
        hyouji_nm_fowd::varchar(24) as hyouji_nm_fowd, 
        hyouji_nm_cd_next::varchar(24) as hyouji_nm_cd_next, 
        outgate_datetime_fowd::varchar(12) as outgate_datetime_fowd, 
        ingate_datetime::varchar(12) as ingate_datetime, 
        outgate_datetime::varchar(12) as outgate_datetime, 
        okure_riyu_cd::varchar(3) as okure_riyu_cd, 
        okure_riyu_cd_nm::varchar(90) as okure_riyu_cd_nm, 
        okure_riyu_kbn::varchar(2) as okure_riyu_kbn, 
        okure_riyu_kbn_nm::varchar(90) as okure_riyu_kbn_nm, 
        okure_yoin_kbn::varchar(1) as okure_yoin_kbn, 
        okure_yoin_kbn_nm::varchar(48) as okure_yoin_kbn_nm, 
        kyoten_destmethod_fowd::varchar(1) as kyoten_destmethod_fowd, 
        kyoten_destmethod_next::varchar(1) as kyoten_destmethod_next, 
        final_dest_flg::varchar(1) as final_dest_flg, 
        limited_flg::varchar(1) as limited_flg, 
        tairyu_lt_jsk::varchar(7) as tairyu_lt_jsk, 
        tairyu_lt_jsk_hikado::varchar(7) as tairyu_lt_jsk_hikado, 
        dest_lt_jsk::varchar(7) as dest_lt_jsk, 
        laneno_kpi::varchar(5) as laneno_kpi, 
        lanesubno_kpi::varchar(4) as lanesubno_kpi, 
        noryokuno::varchar(7) as noryokuno, 
        tosai_position::varchar(2) as tosai_position, 
        businessoffice_cd::varchar(3) as businessoffice_cd, 
        businessoffice_nm::varchar(30) as businessoffice_nm, 
        district_cd::varchar(3) as district_cd, 
        district_nm::varchar(30) as district_nm, 
        kyotenarea_cd::varchar(3) as kyotenarea_cd, 
        kyotenarea_nm::varchar(30) as kyotenarea_nm, 
        ingate_kitencd_jsk_yns::varchar(7) as ingate_kitencd_jsk_yns, 
        ingate_kitencd_new_yns::varchar(7) as ingate_kitencd_new_yns, 
        fune_cd::varchar(6) as fune_cd, 
        fune_nm::varchar(24) as fune_nm, 
        cutoff_datetime::varchar(12) as cutoff_datetime, 
        rsltdeparture_datetime::varchar(12) as rsltdeparture_datetime, 
        rsltarrivaldate_datetime::varchar(12) as rsltarrivaldate_datetime, 
        unload_end_datetime::varchar(12) as unload_end_datetime, 
        funesu_plan_chakko::varchar(5) as funesu_plan_chakko, 
        funesu_plan_haisha::varchar(5) as funesu_plan_haisha, 
        funesu_jsk_chakko::varchar(5) as funesu_jsk_chakko, 
        funesu_jsk_haisha::varchar(5) as funesu_jsk_haisha, 
        unload_star_datetime::varchar(12) as unload_star_datetime, 
        upload_posbl_datetim::varchar(12) as upload_posbl_datetim, 
        kizai_upload_datetime::varchar(12) as kizai_upload_datetime, 
        tumikomi_end_datetime::varchar(12) as tumikomi_end_datetime, 
        inst_datetime::timestamp_ntz(9) as inst_datetime,
        inst_id::varchar(20) as inst_id, 
        upd_datetime::timestamp_ntz(9) as upd_datetime,
        upd_id::varchar(20) as upd_id, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc262nbkyotenjsk') }}
    where _fivetran_deleted = 'false'
)
select * from stg_cubc262nbkyotenjsk_vlc

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}