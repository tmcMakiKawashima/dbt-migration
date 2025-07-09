{{ config(
      materialized='view'
   )
}}

with stg_tokorobanchi_tetsuigai_maps_view as (
  select
    location_code_not_iron_id::varchar(15) as location_code_not_iron_id, -- 所番地(鉄以外)ID
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(1) as factory_cls, -- 組織コード（工場区分）
    inventory_item_id_y::varchar(15) as inventory_item_id_y, -- 品目ID（Y品番)
    y_item_no::varchar(10) as y_item_no, -- Y品番
    subinventory_code::varchar(2) as subinventory_code, -- 保管場所コード
    control_key::varchar(1) as control_key, -- コントロールキー
    spot_post_no::varchar(3) as spot_post_no, -- 現場ポストNo
    tank_no::varchar(3) as tank_no, -- タンクNo
    storage_shelf_cls::varchar(1) as storage_shelf_cls, -- 保管棚区分
    supplier_id::varchar(15) as supplier_id, -- 仕入先ID
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    supplier_abbreviation::varchar(8) as supplier_abbreviation, -- 仕入先名
    location_code::varchar(10) as location_code, -- 所番地
    discharge_place::varchar(6) as discharge_place, -- 荷卸場
    order_point::varchar(11) as order_point, -- 発注点
    surplus_exisit_cls::varchar(1) as surplus_exisit_cls, -- 余剰有無区分
    kanban_total_sheet_qty::varchar(3) as kanban_total_sheet_qty, -- かんばん総枚数
    order_qty_per_sheet::varchar(11) as order_qty_per_sheet, -- 発注数量/枚
    exchange_quantity_amount::varchar(5) as exchange_quantity_amount, -- 交換数量/回
    registry_cls::varchar(1) as registry_cls, -- 登録区分
    specification::varchar(30) as specification, -- 仕様
    sheet_quantity::varchar(5) as sheet_quantity, -- シート数・本数
    read_odr_cls::varchar(1) as read_odr_cls, -- 読取発注区分
    fixed_gi_quantity::varchar(11) as fixed_gi_quantity, -- 固定出庫数
    receive_notice::varchar(1) as receive_notice, -- 受入通知
    spare_parts_donor_exisit_cls::varchar(1) as spare_parts_donor_exisit_cls, -- 部品取有無区分
    entry_cls::varchar(1) as entry_cls, -- 号口区分
    location_label_issue::varchar(1) as location_label_issue, -- 所番地ラベル発行
    public_holiday_error_target::varchar(1) as public_holiday_error_target, -- 祝日エラー対象
    storage_retrieval_mmt_flag::varchar(1) as storage_retrieval_mmt_flag, -- 入出庫管理対象フラグ
    wh_pulling_propriety_cls::varchar(1) as wh_pulling_propriety_cls, -- 倉庫引上可否区分
    wh_not_pulling_date::varchar(14) as wh_not_pulling_date, -- 倉庫引上不可年月日
    kanban_order_decision::varchar(1) as kanban_order_decision, -- かんばん発注決裁
    arrangement_serial_no::varchar(6) as arrangement_serial_no, -- 手配連番
    new_date::varchar(14) as new_date, -- 新設年月日
    update_date::varchar(14) as update_date, -- 更新年月日
    subinventory_code_gi::varchar(2) as subinventory_code_gi, -- 保管場所コード(出庫元)
    rqe_date::varchar(14) as rqe_date, -- 依頼年月日
    new_gi_years::varchar(6) as new_gi_years, -- 最新出庫年月
    object_version_number::varchar(9) as object_version_number, -- Object Version Number
    creation_date::varchar(14) as creation_date, -- 作成日時
    last_update_date::varchar(14) as last_update_date, -- 最終更新日時
    request_id::varchar(15) as request_id, -- 要求ID
    program_application_id::varchar(15) as program_application_id, -- コンカレント・プログラム・アプリケーションID
    program_id::varchar(15) as program_id, -- コンカレント・プログラムID
    program_update_date::varchar(14) as program_update_date, -- プログラム更新日時
    ldts -- B層取込日時
  from {{source('manufacturing_db_public', 'raw_stg_tokorobanchi_tetsuigai')}}
)
select * from stg_tokorobanchi_tetsuigai_maps_view