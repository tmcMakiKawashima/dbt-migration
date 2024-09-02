{{ config(
      materialized='incremental',
      unique_key = ['settle_date_y', 'settle_date_m', 'dealer_code', 'twc_no', 'frmkbn', 'frmno', 'wmi', 'vds', 'vis'],
      incremental_strategy = 'merge'
   ) }}

with stg_warranty_chinesecomment as (
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
        fault_comment_condition::varchar(450) as fault_comment_condition, -- なし
        fault_comment_cause::varchar(450) as fault_comment_cause, -- なし
        fault_comment_remedy::varchar(450) as fault_comment_remedy, -- なし
        fault_comment_condition_ja::varchar(900) as fault_comment_condition_ja, -- なし
        fault_comment_condition_en::varchar(900) as fault_comment_condition_en, -- なし
        fault_comment_cause_ja::varchar(900) as fault_comment_cause_ja, -- なし
        fault_comment_cause_en::varchar(900) as fault_comment_cause_en, -- なし
        fault_comment_remedy_ja::varchar(900) as fault_comment_remedy_ja, -- なし
        fault_comment_remedy_en::varchar(900) as fault_comment_remedy_en, -- なし
        update_cls::varchar(1) as update_cls, -- なし
        mtuser::varchar(18) as mtuser, -- なし
        mttime::timestamp_ntz as mttime, -- timestamp型
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_customerservice', 'raw_cep0768warr_cn_cmt') }}
    where _fivetran_deleted = 'FALSE'
           {% if is_incremental() %}
               and ldts > (select max(ldts) from {{this}})
           {% endif %}
)
select * from stg_warranty_chinesecomment