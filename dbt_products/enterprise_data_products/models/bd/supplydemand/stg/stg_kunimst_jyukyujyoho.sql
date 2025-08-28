{{
    config (
        materialized = 'incremental',
        unique_key = 'r_country_code',
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (r_country_code) in (select r_country_code
                from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp0100db20', 'raw_cam2501') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}

with stg_kunimst_jyukyujyoho as (
    select
        r_country_code::varchar(3) as r_country_code, 
        r_country_name::varchar(20) as r_country_name, 
        r_division_code::varchar(1) as r_division_code, 
        r_area_code::varchar(1) as r_area_code, 
        r_opld_main::varchar(1) as r_opld_main, 
        r_opld_seq::varchar(2) as r_opld_seq, 
        r_osad_main::varchar(1) as r_osad_main, 
        r_osad_seq::varchar(2) as r_osad_seq, 
        r_jama_area::varchar(1) as r_jama_area, 
        r_un_flag::varchar(1) as r_un_flag, 
        r_nongex_flg::varchar(1) as r_nongex_flg, 
        r_busyocd::varchar(5) as r_busyocd, 
        r_semi_main_country::varchar(1) as r_semi_main_country, 
        r_update_time::timestamp_ntz(9) as r_update_time, 
        update_kbn::varchar(1) as update_kbn, 
        create_user::varchar(15) as create_user, 
        create_date::timestamp_ntz(9) as create_date, 
        update_user::varchar(15) as update_user, 
        update_date::timestamp_ntz(9) as update_date, 
        current_timestamp::timestamp_ntz(9) as load_date, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp0100db20', 'raw_cam2501') }}
    where _fivetran_deleted = 'false'
)
select * from stg_kunimst_jyukyujyoho

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}