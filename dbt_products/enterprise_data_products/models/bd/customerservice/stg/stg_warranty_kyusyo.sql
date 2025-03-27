{{ config(
      materialized='incremental',
      unique_key = ['settle_date_y', 'settle_date_m', 'dealer_code', 'twc_no', 'frmkbn', 'frmno', 'wmi', 'vds', 'vis', 'cmp_suppli_code', 'cmp_settle_date_y', 'cmp_settle_date_m'],
      incremental_strategy = 'merge'
   ) }}

with stg_warranty_kyusyo as (
    select
        settle_date_y::varchar(4) as settle_date_y, -- なし
        settle_date_m::varchar(2) as settle_date_m, -- なし
        dealer_code::varchar(5) as dealer_code, -- なし
        twc_no::varchar(9) as twc_no, -- なし
        frame_cls::varchar(6) as frmkbn, -- なし
        frame_no::varchar(7) as frmno, -- なし
        vin_wmi::varchar(3) as wmi, -- なし
        vin_vds::varchar(6) as vds, -- なし
        vin_vis::varchar(8) as vis, -- なし
        cmp_suppli_code::varchar(4) as cmp_suppli_code, -- なし
        cmp_settle_date_y::varchar(4) as cmp_settle_date_y, -- なし
        cmp_settle_date_m::varchar(2) as cmp_settle_date_m, -- なし
        try_to_date(cmp_settle_date_y || cmp_settle_date_m || '01', 'yyyymmdd' ) as cmp_settle_date_ymd, -- date型
        vin_my::varchar(1) as vin_my, -- なし
        vin_cd::varchar(1) as vin_cd, -- なし
        cmp_amount_ofp::number(9) as cmp_amount_ofp, -- なし
        cmp_amount_parts::number(9) as cmp_amount_parts, -- なし
        cmp_amount_labor::number(9) as cmp_amount_labor, -- なし
        cmp_amount_total::number(9) as cmp_amount_total, -- なし
        cmp_resp_rate_parts::number(5,2) as cmp_resp_rate_parts, -- なし
        cmp_resp_rate_labor::number(5,2) as cmp_resp_rate_labor, -- なし
        cmp_purch_agent::varchar(2) as cmp_purch_agent, -- なし
        cmp_bill_no::varchar(5) as cmp_bill_no, -- なし
        cmp_proc_date::varchar(8) as cmp_proc_date, -- なし
        cmp_ofp::varchar(10) as cmp_ofp, -- なし
        cmp_amount_ovs_rarts::number(11,4) as cmp_amount_ovs_rarts, -- なし
        cmp_amount_ovs_labor::number(11,4) as cmp_amount_ovs_labor, -- なし
        cmp_currency_cls::varchar(2) as cmp_currency_cls, -- なし
        mtuser::varchar(18) as mtuser, -- なし
        mttime::timestamp_ntz as mttime, -- timestamp型
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_oraclerds_orcl_iqas_osepcs0000db20', 'raw_cep0009kyusyo') }}
    where _fivetran_deleted = 'false'
           {% if is_incremental() %}
               and ldts > (select max(ldts) from {{this}})
           {% endif %}
)
select * from stg_warranty_kyusyo