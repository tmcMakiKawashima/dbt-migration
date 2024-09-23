{{ config(
      materialized='incremental',
      unique_key = ['ftr_no'],
      incremental_strategy = 'merge'
   ) }}

with stg_shijoho_syareki as (
    select
        ftr_no::varchar(14) as ftr_no, -- なし
        ofp::varchar(15) as ofp, -- なし
        compo_code::varchar(5) as compo_code, -- なし
        pheno_code::varchar(3) as pheno_code, -- なし
        repair_date::varchar(8) as repair_date, -- なし
        dealer_code::varchar(5) as dealer_code, -- なし
        mileage_km::number(7) as mileage_km, -- なし
        twc_no::varchar(9) as twc_no, -- なし
        settle_date_ym::varchar(6) as settle_date_ym, -- なし
        try_to_date(settle_date_ym || '01', 'yyyymmdd' ) as settle_date_ymd, --date型
        fault_code::varchar(7) as fault_code, -- なし
        t1_code::varchar(2) as t1_code, -- なし
        t2_code::varchar(2) as t2_code, -- なし
        w_code::varchar(2) as w_code, -- なし
        operat_code::varchar(5) as operat_code, -- なし
        maint_code::varchar(8) as maint_code, -- なし
        parts_source_cls::varchar(1) as parts_source_cls, -- なし
        design_div_code::varchar(5) as design_div_code, -- なし
        judge_base_part_no::varchar(15) as judge_base_part_no, -- なし
        suppli_code_dom_ovs::varchar(6) as suppli_code_dom_ovs, -- なし
        suppli_code_ovs1::varchar(6) as suppli_code_ovs1, -- なし
        suppli_code_ovs2::varchar(6) as suppli_code_ovs2, -- なし
        suppli_code_ovs3::varchar(6) as suppli_code_ovs3, -- なし
        fault_comment_condition::varchar(450) as fault_comment_condition, -- なし
        fault_comment_cause::varchar(450) as fault_comment_cause, -- なし
        fault_comment_remedy::varchar(450) as fault_comment_remedy, -- なし
        diag_code1::varchar(7) as diag_code1, -- なし
        diag_code2::varchar(7) as diag_code2, -- なし
        diag_code3::varchar(7) as diag_code3, -- なし
        diag_code4::varchar(7) as diag_code4, -- なし
        diag_code5::varchar(7) as diag_code5, -- なし
        db_user_id_tqnet::varchar(11) as db_user_id_tqnet, -- なし
        db_proc_id_tqnet::varchar(8) as db_proc_id_tqnet, -- なし
        db_insert_time_tqnet::timestamp_ntz as db_insert_time_tqnet, -- timestamp型
        db_update_time_tqnet::timestamp_ntz as db_update_time_tqnet, -- timestamp型
        update_cls::varchar(1) as update_cls, -- なし
        mtuser::varchar(18) as mtuser, -- なし
        mttime::timestamp_ntz as mttime, -- timestamp型
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_customerservice', 'raw_cep0713ftr_history') }}
    where _fivetran_deleted = 'false'
           {% if is_incremental() %}
               and ldts > (select max(ldts) from {{this}})
           {% endif %}
)
select * from stg_shijoho_syareki