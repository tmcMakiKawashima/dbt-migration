{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_tokorobanchi_tetsu') %}

with stg_tokorobanchi_tetsu_maps_view as (
  select
    location_code_iron_id::varchar(15) as location_code_iron_id, -- 所番地(鉄)ID
    year_month::varchar(6) as year_month, -- 年月
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(1) as factory_cls, -- 組織コード（工場区分）
    inventory_item_id_y::varchar(15) as inventory_item_id_y, -- 品目ID（Y品番)
    y_item_no::varchar(10) as y_item_no, -- Y品番
    subinventory_code::varchar(2) as subinventory_code, -- 保管場所コード
    control_key::varchar(1) as control_key, -- コントロールキー
    arrangement_serial_no::varchar(6) as arrangement_serial_no, -- 手配連番
    location_code::varchar(10) as location_code, -- 所番地
    discharge_place::varchar(6) as discharge_place, -- 荷卸場
    order_point_iron::varchar(9) as order_point_iron, -- 発注点(鉄)
    kanban_sheet_qty::varchar(3) as kanban_sheet_qty, -- かんばん枚数
    minimum_necessary_wt::varchar(6) as minimum_necessary_wt, -- 最低必要重量
    minimum_lot_cycle_number::varchar(5) as minimum_lot_cycle_number, -- 最小ロットサイクル直数
    order_point_cm::varchar(2) as order_point_cm, -- 発注点(cm)
    read_odr_cls::varchar(1) as read_odr_cls, -- 読取発注区分
    non_sleeping_cls::varchar(1) as non_sleeping_cls, -- 非ねかせ区分
    delivery_truck_a::varchar(1) as delivery_truck_a, -- 納入便A
    delivery_truck_b::varchar(1) as delivery_truck_b, -- 納入便B
    delivery_truck_c::varchar(1) as delivery_truck_c, -- 納入便C
    delivery_truck_d::varchar(1) as delivery_truck_d, -- 納入便D
    order_suspension_reason::varchar(30) as order_suspension_reason, -- 発注停止理由内容
    order_suspension_date_to::varchar(14) as order_suspension_date_to, -- 発注停止年月日（マデ）
    order_suspension_truck_to::varchar(1) as order_suspension_truck_to, -- 発注停止便（マデ）
    note_1::varchar(60) as note_1, -- 備考1
    note_2::varchar(30) as note_2, -- 備考2
    std_tbl_chg_contents::varchar(180) as std_tbl_chg_contents, -- 基準表変更内容
    new_date::varchar(14) as new_date, -- 新設年月日
    update_date::varchar(14) as update_date, -- 更新年月日
    location_code_new::varchar(10) as location_code_new, -- 所番地（変更後）
    object_version_number::varchar(9) as object_version_number, -- Object Version Number
    sha2('created_by', 256) as created_by, -- 作成者
    created_user_name::varchar(30) as created_user_name, -- 作成者ユーザー名
    creation_date::varchar(14) as creation_date, -- 作成日時
    sha2('last_updated_by', 256) as last_updated_by, -- 最終更新者
    last_updated_user_name::varchar(30) as last_updated_user_name, -- 最終更新者ユーザー名
    last_update_date::varchar(14) as last_update_date, -- 最終更新日時
    sha2('last_update_login', 256) as last_update_login, -- 最終更新ログイン
    last_upd_login_user_name::varchar(30) as last_upd_login_user_name, -- 最終更新ログインユーザー名
    request_id::varchar(15) as request_id, -- 要求ID
    program_application_id::varchar(15) as program_application_id, -- コンカレント・プログラム・アプリケーションID
    program_id::varchar(15) as program_id, -- コンカレント・プログラムID
    program_update_date::varchar(14) as program_update_date, -- プログラム更新日時
    "ldts" -- B層取込日時
  from {{ source_table.database }}.{{ source_table.schema }}."{{ source_table.name | lower }}"
)

select * from stg_tokorobanchi_tetsu_maps_view