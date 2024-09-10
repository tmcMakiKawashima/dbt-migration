{{ config(
      materialized='incremental',
      unique_key = ['settle_date_y', 'settle_date_m', 'dealer_code', 'twc_no', 'frmkbn', 'frmno', 'wmi', 'vds', 'vis'],
      incremental_strategy = 'merge'
   ) }}

with stg_warranty_wcube as (
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
        cmpny_code_10::varchar(10) as company_cd, -- なし
        tmc_receive_date::varchar(8) as tmc_receive_date, -- なし
        wcube_cls::varchar(1) as wcube_cls, -- なし
        proc_data_cls::varchar(1) as proc_data_cls, -- なし
        hand_make_code::varchar(10) as hand_make_code, -- なし
        claimant_code::varchar(5) as claimant_code, -- なし
        vendor_code::varchar(5) as vendor_code, -- なし
        invoice_no::varchar(7) as invoice_no, -- なし
        franchise_code::varchar(1) as franchise_code, -- なし
        stwc_proc_date::varchar(8) as stwc_proc_date, -- なし
        process_flg::varchar(1) as process_flg, -- なし
        non_veh_flg::varchar(1) as non_veh_flg, -- なし
        local_ofp_flg::varchar(1) as local_ofp_flg, -- なし
        export_parts_cls::varchar(1) as export_parts_cls, -- なし
        judge_base_part_no::varchar(15) as judge_base_part_no, -- なし
        operat_cls::varchar(1) as operat_cls, -- なし
        org_mis::number(3,0) as org_mis, -- なし
        org_mileage_km::number(7,0) as org_mileage_km, -- なし
        deal_wrnt_no::varchar(18) as deal_wrnt_no, -- なし
        deal_repair_no::varchar(7) as deal_repair_no, -- なし
        ac_attach_date::varchar(8) as ac_attach_date, -- なし
        ac_attach_mlg_km::number(7,0) as ac_attach_mlg_km, -- なし
        prev_deal_repair_no::varchar(7) as prev_deal_repair_no, -- なし
        prev_repair_date::varchar(8) as prev_repair_date, -- なし
        prev_repair_mlg_km::number(7,0) as prev_repair_mlg_km, -- なし
        prev_ofp::varchar(15) as prev_ofp, -- なし
        prev_parts_suppli::varchar(5) as prev_parts_suppli, -- なし
        other_currency_cls::varchar(1) as other_currency_cls, -- なし
        other_exchange_rate::number(9,4) as other_exchange_rate, -- なし
        adjust_2rate_parts::number(3,0) as adjust_2rate_parts, -- なし
        adjust_2rate_labor::number(3,0) as adjust_2rate_labor, -- なし
        adjust_2rate_sublet::number(3,0) as adjust_2rate_sublet, -- なし
        pwr1::number(5,3) as pwr1, -- なし
        labor_price::number(7,0) as labor_price, -- なし
        dist_amount_parts_hc1::number(9,0) as dist_amount_parts_hc1, -- なし
        dist_amount_parts_hc2::number(9,0) as dist_amount_parts_hc2, -- なし
        dist_amount_parts_hc3::number(9,0) as dist_amount_parts_hc3, -- なし
        dist_amount_parts_hc4::number(9,0) as dist_amount_parts_hc4, -- なし
        dist_amount_parts_hc5::number(9,0) as dist_amount_parts_hc5, -- なし
        dist_amount_parts_hc6::number(9,0) as dist_amount_parts_hc6, -- なし
        dist_amount_parts_hc7::number(9,0) as dist_amount_parts_hc7, -- なし
        dist_amount_parts_hc8::number(9,0) as dist_amount_parts_hc8, -- なし
        dist_response_cls::varchar(1) as dist_response_cls, -- なし
        sw104_no::varchar(7) as sw104_no, -- なし
        sw104_date::varchar(8) as sw104_date, -- なし
        sw104_settle_date_ym::varchar(6) as sw104_settle_date_ym, -- なし
        try_to_date(sw104_settle_date_ym || '01', 'yyyymmdd' ) as sw104_settle_date_ymd, -- date型
        sw104_receive_date::varchar(8) as sw104_receive_date, -- なし
        re_cost_alloc_cls::varchar(1) as re_cost_alloc_cls, -- なし
        cmp_system_cls::varchar(1) as cmp_system_cls, -- なし
        plnt_resp_judge_cls::varchar(1) as plnt_resp_judge_cls, -- なし
        veh_manufact_plnt_code::varchar(10) as veh_manufact_plnt_code, -- なし
        export_parts_proc_date::varchar(8) as export_parts_proc_date, -- なし
        wrnt_type2::varchar(1) as wrnt_type2, -- なし
        re_settle_no::varchar(1) as re_settle_no, -- なし
        first_manufact_code1::varchar(10) as first_manufact_code1, -- なし
        first_manufact_code2::varchar(10) as first_manufact_code2, -- なし
        first_manufact_code3::varchar(10) as first_manufact_code3, -- なし
        re_manufact_code1::varchar(10) as re_manufact_code1, -- なし
        re_manufact_code2::varchar(10) as re_manufact_code2, -- なし
        re_manufact_code3::varchar(10) as re_manufact_code3, -- なし
        first_settle_date_ym::varchar(6) as first_settle_date_ym, -- なし
        try_to_date(first_settle_date_ym || '01', 'yyyymmdd' ) as first_settle_date_ymd, -- date型
        re_settle_date_ym::varchar(6) as re_settle_date_ym, -- なし
        try_to_date(re_settle_date_ym || '01', 'yyyymmdd' ) as re_settle_date_ymd, -- date型
        first_manufact_date_ym::varchar(6) as first_manufact_date_ym, -- なし
        try_to_date(first_manufact_date_ym || '01', 'yyyymmdd' ) as first_manufact_date_ymd, -- date型
        re_manufact_date_ym::varchar(6) as re_manufact_date_ym, -- なし
        try_to_date(re_manufact_date_ym || '01', 'yyyymmdd' ) as re_manufact_date_ymd, -- date型
        re_settle_cls::varchar(1) as re_settle_cls, -- なし
        re_settle_proc_no::varchar(10) as re_settle_proc_no, -- なし
        first_tent_final_cls::varchar(1) as first_tent_final_cls, -- なし
        re_tent_final_cls::varchar(1) as re_tent_final_cls, -- なし
        first_cmpny_tent_final_cls::varchar(1) as first_cmpny_tent_final_cls, -- なし
        re_cmpny_tent_final_cls::varchar(1) as re_cmpny_tent_final_cls, -- なし
        first_resp_rate::number(5,2) as first_resp_rate, -- なし
        re_resp_rate::number(5,2) as re_resp_rate, -- なし
        first_loc_resp_rate::number(5,2) as first_loc_resp_rate, -- なし
        re_loc_resp_rate::number(5,2) as re_loc_resp_rate, -- なし
        first_cmpny_resp_rate::number(5,2) as first_cmpny_resp_rate, -- なし
        re_cmpny_resp_rate::number(5,2) as re_cmpny_resp_rate, -- なし
        first_manufact_resp_rate1::number(5,2) as first_manufact_resp_rate1, -- なし
        first_manufact_resp_rate2::number(5,2) as first_manufact_resp_rate2, -- なし
        first_manufact_resp_rate3::number(5,2) as first_manufact_resp_rate3, -- なし
        re_manufact_resp_rate1::number(5,2) as re_manufact_resp_rate1, -- なし
        re_manufact_resp_rate2::number(5,2) as re_manufact_resp_rate2, -- なし
        re_manufact_resp_rate3::number(5,2) as re_manufact_resp_rate3, -- なし
        first_all_manufact_resp_rate::number(5,2) as first_all_manufact_resp_rate, -- なし
        re_all_manufact_resp_rate::number(5,2) as re_all_manufact_resp_rate, -- なし
        first_resettle_cls::varchar(1) as first_resettle_cls, -- なし
        re_resettle_cls::varchar(1) as re_resettle_cls, -- なし
        first_manufact_resettle_cls1::varchar(1) as first_manufact_resettle_cls1, -- なし
        first_manufact_resettle_cls2::varchar(1) as first_manufact_resettle_cls2, -- なし
        first_manufact_resettle_cls3::varchar(1) as first_manufact_resettle_cls3, -- なし
        re_manufact_resettle_cls1::varchar(1) as re_manufact_resettle_cls1, -- なし
        re_manufact_resettle_cls2::varchar(1) as re_manufact_resettle_cls2, -- なし
        re_manufact_resettle_cls3::varchar(1) as re_manufact_resettle_cls3, -- なし
        tmc_proc_date::varchar(8) as tmc_proc_date, -- なし
        manu_code::varchar(10) as manu_code, -- なし
        mtuser::varchar(18) as mtuser, -- なし
        mttime::timestamp as mttime, -- timestamp型
        _fivetran_synced::timestamp as ldts -- timestamp型
    from {{ source('fivetran_database_customerservice', 'raw_cep0002w3wranty') }}
    where _fivetran_deleted = 'FALSE'
           {% if is_incremental() %}
               and ldts > (select max(ldts) from {{this}})
           {% endif %}
)
select * from stg_warranty_wcube