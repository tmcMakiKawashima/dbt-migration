{{ config(
      materialized='view'
   )
}}

with stg_yhinbanhenko_maps_view as (
  select
    y_item_no_update_hstr_id::varchar(15) as y_item_no_update_hstr_id, -- Y品番更新履歴ID
    y_item_no_id::varchar(15) as y_item_no_id, -- Y品番ID
    chg_reason::varchar(100) as chg_reason, -- 変更理由
    chg_ntc::varchar(1) as chg_ntc, -- 変更通知有無
    y_item_no_chg_cls::varchar(1) as y_item_no_chg_cls, -- Y品番変更区分
    supplier_id::varchar(15) as supplier_id, -- 仕入先ID
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    supplier_abbreviation::varchar(8) as supplier_abbreviation, -- 仕入先名
    y_item_no::varchar(10) as y_item_no, -- Y品番
    item_name::varchar(15) as item_name, -- 品名
    weigh_necessity_cls::varchar(1) as weigh_necessity_cls, -- 計量要否区分
    multiple_companies_order_cls::varchar(1) as multiple_companies_order_cls, -- 複社発注区分
    order_quantity_unit_code::varchar(2) as order_quantity_unit_code, -- 発注数量単位コード
    sheet_quantity_unit::varchar(1) as sheet_quantity_unit, -- シート数・本数単位
    packing_code::varchar(2) as packing_code, -- 荷姿コード
    packing_weight::varchar(9) as packing_weight, -- 荷姿重量
    un_total_cls::varchar(1) as un_total_cls, -- 非集計区分
    in_house_repair_item_cls::varchar(1) as in_house_repair_item_cls, -- 内製修理品区分
    in_house_make_item_cls::varchar(1) as in_house_make_item_cls, -- 内製製作品区分
    z_item_cls::varchar(1) as z_item_cls, -- Z品区分
    weight_cv_cls::varchar(1) as weight_cv_cls, -- 重量変換区分
    tool_classification_code::varchar(1) as tool_classification_code, -- 工具種別コード
    metre_weight::varchar(8) as metre_weight, -- メートル重量
    square_metre_weight::varchar(7) as square_metre_weight, -- 平方メートル重量
    poisonous_mtls_cls::varchar(1) as poisonous_mtls_cls, -- 毒劇物区分
    mfg_maker_id::varchar(15) as mfg_maker_id, -- 製造メーカーID
    preferred_maker_code::varchar(4) as preferred_maker_code, -- メーカーコード
    preferred_maker_name::varchar(8) as preferred_maker_name, -- 製造メーカー名
    minimum_odr_quantity::varchar(11) as minimum_odr_quantity, -- 最少発注数
    tool_no::varchar(24) as tool_no, -- ツールNo
    suspension_of_order_date::varchar(14) as suspension_of_order_date, -- 発注停止年月日
    order_suspension_reason_cls::varchar(1) as order_suspension_reason_cls, -- 発注停止理由区分
    take_back_quantity::varchar(11) as take_back_quantity, -- 引取残数
    small_large_qty_cls::varchar(1) as small_large_qty_cls, -- 少多区分
    tool_abls_date::varchar(14) as tool_abls_date, -- 工具廃止予定日
    spec::varchar(59) as spec, -- スペック
    suspension_of_order_contents::varchar(15) as suspension_of_order_contents, -- 発注停止内容
    recycle_item_cls::varchar(1) as recycle_item_cls, -- 再生品区分
    goods_code::varchar(20) as goods_code, -- 商品コード
    supply_cls::varchar(1) as supply_cls, -- 支給区分
    inexpensive_item_no::varchar(200) as inexpensive_item_no, -- 安価品品番
    machine_number_mmt_cls::varchar(1) as machine_number_mmt_cls, -- 機番管理区分
    recycle_item_no::varchar(10) as recycle_item_no, -- 再生品番
    product_mfg_cls::varchar(1) as product_mfg_cls, -- 製品製造区分
    preferred_base_name::varchar(15) as preferred_base_name, -- 製造会社
    preferred_base_location::varchar(15) as preferred_base_location, -- 製造場所
    substitute_item_no::varchar(200) as substitute_item_no, -- 代替品番
    hazardous_mtl_cls::varchar(1) as hazardous_mtl_cls, -- 危険物区分
    self_repairable_cls::varchar(1) as self_repairable_cls, -- 自社修理可否区分
    wh_code_intensive_stock::varchar(2) as wh_code_intensive_stock, -- 集中在庫倉庫コード
    note::varchar(30) as note, -- 備考
    sheet_weight::varchar(8) as sheet_weight, -- シート・本重量
    y_item_no_new_date::varchar(14) as y_item_no_new_date, -- Y品番新設年月日
    y_item_no_update_date::varchar(14) as y_item_no_update_date, -- Y品番訂正年月日
    supplier_new_date::varchar(14) as supplier_new_date, -- 仕入先新設年月日
    supplier_correction_date::varchar(14) as supplier_correction_date, -- 仕入先訂正年月日
    internal_capacity::varchar(20) as internal_capacity, -- 内容量(入数)
    gas_cylinder_mmt_cls::varchar(1) as gas_cylinder_mmt_cls, -- ガスボンベ管理区分
    base_metal_item_no::varchar(54) as base_metal_item_no, -- 母材品番
    cost_reduction_act_deadline::varchar(14) as cost_reduction_act_deadline, -- 原低活動不可期限
    item_classification_id::varchar(15) as item_classification_id, -- 品目分類ID
    item_classification_code::varchar(12) as item_classification_code, -- 品目分類コード
    item_classification_name::varchar(18) as item_classification_name, -- 品目分類名
    mfg_days::varchar(3) as mfg_days, -- 製造日数
    tl_decision_trade_quantity::varchar(7) as tl_decision_trade_quantity, -- 決定引取数
    tl_standard_trade_quantity::varchar(7) as tl_standard_trade_quantity, -- (工具)標準引取数
    tl_desired_take_back_qty::varchar(7) as tl_desired_take_back_qty, -- (工具)希望引取数
    tl_in_prcs_item_desired_qty::varchar(7) as tl_in_prcs_item_desired_qty, -- (工具)仕掛品希望引取数
    tl_in_prcs_item_decision_qty::varchar(7) as tl_in_prcs_item_decision_qty, -- (工具)仕掛品決定引取数
    little_many_available_date::varchar(14) as little_many_available_date, -- 少⇒多_対応可能日
    tool_classification_cd::varchar(4) as tool_classification_cd, -- 工具分類CD
    supplier_stock_cls::varchar(1) as supplier_stock_cls, -- 仕入先在庫区分
    other_c_repair_approval_cls::varchar(1) as other_c_repair_approval_cls, -- 他社修理許可区分
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(3) as factory_cls, -- 組織コード（工場区分）
    mfg_stop_reason::varchar(30) as mfg_stop_reason, -- 製造中止理由
    registry_date::varchar(14) as registry_date, -- 登録日
    sha2('registry_fnd_user_id', 256) as registry_fnd_user_id, -- 登録者内部ユーザID
    registry_fnd_user_name::varchar(30) as registry_fnd_user_name, -- 登録者ユーザー名
    sha2('registry_mployee_number', 256) as registry_mployee_number, -- 登録者従業員番号
    registry_employee_name::varchar(10) as registry_employee_name, -- 登録者従業員名
    old_y_item_no_hstr::varchar(200) as old_y_item_no_hstr, -- 旧品番履歴
    factory_portion_wh_code_hstr::varchar(60) as factory_portion_wh_code_hstr, -- 工場割倉庫コード履歴
    min_mfg_lot_number::varchar(4) as min_mfg_lot_number, -- 最小製造ロット数
    z_pear_y_item_no_hstr::varchar(200) as z_pear_y_item_no_hstr, -- Zペア品番履歴
    chg_rqe_supplier_code::varchar(4) as chg_rqe_supplier_code, -- 変更申請仕入先コード
    chg_rqe_supplier_name::varchar(20) as chg_rqe_supplier_name, -- 変更申請仕入先名
    chg_rqe_depart::varchar(5) as chg_rqe_depart, -- 変更申請部署
    chg_rqe_user::varchar(20) as chg_rqe_user, -- 変更申請者
    chg_rqe_user_tel_outside_lin::varchar(13) as chg_rqe_user_tel_outside_lin, -- 変更申請者連絡先（外線）
    order_suspension_clear_dt::varchar(14) as order_suspension_clear_dt, -- 発注停止解除年月日
    other_c_repair_approval_date::varchar(14) as other_c_repair_approval_date, -- 他社修理許可年月日
    sha2('other_c_rep_approval_user_id', 256) as other_c_rep_approval_user_id, -- 他社修理許可者ユーザー内部ID
    other_c_rep_approval_user_name::varchar(30) as other_c_rep_approval_user_name, -- 他社修理許可者ユーザー名
    sha2('other_c_rep_approval_emp_no', 256) as other_c_rep_approval_emp_no, -- 他社修理許可者従業員番号
    other_c_rep_approval_emp_name::varchar(10) as other_c_rep_approval_emp_name, -- 他社修理許可者従業員名
    pulling_up_cls::varchar(1) as pulling_up_cls, -- 引上区分
    tool_mmt_cls::varchar(2) as tool_mmt_cls, -- 工具管理用区分
    storage_cls::varchar(1) as storage_cls, -- 保管区分
    storage_details_condition::varchar(100) as storage_details_condition, -- 保管詳細条件
    use_deadline_cls::varchar(1) as use_deadline_cls, -- 使用期限区分
    use_deadline_details::varchar(100) as use_deadline_details, -- 使用期限詳細
    note_for_supplier::varchar(80) as note_for_supplier, -- 仕入先備考
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
    inner_chg_ntc::varchar(1) as inner_chg_ntc, -- 変更通知有無（社内）
    ldts -- B層取込日時
  from {{source('manufacturing_db_public', 'raw_stg_yhinbanhenko')}}
)
select * from stg_yhinbanhenko_maps_view