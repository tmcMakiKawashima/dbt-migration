{{ config(
      materialized='incremental',
      unique_key = ['index_cls', 'syadai_kt', 'frmno', 'wmi', 'vds', 'vis', 'parts_id', 'parts_repl_seq'],
      incremental_strategy = 'merge'
   ) }}

with 
    cep1004serno_r as (
      select 
        index_cls as index_cls_r,
        frame_cls,
        frame_no,
        vin_wmi,
        vin_vds,
        vin_vis,
        parts_repl_seq
      from {{ source('fivetran_database_oraclerds_orcl_iqas_osepcs0000db20', 'raw_cep1004serno_r') }}
      where _fivetran_deleted = 'false'
      and mode_cls <> 'D' 
      group by
        index_cls,
        frame_cls,
        frame_no,
        vin_wmi,
        vin_vds,
        vin_vis,
        parts_repl_seq
    ),

    stg_buhinserialno as (
      select *
      from {{ source('fivetran_database_oraclerds_orcl_iqas_osepcs0000db20', 'raw_cep1004serno') }}
      where _fivetran_deleted = 'false'
   
      {% if is_incremental() %}
          and _fivetran_synced > (select max(ldts) from {{this}})
      {% endif %}
    
    )    
select
    stg_buhinserialno.index_cls::varchar(3) as index_cls, -- なし
    rtrim(stg_buhinserialno.frame_cls, ' 　')::varchar(6) as syadai_kt, -- 右ブランク
    stg_buhinserialno.frame_no::varchar(7) as frmno, -- なし
    stg_buhinserialno.vin_wmi::varchar(3) as wmi,-- なし
    stg_buhinserialno.vin_vds::varchar(6) as vds,-- なし
    stg_buhinserialno.vin_vis::varchar(8) as vis, -- なし
    stg_buhinserialno.parts_id::varchar(4) as parts_id,-- なし
    stg_buhinserialno.parts_repl_seq::varchar(2) as parts_repl_seq, -- なし
    rtrim(stg_buhinserialno.parts_ser_no, ' 　')::varchar(50) as parts_ser_no, -- 右ブランク
    stg_buhinserialno.parts_ser_no_cls::varchar(1) as parts_ser_no_cls, -- なし
    stg_buhinserialno.product_msg_no::varchar(4) as product_msg_no, -- なし
    stg_buhinserialno.parts_repl_date::varchar(8) as parts_repl_date, -- なし
    stg_buhinserialno.mtuser::varchar(18) as mtuser, -- なし
    stg_buhinserialno.mttime::timestamp_ntz as mttime, --timestamp型
    stg_buhinserialno._fivetran_synced::timestamp_ntz as ldts -- timestamp型
from stg_buhinserialno
inner join cep1004serno_r
    on stg_buhinserialno.index_cls = cep1004serno_r.index_cls_r
    and stg_buhinserialno.frame_cls = cep1004serno_r.frame_cls
    and stg_buhinserialno.frame_no = cep1004serno_r.frame_no
    and stg_buhinserialno.vin_wmi = cep1004serno_r.vin_wmi
    and stg_buhinserialno.vin_vds = cep1004serno_r.vin_vds
    and stg_buhinserialno.vin_vis = cep1004serno_r.vin_vis
    and stg_buhinserialno.parts_repl_seq = cep1004serno_r.parts_repl_seq