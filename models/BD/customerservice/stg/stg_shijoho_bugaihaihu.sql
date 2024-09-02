{{ 
  config(
    materialized='incremental',
    unique_key = ['ftr_no', 'outside_cmpny_code', 'outside_div_code'],
    incremental_strategy = 'merge'
  )
 }}

with stg_shijoho_bugaihaihu as (
    select
        ftr_no::varchar(14) as ftr_no, --なし
        outside_cmpny_code::varchar(7) as outside_cmpny_code, --なし
        outside_div_code::varchar(5) as outside_div_code, --なし
        dist_cls::varchar(1) as dist_cls, --なし
        outside_flg::varchar(1) as outside_flg, --なし
        all_fw_date::timestamp_ntz as all_fw_date, --timestamp型
        old_distrib_name_jp::varchar(207) as old_distrib_name_jp, --なし
        old_distrib_name_us::varchar(207) as old_distrib_name_us, --なし
        old_distrib_name_zh::varchar(207) as old_distrib_name_zh, --なし
        db_user_id_tqnet::varchar(11) as db_user_id_tqnet, --なし
        db_proc_id_tqnet::varchar(8) as db_proc_id_tqnet, --なし
        db_insert_time_tqnet::timestamp_ntz as db_insert_time_tqnet, --timestamp型
        db_update_time_tqnet::timestamp_ntz as db_update_time_tqnet, --timestamp型
        update_cls::varchar(1) as update_cls, --なし
        mtuser::varchar(18) as mtuser, --なし
        mttime::timestamp_ntz as mttime, --timestamp型
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_customerservice', 'raw_cep0715ftr_outside') }}
     where _fivetran_deleted = 'FALSE'

{% if is_incremental() %}
    and _fivetran_synced > (select max(ldts) from {{this}})
{% endif %}

    )
select * from stg_shijoho_bugaihaihu