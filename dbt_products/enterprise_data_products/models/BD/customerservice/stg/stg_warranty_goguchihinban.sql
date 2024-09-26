{{ config(
      materialized='incremental',
      unique_key = ['settle_date_y','settle_date_m', 'dealer_code', 'twc_no', 'frmkbn', 'frmno', 'wmi', 'vds', 'vis'],
      incremental_strategy = 'merge'
   ) }}

with stg_warranty_goguchihinban as (
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
        part_no_u5::varchar(5) as part_no_u5, --なし
        part_no_l5::varchar(5) as part_no_l5, --なし
        part_no_u5 || part_no_l5 as part_no,--結合
        reg_cls::varchar(1) as reg_cls, --なし
        design_cmpny_code::varchar(7) as design_cmpny_code, --なし
        design_div_code::varchar(5) as design_div_code_lo_parts, --なし
        drawing_cls::varchar(1) as drawing_cls, --なし
        parts_manufact_proc1::varchar(6) as parts_manufact_proc1, --なし
        parts_manufact_proc2::varchar(6) as parts_manufact_proc2, --なし
        parts_manufact_proc3::varchar(6) as parts_manufact_proc3, --なし
        parts_manufact_proc4::varchar(6) as parts_manufact_proc4, --なし
        parts_manufact_proc5::varchar(6) as parts_manufact_proc5, --なし
        parts_manufact_proc6::varchar(6) as parts_manufact_proc6, --なし
        parts_manufact_proc7::varchar(6) as parts_manufact_proc7, --なし
        parts_manufact_proc8::varchar(6) as parts_manufact_proc8, --なし
        parts_manufact_proc9::varchar(6) as parts_manufact_proc9, --なし
        parts_manufact_proc10::varchar(6) as parts_manufact_proc10, --なし
        parts_manufact_proc11::varchar(6) as parts_manufact_proc11, --なし
        parts_manufact_proc12::varchar(6) as parts_manufact_proc12, --なし
        parts_manufact_proc13::varchar(6) as parts_manufact_proc13, --なし
        parts_manufact_proc14::varchar(6) as parts_manufact_proc14, --なし
        parent_parts_proc::varchar(6) as parent_parts_proc, --なし
        resp_judge_cls::varchar(1) as resp_judge_cls, --なし
        munufact_div_cmpny_code::varchar(7) as munufact_div_cmpny_code, --なし
        manufact_div_code::varchar(5) as manufact_div_code_lo_parts, --なし
        manufact_div_judge::varchar(6) as manufact_div_judge, --なし
        parent_part_no_u5::varchar(5) as parent_part_no_u5, --なし
        parent_part_no_l5::varchar(5) as parent_part_no_l5, --なし
        main_resp_cmpny_code::varchar(7) as main_resp_cmpny_code, --なし
        main_resp_div_code::varchar(5) as main_resp_div_code, --なし
        other_part_no_exist_flg::varchar(1) as other_part_no_exist_flg, --なし
        last_save_date::varchar(8) as last_save_date, --なし
        mtuser::varchar(18) as mtuser, --なし
        mttime::timestamp_ntz as mttime, --timestamp型
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_oraclerds_orcl_iqas_osepcs0000db20', 'raw_cep0011lohbn') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_warranty_goguchihinban