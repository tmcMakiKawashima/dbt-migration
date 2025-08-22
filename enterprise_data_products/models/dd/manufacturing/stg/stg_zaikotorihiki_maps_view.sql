{{ config(
      materialized='view'
   )
}}

with stg_zaikotorihiki_maps_view as (
  select
    stock_trade_id::varchar(15) as stock_trade_id, -- 在庫取引ID
    form_no::varchar(4) as form_no, -- 帳票No
    card_identification_cls::varchar(1) as card_identification_cls, -- カード識別区分
    arrangement_serial_no::varchar(6) as arrangement_serial_no, -- 手配連番
    arrangement_branch_no::varchar(6) as arrangement_branch_no, -- 手配連番枝番
    wh_code_gi::varchar(2) as wh_code_gi, -- 倉庫コード(出庫元)
    delivery_quantity::varchar(12) as delivery_quantity, -- 納入数量
    weigh_necessity_cls::varchar(1) as weigh_necessity_cls, -- 計量要否区分
    new_supplier_id::varchar(15) as new_supplier_id, -- 新品仕入先ID
    new_supplier_code::varchar(4) as new_supplier_code, -- 新品仕入先コード
    new_supplier_abbreviation::varchar(8) as new_supplier_abbreviation, -- 新品仕入先名
    maker_id::varchar(15) as maker_id, -- メーカーID
    preferred_maker_code::varchar(4) as preferred_maker_code, -- メーカーコード
    preferred_maker_name::varchar(8) as preferred_maker_name, -- メーカー名
    standard_weight::varchar(5) as standard_weight, -- 基準重量
    minimum_necessary_wt::varchar(5) as minimum_necessary_wt, -- 最低必要重量
    gi_post_no::varchar(3) as gi_post_no, -- 出庫ポストNo
    burden_post_no::varchar(3) as burden_post_no, -- 負担ポストNo
    gi_order::varchar(15) as gi_order, -- 出庫オーダー
    subject::varchar(1) as subject, -- 科目
    read_odr_cls::varchar(1) as read_odr_cls, -- 読取発注区分
    repair_supplier_id::varchar(15) as repair_supplier_id, -- 修理仕入先ID
    repair_supplier_code::varchar(4) as repair_supplier_code, -- 修理仕入先コード
    repair_supplier_name::varchar(8) as repair_supplier_name, -- 修理仕入先名
    gi_depart_code::varchar(5) as gi_depart_code, -- 出庫部署コード
    burden_depart_code::varchar(5) as burden_depart_code, -- 負担部署コード
    procurement_cls::varchar(1) as procurement_cls, -- 調達区分
    z_item_cls::varchar(1) as z_item_cls, -- Z品区分
    in_house_make_item_cls::varchar(1) as in_house_make_item_cls, -- 内製製作品区分
    in_house_repair_item_cls::varchar(1) as in_house_repair_item_cls, -- 内製修理品区分
    wh_code_intensive_stock::varchar(2) as wh_code_intensive_stock, -- 集中在庫倉庫コード
    order_quantity_summary::varchar(11) as order_quantity_summary, -- 発注数(サマリ)
    kanban_sheet_qty_summary::varchar(3) as kanban_sheet_qty_summary, -- かんばん枚数(サマリ)
    wh_code_rqe::varchar(2) as wh_code_rqe, -- 倉庫コード(依頼)
    entry_test_mtl_cls::varchar(1) as entry_test_mtl_cls, -- 号口テスト材区分
    new_repair_order_cls::varchar(1) as new_repair_order_cls, -- 新品修理発注区分
    location_code_serial_number::varchar(4) as location_code_serial_number, -- 所番地連番
    kanban_destination_no::varchar(3) as kanban_destination_no, -- かんばん行先No
    coil_width::varchar(9) as coil_width, -- コイル幅
    order_quantity_unit_code::varchar(2) as order_quantity_unit_code, -- 発注数量単位コード
    weight_cv_cls::varchar(1) as weight_cv_cls, -- 重量変換区分
    location_code::varchar(10) as location_code, -- 所番地
    supply_dest_id::varchar(15) as supply_dest_id, -- 支給先ID
    supply_dest_code::varchar(4) as supply_dest_code, -- 支給先コード
    supply_dest_name::varchar(8) as supply_dest_name, -- 支給先名
    delivery_number::varchar(5) as delivery_number, -- 納入番号
    machine_number::varchar(8) as machine_number, -- 機番
    st_no::varchar(2) as st_no, -- ST-No
    transfer_disposal_cls::varchar(1) as transfer_disposal_cls, -- 振替廃却区分
    transfer_form_wh_code::varchar(2) as transfer_form_wh_code, -- 振替先倉庫コード
    truck_cls::varchar(1) as truck_cls, -- 便区分
    transfer_dttm::varchar(14) as transfer_dttm, -- 振替日時
    delete_flag::varchar(1) as delete_flag, -- 削除
    sha2('gi_emp_code', 256) as gi_emp_code, -- 出庫者従業員コード
    gi_user_name::varchar(10) as gi_user_name, -- 出庫者名
    gi_user_depart_code::varchar(5) as gi_user_depart_code, -- 出庫者部署コード
    processing_date::varchar(14) as processing_date, -- 処理年月日
    spot_post_no::varchar(3) as spot_post_no, -- 現場ポストNo
    spot_depart_code::varchar(5) as spot_depart_code, -- 現場部署コード
    spec::varchar(59) as spec, -- スペック
    supplier_id::varchar(15) as supplier_id, -- 仕入先ID
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    supplier_abbreviation::varchar(8) as supplier_abbreviation, -- 仕入先名
    actual_delivery_date_truck::varchar(2) as actual_delivery_date_truck, -- 納入年月日便
    order_quantity::varchar(11) as order_quantity, -- 発注数量
    sheet_quantity::varchar(5) as sheet_quantity, -- シート数・本数
    sheet_quantity_unit::varchar(1) as sheet_quantity_unit, -- シート数・本数単位
    preferred_delivery_date::varchar(14) as preferred_delivery_date, -- 希望納期
    delivery_date::varchar(14) as delivery_date, -- 納期
    discharge_place::varchar(6) as discharge_place, -- 荷卸場
    part_item_no::varchar(10) as part_item_no, -- 部品品番
    step::varchar(4) as step, -- 工程
    b_l_line::varchar(4) as b_l_line, -- B/Lライン
    base_metal_arrangement_no::varchar(12) as base_metal_arrangement_no, -- 母材手配連番
    spls_mtl_mmt_no::varchar(12) as spls_mtl_mmt_no, -- 余剰材管理No
    toyota_note::varchar(30) as toyota_note, -- トヨタ備考
    request_date::varchar(14) as request_date, -- 依頼日付
    rqe_depart_code::varchar(5) as rqe_depart_code, -- 依頼部署コード
    rqe_depart_name::varchar(8) as rqe_depart_name, -- 依頼部署名
    requester_name::varchar(10) as requester_name, -- 依頼者名
    rqeuester_tel::varchar(13) as rqeuester_tel, -- 依頼者TEL
    now_stock_quantity::varchar(14) as now_stock_quantity, -- 現在在庫数量
    digestive_date::varchar(14) as digestive_date, -- 消化日
    digestive_reason::varchar(30) as digestive_reason, -- 消化理由
    stock_actual_input_cls::varchar(1) as stock_actual_input_cls, -- 在庫実績入力元区分
    if_created_date::varchar(14) as if_created_date, -- IF作成日
    batch_no::varchar(6) as batch_no, -- バッチNo
    gi_month::varchar(2) as gi_month, -- 出庫月
    issued_no::varchar(20) as issued_no, -- 発行No
    transfer_cls::varchar(1) as transfer_cls, -- 振分区分
    exchange_item::varchar(10) as exchange_item, -- 交換品
    exchange_date::varchar(14) as exchange_date, -- 交換日
    location::varchar(3) as location, -- ロケーション
    supply_delivery_number::varchar(20) as supply_delivery_number, -- 支給納入番号
    weigh_vote_serial_number::varchar(10) as weigh_vote_serial_number, -- 計量票連番
    supply_cls::varchar(1) as supply_cls, -- 支給区分
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(1) as factory_cls, -- 組織コード（工場区分）
    subinventory_code::varchar(2) as subinventory_code, -- 保管場所コード
    storage_shelf_id::varchar(15) as storage_shelf_id, -- 保管棚ID
    y_item_no_id::varchar(15) as y_item_no_id, -- Y品番ID
    y_item_no::varchar(10) as y_item_no, -- Y品番
    trade_quantity::varchar(14) as trade_quantity, -- 取引数量
    trade_date::varchar(14) as trade_date, -- 取引日
    gi_morphology_code::varchar(1) as gi_morphology_code, -- 出庫形態コード
    unused_return_count_date::varchar(14) as unused_return_count_date, -- 未使用返却カウント期日
    delivery_slip_no::varchar(20) as delivery_slip_no, -- 納品伝票No
    poisonous_mtls_gi_user::varchar(10) as poisonous_mtls_gi_user, -- 毒劇物出庫立会者
    poisonous_mtls_user::varchar(10) as poisonous_mtls_user, -- 毒劇物受取者
    poisonous_mtls_gi_date::varchar(14) as poisonous_mtls_gi_date, -- 毒劇物出庫(引取)年月日
    supply_item_id::varchar(15) as supply_item_id, -- 支給品ID
    supply_item_no::varchar(9) as supply_item_no, -- 支給品No.
    limited_if_created_date::varchar(14) as limited_if_created_date, -- 特急IF作成日
    red_and_black_judge_cls::varchar(1) as red_and_black_judge_cls, -- 赤黒判断区分
    gi_info_regist_flag::varchar(1) as gi_info_regist_flag, -- 出庫情報登録済フラグ
    steel_gi_memo::varchar(100) as steel_gi_memo, -- 鉄出庫時メモ
    daily_transmission_cls::varchar(1) as daily_transmission_cls, -- 日次伝送区分
    data_cls::varchar(2) as data_cls, -- データ区分
    ex_wh_code_gi::varchar(2) as ex_wh_code_gi, -- 交換品出庫倉庫
    ex_transfer_form_wh_code::varchar(2) as ex_transfer_form_wh_code, -- 交換品振替先倉庫
    ex_gi_post_no::varchar(3) as ex_gi_post_no, -- 交換品出庫ポストNo
    ex_storage_shelf_id::varchar(15) as ex_storage_shelf_id, -- 交換品保管棚ID
    exchange_item_delay_reason::varchar(30) as exchange_item_delay_reason, -- 交換品返却遅延理由
    source_stock_trade_id::varchar(15) as source_stock_trade_id, -- 起点在庫取引ID
    accepted_actual_id::varchar(15) as accepted_actual_id, -- 検収実績ID
    org_id::varchar(15) as org_id, -- 営業単位ID
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
    ldts -- B層取込日時
  from {{source('manufacturing_db_public', 'raw_stg_zaikotorihiki')}}
)
select * from stg_zaikotorihiki_maps_view