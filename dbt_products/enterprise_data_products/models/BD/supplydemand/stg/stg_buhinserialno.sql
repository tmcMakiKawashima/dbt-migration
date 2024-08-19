{{ config(
      materialized='incremental',
      unique_key = ['index_cls', 'syadai_kt', 'wmi', 'vds', 'vis', 'parts_id', 'parts_repl_seq'],
      incremental_strategy = 'merge'
   ) }}

with stg_buhinserialno as (
    select
        index_cls::varchar(3) as index_cls, -- なし
        frame_cls::varchar(6) as syadai_kt, -- なし
        frame_no::varchar(7) as frmno, -- なし
        vin_wmi::varchar(3) as wmi,-- なし
        vin_vds::varchar(6) as vds,-- なし
        vin_vis::varchar(8) as vis, -- なし
        parts_id::varchar(4) as parts_id,-- なし
        parts_repl_seq::varchar(2) as parts_repl_seq, -- なし
        rtrim(parts_ser_no, ' 　')::varchar(50) as parts_ser_no, -- 右ブランク
        parts_ser_no_cls::varchar(1) as parts_ser_no_cls, -- なし
        product_msg_no::varchar(4) as product_msg_no, -- なし
        parts_repl_date::varchar(8) as parts_repl_date, -- なし
        mtuser::varchar(18) as mtuser, -- なし
        mttime::timestamp_ntz as mttime, --timestamp型
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_supplydemand', 'raw_cep1004serno') }}
    where _fivetran_deleted = 'FALSE'
           {% if is_incremental() %}
               and ldts > (select max(ldts) from {{this}})
           {% endif %}
)
select * from stg_buhinserialno