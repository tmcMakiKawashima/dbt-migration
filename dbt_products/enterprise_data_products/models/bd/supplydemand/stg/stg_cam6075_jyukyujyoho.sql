{{
    config (
        materialized = 'incremental',
        unique_key = ['carnm_cd', 'aply_dt_kara'],
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (carnm_cd, aply_dt_kara) in (select carnm_cd, aply_dt_kara
                from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp02sam202', 'raw_cam6075') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}

with stg_cam6075_jyukyujyoho as (
    select
        carnm_cd::varchar(2) as carnm_cd, 
        carnm_ttl::varchar(60) as carnm_ttl, 
        carnm_kana_ttl::varchar(120) as carnm_kana_ttl, 
        time_stmp::timestamp_ntz(9) as time_stmp, 
        aply_dt_kara::varchar(8) as aply_dt_kara, 
        aply_dt_made::varchar(8) as aply_dt_made, 
        create_user::varchar(15) as create_user, 
        create_date::timestamp_ntz(9) as create_date,
        update_user::varchar(15) as update_user, 
        update_date::timestamp_ntz(9) as update_date,
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp02sam202', 'raw_cam6075') }}
    where _fivetran_deleted = 'false'
)
select * from stg_cam6075_jyukyujyoho

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}