{{
    config (
        materialized = 'incremental',
        unique_key = ['ojyy', 'segmei', 'dlrcd', 'odno', 'kubn'],
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (ojyy, segmei, dlrcd, odno, kubn) in (select ojyy, segmei, dlrcd, odno, kubn
                from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp01sam202', 'raw_cam2073') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_orderdb_buturyu_jyukyujyoho as (
    select
        ojyy::varchar(4) as ojyy, 
        dum1::varchar(1) as dum1, 
        segmei::varchar(8) as segmei, 
        dlrcd::varchar(5) as dlrcd, 
        odno::varchar(12) as odno, 
        kubn::varchar(1) as kubn, 
        dum2::varchar(103) as dum2, 
        kubn2::varchar(1) as kubn2, 
        yusosk2::varchar(8) as yusosk2, 
        tsdate::varchar(8) as tsdate, 
        jifuri::varchar(1) as jifuri, 
        tokcd::varchar(1) as tokcd, 
        kmaker::varchar(5) as kmaker, 
        hassou::varchar(1) as hassou, 
        seikyu::varchar(5) as seikyu, 
        dum3::varchar(60) as dum3, 
        create_user::varchar(15) as create_user, 
        create_date::timestamp_ntz(9) as create_date,
        update_user::varchar(15) as update_user, 
        update_date::timestamp_ntz(9) as update_date,
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp01sam202', 'raw_cam2073') }}
    where _fivetran_deleted = 'false'
)
select * from stg_orderdb_buturyu_jyukyujyoho

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}