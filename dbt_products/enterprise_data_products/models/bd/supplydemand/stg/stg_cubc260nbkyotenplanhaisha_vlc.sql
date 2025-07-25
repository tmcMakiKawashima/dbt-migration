{{
    config (
        materialized = 'incremental',
        unique_key = ['vhc_key', 'kyoten_cd', 'kyoten_kaisu'],
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (vhc_key, kyoten_cd, kyoten_kaisu) in (select vhc_key, kyoten_cd, kyoten_kaisu
                from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc260nbkyotenplanhaisha') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_cubc260nbkyotenplanhaisha_vlc as (
    select
        vhc_key::varchar(15) as vhc_key, 
        plan_section::varchar(2) as plan_section, 
        kyoten_cd_org::varchar(7) as kyoten_cd_org, 
        kyoten_cd::varchar(20) as kyoten_cd, 
        kyoten_kaisu::varchar(1) as kyoten_kaisu, 
        renkei_count::varchar(2) as renkei_count, 
        keikaku_keiro_jun::varchar(3) as keikaku_keiro_jun, 
        kyoten_cd_fowd::varchar(20) as kyoten_cd_fowd, 
        kyoten_cd_next::varchar(20) as kyoten_cd_next, 
        furikae_kyoten_cd_gkyoten_fowd::varchar(20) as furikae_kyoten_cd_gkyoten_fowd, 
        furikae_kyoten_cd::varchar(7) as furikae_kyoten_cd, 
        furikae_kyoten_cd_gkyoten::varchar(20) as furikae_kyoten_cd_gkyoten, 
        furikae_kyoten_cd_gkyoten_next::varchar(20) as furikae_kyoten_cd_gkyoten_next, 
        hyouji_nm::varchar(24) as hyouji_nm, 
        rtrim(hyouji_nm_fowd, ' 　')::varchar(256) as hyouji_nm_fowd, 
        hyouji_nm_cd_next::varchar(24) as hyouji_nm_cd_next, 
        furikae_kyoten_nm::varchar(24) as furikae_kyoten_nm, 
        furikae_kyoten_nm_fowd::varchar(24) as furikae_kyoten_nm_fowd, 
        furikae_kyoten_nm_next::varchar(24) as furikae_kyoten_nm_next, 
        in_datetime_plan_kaku::varchar(12) as in_datetime_plan_kaku, 
        out_datetime_plan_kaku::varchar(12) as out_datetime_plan_kaku, 
        in_datetime_plan_lt::varchar(12) as in_datetime_plan_lt, 
        out_datetime_plan_lt::varchar(12) as out_datetime_plan_lt, 
        in_datetime_plan_funa::varchar(12) as in_datetime_plan_funa, 
        out_datetime_plan_funa::varchar(12) as out_datetime_plan_funa, 
        rikukai_kbn_fowd::varchar(1) as rikukai_kbn_fowd, 
        rikukai_kbn_next::varchar(1) as rikukai_kbn_next, 
        nouki_fydm_kyoten_flg::varchar(1) as nouki_fydm_kyoten_flg, 
        mzai_tecs_nokan_kbn::varchar(1) as mzai_tecs_nokan_kbn, 
        hokanti_tome_flg::varchar(1) as hokanti_tome_flg, 
        saisyu_agekou_flg::varchar(1) as saisyu_agekou_flg, 
        haisha_hadure_fg::varchar(1) as haisha_hadure_fg, 
        haisha_hadure_yns::varchar(7) as haisha_hadure_yns, 
        tairyu_lt_mst::varchar(7) as tairyu_lt_mst, 
        tairyu_lt_plan::varchar(7) as tairyu_lt_plan, 
        tairyu_lt_plan_hikado::varchar(7) as tairyu_lt_plan_hikado, 
        kasan_lt_mst::varchar(7) as kasan_lt_mst, 
        dest_lt_mst::varchar(7) as dest_lt_mst, 
        dest_lt::varchar(7) as dest_lt, 
        businessoffice_cd::varchar(3) as businessoffice_cd, 
        businessoffice_nm::varchar(30) as businessoffice_nm, 
        district_cd::varchar(3) as district_cd, 
        district_nm::varchar(30) as district_nm, 
        kyotenarea_cd::varchar(3) as kyotenarea_cd, 
        kyotenarea_nm::varchar(30) as kyotenarea_nm, 
        fune_cd::varchar(6) as fune_cd, 
        fune_nm::varchar(24) as fune_nm, 
        cutoff_datetime::varchar(12) as cutoff_datetime, 
        departure_datetime::varchar(12) as departure_datetime, 
        arrival_datetime::varchar(12) as arrival_datetime, 
        unload_datetime::varchar(12) as unload_datetime, 
        inst_datetime::timestamp_ntz(9) as inst_datetime, 
        inst_id::varchar(20) as inst_id, 
        upd_datetime::timestamp_ntz(9) as upd_datetime, 
        upd_id::varchar(20) as upd_id, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc260nbkyotenplanhaisha') }}
    where _fivetran_deleted = 'false'
)
select * from stg_cubc260nbkyotenplanhaisha_vlc

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}