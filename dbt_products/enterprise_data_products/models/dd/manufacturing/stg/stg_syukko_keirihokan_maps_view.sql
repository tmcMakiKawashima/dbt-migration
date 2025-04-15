{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_syukko_keirihokan') %}

with stg_syukko_keirihokan_maps_view as (
  select
    form_no::varchar(4) as form_no, -- 帳票No
    y_item_no::varchar(10) as y_item_no, -- 品番
    wh_code::varchar(2) as wh_code, -- 倉庫
    supply_dest_code::varchar(5) as supply_dest_code, -- 出庫先
    burden_depart_code::varchar(5) as burden_depart_code, -- 負担部署
    quantity::varchar(11) as quantity, -- 数量
    gi_order::varchar(15) as gi_order, -- 出庫ｵｰﾀﾞｰ
    gi_date::varchar(8) as gi_date, -- 出庫年月日
    new_used_cls::varchar(1) as new_used_cls, -- 新品中古区分
    loan_cls::varchar(1) as loan_cls, -- 賃借区分
    transfer_discarded_cls::varchar(1) as transfer_discarded_cls, -- 振替廃却区分
    delivery_number::varchar(5) as delivery_number, -- 納入番号
    batch_no::varchar(6) as batch_no, -- ﾊﾞｯﾁNo
    data_cls::varchar(2) as data_cls, -- ﾃﾞｰﾀ区分
    switch_entry_cls::varchar(1) as switch_entry_cls, -- 切替号口区分
    subject::varchar(1) as subject, -- 科目
    machine_number::varchar(8) as machine_number, -- 機番
    st_no::varchar(2) as st_no, -- ST-No
    spec::varchar(59) as spec, -- ｽﾍﾟｯｸ
    arrangement_serial_no::varchar(6) as arrangement_serial_no, -- 手配連番
    transfer_source::varchar(2) as transfer_source, -- 振替元
    supply_cls::varchar(1) as supply_cls, -- 支給区分
    gi_form_code::varchar(1) as gi_form_code, -- 出庫形態ｺｰﾄﾞ
    screen_form_no::varchar(4) as screen_form_no, -- 画面帳票No
    shirt_number::varchar(5) as shirt_number, -- 背番号
    processing_date1::varchar(8) as processing_date1, -- 処理年月日1
    post_no_goods_issue::varchar(3) as post_no_goods_issue, -- ﾎﾟｽﾄNo(出庫)
    post_no_burden::varchar(3) as post_no_burden, -- ﾎﾟｽﾄNo(負担)
    sha2('emp_code', 256) as emp_code, -- 従業員ｺｰﾄﾞ
    gi_person_name::varchar(10) as gi_person_name, -- 出庫者名
    new_date::varchar(8) as new_date, -- 新設年月日
    processing_time::varchar(6) as processing_time, -- 処理時間
    spot_post_no::varchar(3) as spot_post_no, -- 現場ﾎﾟｽﾄNo
    depart_code_direct_delivery::varchar(5) as depart_code_direct_delivery, -- 部署ｺｰﾄﾞ(直納)
    gi_person_name_all_digits::varchar(10) as gi_person_name_all_digits, -- 出庫者名(全桁)
    depart_code::varchar(5) as depart_code, -- 部署ｺｰﾄﾞ
    processing_date2::varchar(8) as processing_date2, -- 処理年月日2
    "ldts" -- B層取込日時
  from {{ source_table.database }}.{{ source_table.schema }}."{{ source_table.name | lower }}"
)

select * from stg_syukko_keirihokan_maps_view