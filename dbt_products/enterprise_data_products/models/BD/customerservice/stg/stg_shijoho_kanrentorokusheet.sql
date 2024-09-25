{{ 
  config(
    materialized='incremental',
    unique_key = ['ftr_no','reg_sheet_no'],
    incremental_strategy = 'merge'
  )
 }}                                                                                               -- ① incrementalを指定

with stg_shijoho_kanrentorokusheet as (
    select
        ftr_no::varchar(14) as ftr_no, --なし
        reg_sheet_no::varchar(9) as reg_sheet_no, --なし
        rlt_update_time::timestamp_ntz as rlt_update_time, --timestamp型
        db_user_id_tqnet::varchar(11) as db_user_id_tqnet, --なし
        db_proc_id_tqnet::varchar(8) as db_proc_id_tqnet, --なし
        db_insert_time_tqnet::timestamp_ntz as db_insert_time_tqnet, --timestamp型
        db_update_time_tqnet::timestamp_ntz as db_update_time_tqnet, --timestamp型
        update_cls::varchar(1) as update_cls, --なし
        mtuser::varchar(18) as mtuser, --なし
        mttime::timestamp_ntz as mttime, --timestamp型
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_customerservice', 'raw_cep0717ftr_reg') }}
     where _fivetran_deleted = 'false'

{% if is_incremental() %}                                                                                                              -- ② 増分の取り方を指定
    and _fivetran_synced > (select max(ldts) from {{this}})
{% endif %}

    )
select * from stg_shijoho_kanrentorokusheet