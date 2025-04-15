{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_hachu_keirihokan') %}

with stg_hachu_keirihokan_maps_view as (
  select
    data_cls::varchar(1) as data_cls, -- ﾃﾞｰﾀ区分
    requester_name::varchar(4) as requester_name, -- 依頼者名
    req_depart_code::varchar(5) as req_depart_code, -- 依頼部署ｺｰﾄﾞ
    req_depart_tel::varchar(13) as req_depart_tel, -- 依頼部署TEL
    req_depart_name::varchar(8) as req_depart_name, -- 依頼部署名
    kanban_sheet_qty::varchar(3) as kanban_sheet_qty, -- かんばん枚数
    kanban_destination_no::varchar(3) as kanban_destination_no, -- かんばん行先No
    kanban_destination_name::varchar(16) as kanban_destination_name, -- かんばん行先名称
    weight_necessity_cls::varchar(1) as weight_necessity_cls, -- 計量要否区分
    factory_code::varchar(1) as factory_code, -- 工場区分
    factory_name::varchar(3) as factory_name, -- 工場名
    sheet_quantity::varchar(9) as sheet_quantity, -- ｼｰﾄ数本数
    sheet_quantity_unit::varchar(4) as sheet_quantity_unit, -- ｼｰﾄ数本数単位
    supplier_code::varchar(4) as supplier_code, -- 仕入先ｺｰﾄﾞ
    supplier_name::varchar(8) as supplier_name, -- 仕入先名称
    minimum_odr_quantity::varchar(5) as minimum_odr_quantity, -- 収容数
    spec_tool_no::varchar(59) as spec_tool_no, -- ｽﾍﾟｯｸ
    wh_code_gi::varchar(2) as wh_code_gi, -- 倉庫ｺｰﾄﾞ(出庫)
    procurement_cls::varchar(1) as procurement_cls, -- 調達区分
    arrengement_serial_no::varchar(6) as arrengement_serial_no, -- 手配連番
    toyota_remarks::varchar(20) as toyota_remarks, -- ﾄﾖﾀ備考
    description::varchar(4) as description, -- 荷姿
    delivery_date::varchar(8) as delivery_date, -- 納期
    delivery_date_truck::varchar(2) as delivery_date_truck, -- 納期便
    delivery_no::varchar(5) as delivery_no, -- 納入番号
    order_quantity_summary::varchar(9) as order_quantity_summary, -- 発注数(ｻﾏﾘ)
    unit_of_measure_tl::varchar(4) as unit_of_measure_tl, -- 発注数量単位
    order_date::varchar(8) as order_date, -- 発注日
    order_date_truck::varchar(2) as order_date_truck, -- 発注日便
    item_name::varchar(15) as item_name, -- 品名
    order_qty_per_sheet::varchar(9) as order_qty_per_sheet, -- 発注数量_枚
    maker_code::varchar(4) as maker_code, -- ﾒｰｶｰｺｰﾄﾞ
    maker_name::varchar(8) as maker_name, -- ﾒｰｶｰ名称
    y_item_no::varchar(10) as y_item_no, -- Y品番
    odr_can_date::varchar(8) as odr_can_date, -- 発注ｷｬﾝｾﾙ日
    chg_delivery_date::varchar(8) as chg_delivery_date, -- 変更納期
    chg_delivery_date_truck::varchar(2) as chg_delivery_date_truck, -- 変後便
    chg_delivery_date_times::varchar(1) as chg_delivery_date_times, -- 納期変更回数
    rep_order::varchar(15) as rep_order, -- 修理ｵｰﾀﾞｰ
    new_repair_order_cls::varchar(1) as new_repair_order_cls, -- 新品修理発注区分
    depart_code_gi::varchar(5) as depart_code_gi, -- 部署ｺｰﾄﾞ(出庫先)
    depart_code_burden::varchar(5) as depart_code_burden, -- 部署ｺｰﾄﾞ(負担)
    supply_dest_code::varchar(4) as supply_dest_code, -- 支給先ｺｰﾄﾞ
    gi_order::varchar(15) as gi_order, -- 出庫ｵｰﾀﾞｰ
    subject::varchar(1) as subject, -- 科目
    provisional_amount_notuse::varchar(8) as provisional_amount_notuse, -- 仮金額(未使用)
    provisional_amount_reason_notuse::varchar(11) as provisional_amount_reason_notuse, -- 仮金額理由内容(未使用)
    rep_burden_depart::varchar(5) as rep_burden_depart, -- 修理負担部署
    delivery_delay_count::varchar(2) as delivery_delay_count, -- 納期遅れ回数
    toyota_remarks_30::varchar(30) as toyota_remarks_30, -- ﾄﾖﾀ備考(30桁)
    kanban_odr_name::varchar(10) as kanban_odr_name, -- かんばん発注者(氏名(全桁))
    kanban_odr_dept_code::varchar(5) as kanban_odr_dept_code, -- かんばん発注者(部署ｺｰﾄﾞ)
    sha2('kanban_odr_emp_code', 256) as kanban_odr_emp_code, -- かんばん発注者(従業員ｺｰﾄﾞ)
    kanban_odr_update::varchar(14) as kanban_odr_update, -- かんばん発注者(更新日時)
    delivery_chg_name::varchar(10) as delivery_chg_name, -- 納期変更(氏名(全桁))
    delivery_chg_dept_code::varchar(5) as delivery_chg_dept_code, -- 納期変更(部署ｺｰﾄﾞ)
    sha2('delivery_chg_update_id', 256) as delivery_chg_update_id, -- 納期変更(更新者ID)
    delivery_chg_update::varchar(14) as delivery_chg_update, -- 納期変更(更新日時)
    odr_can_name::varchar(10) as odr_can_name, -- 発注ｷｬﾝｾﾙ(氏名(全桁))
    odr_can_dept_code::varchar(5) as odr_can_dept_code, -- 発注ｷｬﾝｾﾙ(部署ｺｰﾄﾞ)
    sha2('odr_can_update_id', 256) as odr_can_update_id, -- 発注ｷｬﾝｾﾙ(更新者ID)
    odr_can_reason::varchar(60) as odr_can_reason, -- 発注ｷｬﾝｾﾙ理由
    provisional_amount::varchar(12) as provisional_amount, -- 仮金額
    provisional_amount_reason::varchar(100) as provisional_amount_reason, -- 仮金額理由
    provisional_unit_price::varchar(10) as provisional_unit_price, -- 仮単価
    prov_unit_price_due_date::varchar(8) as prov_unit_price_due_date, -- 仮単価決定期限
    regular_unit_price::varchar(10) as regular_unit_price, -- 正規単価
    regular_amount::varchar(12) as regular_amount, -- 正規金額
    processing_date::varchar(8) as processing_date, -- 処理年月日
    return_quantity::varchar(9) as return_quantity, -- 返却数量
    "ldts" -- B層取込日時
  from {{ source_table.database }}.{{ source_table.schema }}."{{ source_table.name | lower }}"
)

select * from stg_hachu_keirihokan_maps_view