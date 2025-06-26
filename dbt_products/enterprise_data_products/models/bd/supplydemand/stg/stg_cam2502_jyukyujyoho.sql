{{
    config (
        materialized = 'incremental',
        unique_key = 'r_area_code',
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (r_area_code) in (select r_area_code
                from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp0100db20', 'raw_cam2502') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}

with stg_cam2502_jyukyujyoho as (
    select
        r_area_code::varchar(1) as r_area_code, 
        r_area_name::varchar(10) as r_area_name, 
        r_division_code::varchar(1) as r_division_code, 
        r_section_code::varchar(3) as r_section_code, 
        r_update_time::timestamp_ntz(9) as r_update_time, 
        create_user::varchar(15) as create_user, 
        create_date::timestamp_ntz(9) as create_date, 
        update_user::varchar(15) as update_user, 
        update_date::timestamp_ntz(9) as update_date, 
        current_timestamp::timestamp_ntz(9) as load_date, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp0100db20', 'raw_cam2502') }}
    where _fivetran_deleted = 'false'
)
select * from stg_cam2502_jyukyujyoho

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}