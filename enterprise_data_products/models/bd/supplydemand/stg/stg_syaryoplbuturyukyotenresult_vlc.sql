{{
    config (
        materialized = 'incremental',
        unique_key = ['vhc_key', 'kyoten_cd', 'kyoten_kaisu', 'tp_kbn'],
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (vhc_key, kyoten_cd, kyoten_kaisu, tp_kbn) in (select vhc_key, kyoten_cd, kyoten_kaisu, tp_kbn
                from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc029logkyotenresult') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_syaryoplbuturyukyotenresult_vlc as (
    select
        vhc_key::varchar(15) as vhc_key, 
        kyoten_cd::varchar(20) as kyoten_cd, 
        kyoten_kaisu::varchar(1) as kyoten_kaisu, 
        tp_kbn::varchar(2) as tp_kbn, 
        final_dest_flg::varchar(1) as final_dest_flg, 
        ship_final_dest_sign::varchar(1) as ship_final_dest_sign, 
        zaihai_sign::varchar(1) as zaihai_sign, 
        zaiko_sign::varchar(1) as zaiko_sign, 
        haisya_chushi_sign::varchar(1) as haisya_chushi_sign, 
        saisin_sts_flg::varchar(1) as saisin_sts_flg, 
        prdct_line::varchar(1) as prdct_line, 
        in_datetime_jsk::varchar(12) as in_datetime_jsk, 
        out_datetime_jsk::varchar(12) as out_datetime_jsk, 
        koujyo_reki::varchar(13) as koujyo_reki, 
        inst_datetime::timestamp_ntz(9) as inst_datetime, 
        inst_id::varchar(20) as inst_id, 
        upd_datetime::timestamp_ntz(9) as upd_datetime, 
        upd_id::varchar(20) as upd_id, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubc029logkyotenresult') }}
    where _fivetran_deleted = 'false'
)
select * from stg_syaryoplbuturyukyotenresult_vlc

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}