{{ config(
      materialized='incremental',
      unique_key = ['index_cls','syadai_kt', 'frmno','wmi','vds','vis'],
      incremental_strategy = 'merge'
   ) }}

with stg_syaryoindex as (
    select
        index_cls::varchar(3) as index_cls, --なし
        frame_cls::varchar(6) as syadai_kt, --なし
        frame_no::varchar(7) as frmno, --なし
        vin_wmi::varchar(3) as wmi, --なし
        vin_vds::varchar(6) as vds, --なし
        vin_vis::varchar(8) as vis, --なし
        vin_my::varchar(1) as my, --なし
        vin_cd::varchar(1) as cd, --なし
        wmi || vds || vis as vin, --結合
        syadai_kt || '-' || frmno as frame_cls_no, --結合
        wmi || vds || vis || syadai_kt || '-' || frmno as vin_frame_cls_no, --結合
        lo_date_y::varchar(4) as lo_date_y, --なし
        lo_date_m::varchar(2) as lo_date_m, --なし
        lo_date_d::varchar(2) as lo_date_d, --なし
        try_to_date(lo_date_y || lo_date_m || lo_date_d, 'yyyymmdd' ) as lo_date_ymd, -- date型
        lo_reg_month::number(3) as lo_reg_month, --なし
        model_major_cls_code::varchar(2) as model_major_cls_code, --なし
        sms_veh_code::varchar(4) as sms_syasyu_cd, --なし
        model_veh_code::varchar(4) as model_syasyu_cd, --なし
        ident_no::varchar(10) as idtno, --なし
        rtrim(katashiki, ' 　')::varchar(15) as haisya_kt, -- 右ブランク
        rtrim(sales_katashiki, ' 　')::varchar(20) as  hanbai_kt, -- 右ブランク
        body_type::varchar(1) as body_type, --なし
        eng_no::varchar(7) as eng_no, --なし
        eng_type::varchar(20) as eng_type, --なし
        tm_type::varchar(6) as tm_type, --なし
        rdf_type::varchar(3) as rdf_type, --なし
        spec_bit::varchar(6) as spec_bit, --なし
        drive_system::varchar(5) as drive_system, --なし
        airbag_ecu_part_no::varchar(5) as airbag_ecu_part_no, --なし
        eng_plnt_code::varchar(2) as eng_plnt_code, --なし
        tire_maker::varchar(2) as tire_maker, --なし
        production_area_cls::varchar(1) as production_area_cls, --なし
        production_country_code::varchar(3) as production_country_code, --なし
        onec_line_code::varchar(2) as ichiken_line_code, --なし
        onec_date_y::varchar(4) as ichikenyy, --なし
        onec_date_m::varchar(2) as ichikenmm, --なし
        onec_date_d::varchar(2) as ichikendd, --なし
        try_to_date(ichikenyy || ichikenmm || ichikendd, 'yyyymmdd' ) as ichikenymd, -- date型
        endc_line_code::varchar(2) as syuken_line_code, --なし
        endc_date_y::varchar(4) as syukenyy, --なし
        endc_date_m::varchar(2) as syukenmm, --なし
        endc_date_d::varchar(2) as syukendd, --なし
        try_to_date(syukenyy || syukenmm || syukendd, 'yyyymmdd' ) as syukenymd, -- date型
        endc_time::varchar(4) as syuken_time, --なし
        pack_line_code::varchar(2) as konpo_line_code, --なし
        pack_date_y::varchar(4) as konpoyy, --なし
        pack_date_m::varchar(2) as konpomm, --なし
        pack_date_d::varchar(2) as konpodd, --なし
        try_to_date(konpoyy ||  konpomm || konpodd, 'yyyymmdd' ) as konpoymd, -- date型
        ident_line_code::varchar(2) as ident_line_code, --なし
        pack_form::varchar(1) as pack_form, --なし
        export_cls::varchar(1) as export_cls, --なし
        use_cls::varchar(1) as use_cls, --なし
        region_cls::varchar(1) as region_cls, --なし
        dest_code::varchar(3) as dest_code, --なし
        deliv_deal_code::varchar(5) as deliv_deal_code, --なし
        deliv_date_y::varchar(4) as haisyayy, --なし
        deliv_date_m::varchar(2) as haisyamm, --なし
        deliv_date_d::varchar(2) as haisyadd, --なし
        try_to_date(haisyayy ||  haisyamm || haisyadd, 'yyyymmdd' ) as haisyaymd, -- date型
        reg_state_code::varchar(3) as reg_state_code, --なし
        reg_country_code::varchar(5) as reg_country_code, --なし
        reg_deal_code::varchar(8) as reg_deal_code, --なし
        veh_reg_date_y::varchar(4) as torokuyy, --なし
        veh_reg_date_m::varchar(2) as torokumm, --なし
        veh_reg_date_d::varchar(2) as torokudd, --なし
        try_to_date(torokuyy ||  torokumm || torokudd, 'yyyymmdd' ) as torokuyymmdd, -- date型
        dest_detail::varchar(1) as dest_detail, --なし
        b_veh_cls::varchar(1) as b_veh_cls, --なし
        b_veh_date::varchar(8) as b_veh_date, --なし
        prod_data_id::varchar(1) as prod_data_id, --なし
        frame_recog_cls::varchar(1) as frame_recog_cls, --なし
        veh_name_code::varchar(2) as veh_name_code, --なし
        ext_color_code::varchar(4) as ext_color_code, --なし
        int_code::varchar(4) as int_code, --なし
        brand_cls::varchar(1) as brand_cls, --なし
        tm_plnt_code::varchar(2) as tm_plnt_code, --なし
        reg_date_y_airis::varchar(4) as reg_date_y_airis, --なし
        reg_date_m_airis::varchar(2) as reg_date_m_airis, --なし
        reg_date_d_airis::varchar(2) as reg_date_d_airis, --なし
        reg_date_y_tcom::varchar(4) as reg_date_y_tcom, --なし
        reg_date_m_tcom::varchar(2) as reg_date_m_tcom, --なし
        reg_date_d_tcom::varchar(2) as reg_date_d_tcom, --なし
        use_cls_airis::varchar(1) as use_cls_airis, --なし
        cmpnycode::varchar(3) as cmpnycode, --なし
        region_cls_new::varchar(1) as region_cls_new, --なし
        lo_date::varchar(8) as lo_date, --なし
        lo_date_time::varchar(4) as lo_date_time, --なし
        veh_plnt_code::varchar(3) as veh_plnt_code, --なし
        use_country_code::varchar(3) as use_country_code, --なし
        rism_del_cls::varchar(1) as rism_del_cls, --なし
        assm_seq::varchar(3) as assm_seq, --なし
        mtuser::varchar(18) as mtuser, --なし
        mttime::timestamp_ntz as mttime, --timestamp型
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_supplydemand', 'raw_cep1001index') }}
    where _fivetran_deleted = 'false'

    {% if is_incremental() %}
        and _fivetran_synced > (select max(ldts) from {{ this }})
    {% endif %}

)
select * from stg_syaryoindex