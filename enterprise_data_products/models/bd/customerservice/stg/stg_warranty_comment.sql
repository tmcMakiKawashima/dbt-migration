{{ 
  config(
    materialized='incremental',
    unique_key = ['settle_date_y','settle_date_m','dealer_code','twc_no','frmkbn','frmno','wmi','vds','vis'],
    incremental_strategy = 'merge'
  )
 }}

with stg_warranty_comment as (
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
        fault_comment_condition::varchar(450) as fault_comment_condition, --なし
        fault_comment_condition_ja::varchar(900) as fault_comment_condition_ja, --なし
        fault_comment_condition_en::varchar(900) as fault_comment_condition_en, --なし
        fault_comment_condition_zh::varchar(900) as fault_comment_condition_zh, --なし
        comment_condition_lang_cls::varchar(2) as comment_condition_lang_cls, --なし
        fault_comment_cause::varchar(450) as fault_comment_cause, --なし
        fault_comment_cause_ja::varchar(900) as fault_comment_cause_ja, --なし
        fault_comment_cause_en::varchar(900) as fault_comment_cause_en, --なし
        fault_comment_cause_zh::varchar(900) as fault_comment_cause_zh, --なし
        comment_cause_lang_cls::varchar(2) as comment_cause_lang_cls, --なし
        fault_comment_remedy::varchar(450) as fault_comment_remedy, --なし
        fault_comment_remedy_ja::varchar(900) as fault_comment_remedy_ja, --なし
        fault_comment_remedy_en::varchar(900) as fault_comment_remedy_en, --なし
        fault_comment_remedy_zh::varchar(900) as fault_comment_remedy_zh, --なし
        comment_remedy_lang_cls::varchar(2) as comment_remedy_lang_cls, --なし
        touch_comment_ja::varchar(900) as touch_comment_ja, --なし
        touch_comment_en::varchar(900) as touch_comment_en, --なし
        touch_comment_zh::varchar(900) as touch_comment_zh, --なし
        mtuser::varchar(18) as mtuser, --なし
        mttime::timestamp_ntz as mttime, --timestamp型
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_oraclerds_orcl_iqas_osepcs0000db20', 'raw_cep0003wrntcom') }}
     where _fivetran_deleted = 'false'

{% if is_incremental() %}                                                                                                              -- ② 増分の取り方を指定
    and _fivetran_synced > (select max(ldts) from {{this}})
{% endif %}

    )
select * from stg_warranty_comment