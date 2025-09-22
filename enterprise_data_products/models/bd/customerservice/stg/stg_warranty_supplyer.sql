{{ config(
      materialized='incremental',
      unique_key = ['settle_date_y','settle_date_m', 'dealer_code', 'twc_no', 'frmkbn', 'frmno', 'wmi', 'vds', 'vis', 'suppli_code_ovs'],
      incremental_strategy = 'merge'
   ) }}

with stg_warranty_supplyer as (
    select
        settle_date_y::varchar(4) as settle_date_y, --なし
        settle_date_m::varchar(2) as settle_date_m, --なし
        dealer_code::varchar(5) as dealer_code, --なし
        twc_no::varchar(9) as twc_no, --なし
        frame_cls::varchar(6) as frmkbn, --なし
        frame_no::varchar(7) as frmno, --なし
        vin_wmi::varchar(3) as wmi, --なし
        vin_vds::varchar(6) as vds, --なし
        vin_vis::varchar(8) as vis, --なし
        suppli_code_ovs::varchar(6) as suppli_code_ovs, --なし
        suppli_parts_cls::varchar(1) as suppli_parts_cls, --なし
        suppli_price::number(11,4) as suppli_price, --なし
        suppli_price_code::varchar(1) as suppli_price_code, --なし
        suupli_currency_code::varchar(3) as suupli_currency_code, --なし
        mtuser::varchar(18) as mtuser, --なし
        mttime::timestamp_ntz as mttime, --timestamp型
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_oraclerds_orcl_iqas_osepcs0000db20', 'raw_cep0008supley') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_warranty_supplyer
