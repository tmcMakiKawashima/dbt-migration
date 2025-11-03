{{
    config (
        materialized = 'incremental',
        incremental_strategy = 'merge',
        unique_key = ['lo_year_month', 'lo_year_month_date', 'model_major_cls_code', 'model_veh_code', 'sms_veh_code', 'katashiki_20', 'eng_type', 'tm_type', 'dest_code', 'reg_state_code', 'region_cls', 'export_cls', 'endc_line_code', 'eng_plnt_code', 'production_area_cls', 'vin_my', 'pack_line_code', 'pack_form', 'brand_cls', 'veh_plnt_code', 'production_country_code', 'lo_date', 'frame_cls', 'reg_country_code', 'cmpnycode', 'region_cls_new']
    )
}}

with stg_bosu_sum_ym_iqas as (
    select
        lo_year_month::varchar(6) as lo_year_month,
        try_to_date(lo_year_month || '01', 'yyyymmdd')::date as lo_year_month_date,
        model_major_cls_code::varchar(2) as model_major_cls_code,
        model_veh_code::varchar(4) as model_veh_code,
        sms_veh_code::varchar(4) as sms_veh_code,
        katashiki_20::varchar(20) as katashiki_20,
        eng_type::varchar(20) as eng_type,
        tm_type::varchar(6) as tm_type,
        dest_code::varchar(3) as dest_code,
        reg_state_code::varchar(3) as reg_state_code,
        region_cls::varchar(1) as region_cls,
        export_cls::varchar(1) as export_cls,
        endc_line_code::varchar(2) as endc_line_code,
        eng_plnt_code::varchar(2) as eng_plnt_code,
        production_area_cls::varchar(1) as production_area_cls,
        vin_my::varchar(1) as vin_my,
        pack_line_code::varchar(2) as pack_line_code,
        pack_form::varchar(1) as pack_form,
        brand_cls::varchar(1) as brand_cls,
        veh_plnt_code::varchar(3) as veh_plnt_code,
        production_country_code::varchar(3) as production_country_code,
        lo_date::varchar(8) as lo_date,
        frame_cls::varchar(6) as frame_cls,
        reg_country_code::varchar(5) as reg_country_code,
        cmpnycode::varchar(3) as cmpnycode,
        region_cls_new::varchar(1) as region_cls_new,
        veh_lo_num_total::number(9, 0) as veh_lo_num_total,
        veh_reg_num01::number(8, 0) as veh_reg_num01,
        veh_reg_num02::number(8, 0) as veh_reg_num02,
        veh_reg_num03::number(8, 0) as veh_reg_num03,
        veh_reg_num04::number(8, 0) as veh_reg_num04,
        veh_reg_num05::number(8, 0) as veh_reg_num05,
        veh_reg_num06::number(8, 0) as veh_reg_num06,
        veh_reg_num07::number(8, 0) as veh_reg_num07,
        veh_reg_num08::number(8, 0) as veh_reg_num08,
        veh_reg_num09::number(8, 0) as veh_reg_num09,
        veh_reg_num10::number(8, 0) as veh_reg_num10,
        veh_reg_num11::number(8, 0) as veh_reg_num11,
        veh_reg_num12::number(8, 0) as veh_reg_num12,
        update_cls::varchar(1) as update_cls,
        _fivetran_synced::timestamp_ntz as ldts --timestamp型
    from {{ source('fivetran_database_oraclerds_orcl_iqas_osepcs0000db20', 'raw_cep0702bosu_sum_ym') }}
    where _fivetran_deleted = 'false'
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select *
from stg_bosu_sum_ym_iqas