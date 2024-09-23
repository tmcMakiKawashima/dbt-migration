{{ config(
      materialized='incremental',
      unique_key = ['settle_date_y', 'settle_date_m', 'dealer_code', 'twc_no', 'frmkbn', 'frmno', 'wmi', 'vds', 'vis'],
      incremental_strategy = 'merge'
   ) }}

with stg_warranty as (
    select
        settle_date_y::varchar(4) as settle_date_y, -- なし
        settle_date_m::varchar(2) as settle_date_m, -- なし
        try_to_date(settle_date_y || settle_date_m || '01', 'yyyymmdd' ) as settle_date_ymd, -- date型
        dealer_code::varchar(5) as dealer_code, -- なし
        twc_no::varchar(9) as twc_no, -- なし
        frame_cls::varchar(6) as frmkbn, -- なし
        frame_no::varchar(7) as frmno, -- なし
        vin_wmi::varchar(3) as wmi, -- なし
        vin_vds::varchar(6) as vds, -- なし
        vin_vis::varchar(8) as vis, -- なし
        vin_my::varchar(1) as my, -- なし
        vin_cd::varchar(1) as cd, -- なし
        ofp_u5::varchar(5) as ofp_u5, -- なし
        ofp_m5::varchar(5) as ofp_m5, -- なし
        ofp_l5::varchar(5) as ofp_l5, -- なし
        ofp_u5 || ofp_m5::varchar(10) as ofp_u10, -- 結合 主原因品番_上5桁 || 主原因品番_中5桁
        ofp_u5 || ofp_m5 || ofp_l5::varchar(15) as ofp, -- 結合 主原因品番_上5桁 || 主原因品番_中5桁 || 主原因品番_下5桁
        wrnt_data_id::varchar(1) as wrnt_data_id, -- なし
        fault_cls::varchar(1) as fault_cls, -- なし
        func_code::varchar(1) as func_code, -- なし
        fault_code::varchar(7) as fault_code, -- なし
        t1_code::varchar(2) as t1_code, -- なし
        t2_code::varchar(2) as t2_code, -- なし
        w_code::varchar(2) as w_code, -- なし
        warranty_cls::varchar(1) as warranty_cls, -- なし
        operat_code::varchar(5) as operat_code, -- なし
        maint_code::varchar(8) as maint_code, -- なし
        mileage_km_sum::number(3) as mileage_km_sum, -- なし
        mileage_km::number(7) as mileage_km, -- なし
        repair_cls::varchar(1) as repair_cls, -- なし
        add_operat::varchar(1) as add_operat, -- なし
        ss_repair_cls::varchar(1) as ss_repair_cls, -- なし
        product_cls::varchar(1) as product_cls, -- なし
        wrnt_type::varchar(2) as wrnt_type, -- なし
        type_cls::varchar(2) as type_cls, -- なし
        parts_source_cls::varchar(1) as parts_source_cls, -- なし
        wrnt_period::varchar(1) as wrnt_period, -- なし
        reg_repair_month::number(3) as reg_repair_month, -- なし
        last_n_month::varchar(3) as last_n_month, -- なし
        data_id::varchar(1) as data_id, -- なし
        repair_date_y::varchar(4) as repair_date_y, -- なし
        repair_date_m::varchar(2) as repair_date_m, -- なし
        repair_date_d::varchar(2) as repair_date_d, -- なし
        try_to_date(repair_date_y || repair_date_m || repair_date_d, 'yyyymmdd' ) as repair_date_ymd, -- date型
        twc_send_date::varchar(8) as twc_send_date, -- なし
        repair_region_cls::varchar(1) as repair_region_cls, -- なし
        repair_state_code::varchar(3) as repair_state_code, -- なし
        repair_deal_code::varchar(8) as repair_deal_code, -- なし
        direct_cls::varchar(1) as direct_cls, -- なし
        cost_alloc_cls::varchar(1) as cost_alloc_cls, -- なし
        spl_ope_no::varchar(5) as spl_ope_no, -- なし
        payment_cls::varchar(2) as payment_cls, -- なし
        complaint_cls::varchar(1) as complaint_cls, -- なし
        wrnt_reg_date_y::varchar(4) as wrnt_reg_date_y, -- なし
        wrnt_reg_date_m::varchar(2) as wrnt_reg_date_m, -- なし
        wrnt_reg_date_d::varchar(2) as wrnt_reg_date_d, -- なし
        try_to_date(wrnt_reg_date_y || wrnt_reg_date_m || wrnt_reg_date_d, 'yyyymmdd' ) as wrnt_reg_date_ymd, -- date型
        amount_parts::number(9) as amount_parts, -- なし
        amount_parts_hc::number(9) as amount_parts_hc, -- なし
        amount_parts_pppc::number(9) as amount_parts_pppc, -- なし
        amount_parts_amt::number(9) as amount_parts_amt, -- なし
        amount_parts_tax::number(9) as amount_parts_tax, -- なし
        amount_parts_total::number(9) as amount_parts_total, -- なし
        amount_labor::number(9) as amount_labor, -- なし
        amount_labor_hc::number(9) as amount_labor_hc, -- なし
        amount_labor_amt::number(9) as amount_labor_amt, -- なし
        amount_labor_tax::number(9) as amount_labor_tax, -- なし
        amount_labor_total::number(9) as amount_labor_total, -- なし
        amount_sublet::number(9) as amount_sublet, -- なし
        amount_sublet_towing::number(9) as amount_sublet_towing, -- なし
        amount_sublet_hc::number(9) as amount_sublet_hc, -- なし
        amount_sublet_amt::number(9) as amount_sublet_amt, -- なし
        amount_sublet_tax::number(9) as amount_sublet_tax, -- なし
        amount_sublet_total::number(9) as amount_sublet_total, -- なし
        amount_amt_total::number(9) as amount_amt_total, -- なし
        amount_tax_total::number(9) as amount_tax_total, -- なし
        amount_total::number(9) as amount_total, -- なし
        amount_parts_yen::number(9) as amount_parts_yen, -- なし
        amount_parts_hc_yen::number(9) as amount_parts_hc_yen, -- なし
        amount_parts_pppc_yen::number(9) as amount_parts_pppc_yen, -- なし
        amount_parts_amt_yen::number(9) as amount_parts_amt_yen, -- なし
        amount_parts_tax_yen::number(9) as amount_parts_tax_yen, -- なし
        amount_parts_total_yen::number(9) as amount_parts_total_yen, -- なし
        amount_labor_yen::number(9) as amount_labor_yen, -- なし
        amount_labor_hc_yen::number(9) as amount_labor_hc_yen, -- なし
        amount_labor_amt_yen::number(9) as amount_labor_amt_yen, -- なし
        amount_labor_tax_yen::number(9) as amount_labor_tax_yen, -- なし
        amount_labor_total_yen::number(9) as amount_labor_total_yen, -- なし
        amount_sublet_yen::number(9) as amount_sublet_yen, -- なし
        amount_sublet_towing_yen::number(9) as amount_sublet_towing_yen, -- なし
        amount_sublet_hc_yen::number(9) as amount_sublet_hc_yen, -- なし
        amount_sublet_amt_yen::number(9) as amount_sublet_amt_yen, -- なし
        amount_sublet_tax_yen::number(9) as amount_sublet_tax_yen, -- なし
        amount_sublet_total_yen::number(9) as amount_sublet_total_yen, -- なし
        amount_amt_total_yen::number(9) as amount_amt_total_yen, -- なし
        amount_tax_total_yen::number(9) as amount_tax_total_yen, -- なし
        amount_total_yen::number(9) as amount_total_yen, -- なし
        currency_cls::varchar(1) as currency_cls, -- なし
        exchange_rate::number(9,4) as exchange_rate, -- なし
        norml_operat_time::number(5,1) as norml_operat_time, -- なし
        diag_code1::varchar(7) as diag_code1, -- なし
        diag_code2::varchar(7) as diag_code2, -- なし
        diag_code3::varchar(7) as diag_code3, -- なし
        diag_code4::varchar(7) as diag_code4, -- なし
        diag_code5::varchar(7) as diag_code5, -- なし
        main_diag_code::varchar(8) as main_diag_code, -- なし
        dop_attach_date::varchar(8) as dop_attach_date, -- なし
        deal_suppli_code::varchar(4) as deal_suppli_code, -- なし
        ftr_no::varchar(14) as ftr_no, -- なし
        ftr_type::varchar(1) as ftr_type, -- なし
        parts_mng_no::varchar(6) as parts_mng_no, -- なし
        parts_send_date::varchar(8) as parts_send_date, -- なし
        parts_send_cls::varchar(2) as parts_send_cls, -- なし
        parts_send_sts::varchar(1) as parts_send_sts, -- なし
        cmp_price_parts::number(9,2) as cmp_price_parts, -- なし
        cmp_price_ofp::number(9,2) as cmp_price_ofp, -- なし
        cmp_recurrence_cls::varchar(1) as cmp_recurrence_cls, -- なし
        cmp_sptp_cls::varchar(1) as cmp_sptp_cls, -- なし
        cmp_settle_cls::varchar(1) as cmp_settle_cls, -- なし
        cmp_bill_cls::varchar(1) as cmp_bill_cls, -- なし
        cmp_carry_over::varchar(1) as cmp_carry_over, -- なし
        cmp_fault_cls::varchar(1) as cmp_fault_cls, -- なし
        cmp_region_cls::varchar(1) as cmp_region_cls, -- なし
        cmp_resp_cls::varchar(1) as cmp_resp_cls, -- なし
        cmp_design_resp_cls::varchar(1) as cmp_design_resp_cls, -- なし
        cmp_wrnt_separ_cls::varchar(1) as cmp_wrnt_separ_cls, -- なし
        cmp_collation_cls::varchar(1) as cmp_collation_cls, -- なし
        cmp_oem_cls::varchar(1) as cmp_oem_cls, -- なし
        cmp_wrnt_amount_total::number(9) as cmp_wrnt_amount_total, -- なし
        cmp_resp_rate_labor::number(5,2) as cmp_resp_rate_labor, -- なし
        cmp_resp_rate_sublet::number(5,2) as cmp_resp_rate_sublet, -- なし
        cmp_resp_rate_parts::number(5,2) as cmp_resp_rate_parts, -- なし
        twc_vin_wmi::varchar(3) as twc_vin_wmi, -- なし
        twc_vin_vds::varchar(6) as twc_vin_vds, -- なし
        twc_vin_vds_cd::varchar(1) as twc_vin_vds_cd, -- なし
        twc_vin_vis::varchar(8) as twc_vin_vis, -- なし
        compo_code::varchar(5) as compo_code, -- なし
        pheno_code::varchar(3) as pheno_code, -- なし
        design_div_code::varchar(5) as design_div_code_wrnt, -- なし
        manufact_div_code::varchar(5) as manufact_div_code_wrnt, -- なし
        conf_pheno_flg::varchar(1) as conf_pheno_flg, -- なし
        follow_up_code::varchar(1) as follow_up_code, -- なし
        paid_compen_rate::number(5,3) as paid_compen_rate, -- なし
        paid_compen_cnt::number(5,3) as paid_compen_cnt, -- なし
        paid_cnt_flg::varchar(1) as paid_cnt_flg, -- なし
        normal_diag_time::number(5,1) as normal_diag_time, -- なし
        diag_actual_time::number(5,1) as diag_actual_time, -- なし
        func_field_code::varchar(7) as func_field_code, -- なし
        iqas_receive_date::varchar(8) as iqas_receive_date, -- なし
        parts_appearance_mng_no::varchar(9) as parts_appearance_mng_no, -- なし
        tmc_conf_pheno_cls::varchar(1) as tmc_conf_pheno_cls, -- なし
        vapt::varchar(1) as vapt, -- なし
        req_deal::varchar(5) as req_deal, -- なし
        manufact_suppli_code::varchar(10) as manufact_suppli_code, -- なし
        parts_repair_month::varchar(3) as parts_repair_month, -- なし
        mtuser::varchar(18) as mtuser, -- なし
        mttime::timestamp_ntz as mttime, -- timestamp型
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_customerservice', 'raw_cep0001wrntdata') }}
    where _fivetran_deleted = 'false'
           {% if is_incremental() %}
               and ldts > (select max(ldts) from {{this}})
           {% endif %}
)
select * from stg_warranty