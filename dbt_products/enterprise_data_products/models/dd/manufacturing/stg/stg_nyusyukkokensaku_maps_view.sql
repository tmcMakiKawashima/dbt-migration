{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_nyusyukkokensaku') %}

with stg_nyusyukkokensaku_maps_view as (
  select
    y_item_no::varchar(10) as y_item_no, -- Y品番
    wh_code::varchar(2) as wh_code, -- 倉庫ｺｰﾄﾞ
    new_used_cls::varchar(1) as new_used_cls, -- 新品･中古区分
    sar_morphology::varchar(2) as sar_morphology, -- 入出庫形態
    transfer_to_wh::varchar(2) as transfer_to_wh, -- 振替相手倉庫
    gi_gi_post_no::varchar(3) as gi_gi_post_no, -- ﾎﾟｽﾄNo(出庫先)
    depart_code_gi::varchar(5) as depart_code_gi, -- 部署ｺｰﾄﾞ(出庫先)
    burden_post_no::varchar(3) as burden_post_no, -- ﾎﾟｽﾄNo(負担)
    depart_code_burden::varchar(5) as depart_code_burden, -- 部署ｺｰﾄﾞ(負担)
    gi_order::varchar(15) as gi_order, -- 出庫ｵｰﾀﾞｰ
    subject::varchar(1) as subject, -- 科目
    warehousing_quantity::varchar(11) as warehousing_quantity, -- 入庫数量
    gi_quantity::varchar(11) as gi_quantity, -- 出庫数量
    machine_number::varchar(8) as machine_number, -- 機番
    arrangement_serial_no::varchar(6) as arrangement_serial_no, -- 手配連番
    sha2('emp_code', 256) as emp_code, -- 従業員ｺｰﾄﾞ
    gi_person_name::varchar(10) as gi_person_name, -- 出庫者名
    sar_date::varchar(8) as sar_date, -- 入出庫年月日
    new_date::varchar(8) as new_date, -- 新設年月日
    update_date::varchar(8) as update_date, -- 更新年月日
    factory_cls::varchar(1) as factory_cls, -- 工場区分
    st_no::varchar(2) as st_no, -- ｽﾃｰｼｮﾝNo
    depart_code::varchar(5) as depart_code, -- 部署ｺｰﾄﾞ
    "ldts" -- B層取込日時
  from {{ source_table.database }}.{{ source_table.schema }}."{{ source_table.name | lower }}"
)

select * from stg_nyusyukkokensaku_maps_view