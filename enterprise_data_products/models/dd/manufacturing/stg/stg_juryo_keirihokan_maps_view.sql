{{ config(
      materialized='view'
   )
}}

with stg_juryo_keirihokan_maps_view as (
  select
    data_cls::varchar(1) as data_cls, -- ﾃﾞｰﾀ区分
    form_no::varchar(4) as form_no, -- 帳票No
    arrangement_serial_no::varchar(6) as arrangement_serial_no, -- 手配連番
    y_item_no::varchar(10) as y_item_no, -- Y品番
    supplier_code::varchar(4) as supplier_code, -- 仕入先ｺｰﾄﾞ
    maker_code::varchar(4) as maker_code, -- ﾒｰｶｰｺｰﾄﾞ
    wh_code::varchar(2) as wh_code, -- 倉庫ｺｰﾄﾞ
    delivery_number::varchar(5) as delivery_number, -- 納入番号
    actual_delivery_date::varchar(8) as actual_delivery_date, -- 納入年月日
    delivery_quantity::varchar(9) as delivery_quantity, -- 納入数量
    gi_depart_code::varchar(5) as gi_depart_code, -- 出庫部署コード
    burden_depart_code::varchar(5) as burden_depart_code, -- 負担部署コード
    gi_order::varchar(15) as gi_order, -- 出庫ｵｰﾀﾞｰ
    scheme_supply_cls::varchar(1) as scheme_supply_cls, -- 支給区分
    new_used_cls::varchar(1) as new_used_cls, -- 新品･中古区分
    procurement_cls::varchar(1) as procurement_cls, -- 調達区分
    accepted_wh_code::varchar(2) as accepted_wh_code, -- 検収倉庫
    accepted_truck::varchar(1) as accepted_truck, -- 検収日便
    supply_dest_code::varchar(4) as supply_dest_code, -- 支給先ｺｰﾄﾞ
    rep_order::varchar(15) as rep_order, -- 修理ｵｰﾀﾞｰ
    subject::varchar(1) as subject, -- 科目
    accepted_user_name::varchar(10) as accepted_user_name, -- 検収(氏名(全桁))
    accepted_dept_code::varchar(5) as accepted_dept_code, -- 検収(部署ｺｰﾄﾞ)
    sha2('accepted_emp_code', 256) as accepted_emp_code, -- 検収(従業員ｺｰﾄﾞ)
    accepted_update_dttm::varchar(14) as accepted_update_dttm, -- 検収(更新日時)
    current_operation_date::varchar(8) as current_operation_date, -- 処理年月日
    ldts -- B層取込日時
  from {{source('manufacturing_db_public', 'raw_stg_juryo_keirihokan')}}
)
select * from stg_juryo_keirihokan_maps_view