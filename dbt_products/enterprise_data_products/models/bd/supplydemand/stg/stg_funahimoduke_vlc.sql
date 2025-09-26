{{
    config (
        materialized = 'incremental',
        unique_key = [
            'shiyuichita_kbn',
            'fune_cd',
            'tumikou_cd_g',
            'departure_datetime',
            'agekou_cd_g',
            'henkanmae_cd_g',
            'send_datetime'
        ],
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (shiyuichita_kbn, fune_cd, tumikou_cd_g, departure_datetime, agekou_cd_g, henkanmae_cd_g, send_datetime)
                in (select shiyuichita_kbn, fune_cd, tumikou_cd_g, departure_datetime, agekou_cd_g, henkanmae_cd_g, send_datetime
                from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubs009funahimoduke') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_funahimoduke_vlc as (
    select
        shiyuichita_kbn::varchar(1) as shiyuichita_kbn, 
        fune_cd::varchar(6) as fune_cd, 
        funemei::varchar(24) as funemei, 
        capa::varchar(4) as capa, 
        tumikou_cd_g::varchar(20) as tumikou_cd_g, 
        tumikou_cd_lot::varchar(7) as tumikou_cd_lot, 
        tumikou_mei::varchar(24) as tumikou_mei, 
        cutoff_datetime::varchar(12) as cutoff_datetime, 
        departure_datetime::varchar(12) as departure_datetime, 
        agekou_cd_g::varchar(20) as agekou_cd_g, 
        agekou_cd_lot::varchar(7) as agekou_cd_lot, 
        agekou_mei::varchar(24) as agekou_mei, 
        arrival_datetime::varchar(12) as arrival_datetime, 
        unload_datetime::varchar(12) as unload_datetime, 
        henkanmae_cd_g::varchar(20) as henkanmae_cd_g, 
        org_agekou_cd_lc::varchar(7) as org_agekou_cd_lc, 
        henkanmae_mei::varchar(24) as henkanmae_mei, 
        funadumi_daisu::varchar(4) as funadumi_daisu, 
        funawaku_daisu_tyousei::varchar(4) as funawaku_daisu_tyousei, 
        funawaku_daisu_haisys::varchar(4) as funawaku_daisu_haisys, 
        funawaku_joutai_kbn::varchar(1) as funawaku_joutai_kbn, 
        send_datetime::varchar(14) as send_datetime, 
        haisya_tourok_datetime::varchar(12) as haisya_tourok_datetime, 
        saisin_flg::varchar(1) as saisin_flg, 
        upddatetime::timestamp_ntz(9) as upddatetime, 
        upduid::varchar(20) as upduid, 
        insertdatetime::timestamp_ntz(9) as insertdatetime, 
        insertuid::varchar(20) as insertuid, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubs009funahimoduke') }}
    where _fivetran_deleted = 'false'
)
select * from stg_funahimoduke_vlc

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}