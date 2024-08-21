{{ config(
      materialized='incremental',
      unique_key = ['ftr_no', 'seq_ftr_rep'],
      incremental_strategy = 'merge'
   ) }}

with stg_shijoho_kokanbuhin as (
    select
        ftr_no::varchar(14) as ftr_no, -- なし
        seq_ftr_rep::varchar(3) as seq_ftr_rep, -- なし
        replace_parts::varchar(15) as replace_parts, -- なし
        db_user_id_tqnet::varchar(11) as db_user_id_tqnet, -- なし
        db_proc_id_tqnet::varchar(8) as db_proc_id_tqnet, -- なし
        db_insert_time_tqnet::timestamp_ntz as db_insert_time_tqnet, -- timestamp型
        db_update_time_tqnet::timestamp_ntz as db_update_time_tqnet, -- timestamp型
        update_cls::varchar(1) as update_cls, -- なし
        mtuser::varchar(18) as mtuser, -- なし
        mttime::timestamp_ntz as mttime, -- timestamp型
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_customerservice', 'raw_cep0718ftr_rep_part') }}
    where _fivetran_deleted = 'FALSE'
           {% if is_incremental() %}
               and ldts > (select max(ldts) from {{this}})
           {% endif %}
)
select * from stg_shijoho_kokanbuhin