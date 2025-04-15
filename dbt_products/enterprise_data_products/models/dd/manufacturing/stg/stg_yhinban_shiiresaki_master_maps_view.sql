{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_yhinban_shiiresaki_master') %}

with stg_yhinban_shiiresaki_master_maps_view as (
  select
    y_item_no_supplier_id::varchar(15) as y_item_no_supplier_id, -- Y品番-仕入先ID
    y_item_no_id::varchar(15) as y_item_no_id, -- Y品番ID
    y_item_no::varchar(10) as y_item_no, -- Y品番
    supplier_id::varchar(15) as supplier_id, -- 仕入先ID
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    supplier_name::varchar(8) as supplier_name, -- 仕入先名
    mfg_maker_id::varchar(15) as mfg_maker_id, -- 製造メーカーID
    preferred_maker_code::varchar(4) as preferred_maker_code, -- 製造メーカーコード
    preferred_maker_name::varchar(8) as preferred_maker_name, -- 製造メーカー名
    minimum_odr_quantity::varchar(11) as minimum_odr_quantity, -- 最少発注数
    suspension_of_order_date::varchar(14) as suspension_of_order_date, -- 発注停止年月日
    order_suspension_reason_cls::varchar(1) as order_suspension_reason_cls, -- 発注停止理由区分
    tl_desired_take_back_qty::varchar(7) as tl_desired_take_back_qty, -- (工具)希望引取数
    new_date::varchar(14) as new_date, -- 新設年月日
    correction_date::varchar(14) as correction_date, -- 訂正年月日
    suspension_of_order_contents::varchar(15) as suspension_of_order_contents, -- 発注停止内容
    note::varchar(100) as note, -- 備考
    spec::varchar(59) as spec, -- スペック
    spec_unneeded_char_del::varchar(59) as spec_unneeded_char_del, -- スペック(不要文字削除)
    shortening_spec::varchar(59) as shortening_spec, -- 短縮スペック
    sheet_weight::varchar(8) as sheet_weight, -- シート・本重量
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(3) as factory_cls, -- 組織コード（工場区分）
    stock_base_name::varchar(15) as stock_base_name, -- 在庫拠点名
    shipment_base_name::varchar(15) as shipment_base_name, -- 出荷拠点名
    preferred_base_name::varchar(15) as preferred_base_name, -- 製造会社
    preferred_base_location::varchar(15) as preferred_base_location, -- 製造場所
    take_back_quantity::varchar(11) as take_back_quantity, -- 引取残数
    storage_cls::varchar(1) as storage_cls, -- 保管区分
    self_repairable_cls::varchar(1) as self_repairable_cls, -- 自社修理可否区分
    internal_capacity::varchar(20) as internal_capacity, -- 内容量(入数)
    cost_reduction_act_deadline::varchar(14) as cost_reduction_act_deadline, -- 原低活動不可期限
    mfg_days::varchar(3) as mfg_days, -- 製造日数
    min_mfg_lot_number::varchar(4) as min_mfg_lot_number, -- 最小製造ロット数
    storage_details_condition::varchar(100) as storage_details_condition, -- 保管詳細条件
    use_deadline_cls::varchar(1) as use_deadline_cls, -- 使用期限区分
    use_deadline_details::varchar(100) as use_deadline_details, -- 使用期限詳細
    shipment_base_location::varchar(15) as shipment_base_location, -- 出荷拠点所在地
    stock_base_location::varchar(15) as stock_base_location, -- 在庫拠点所在地
    decision_trade_quantity::varchar(7) as decision_trade_quantity, -- 決定取引数
    tl_decision_trade_quantity::varchar(7) as tl_decision_trade_quantity, -- 決定引取数
    tl_standard_trade_quantity::varchar(7) as tl_standard_trade_quantity, -- (工具)標準引取数
    tl_in_prcs_item_desired_qty::varchar(7) as tl_in_prcs_item_desired_qty, -- (工具)仕掛品希望引取数
    tl_in_prcs_item_decision_qty::varchar(7) as tl_in_prcs_item_decision_qty, -- (工具)仕掛品決定引取数
    little_many_available_date::varchar(14) as little_many_available_date, -- 少カラ多_対応可能日
    supplier_stock_cls::varchar(1) as supplier_stock_cls, -- 仕入先在庫区分
    goods_code::varchar(20) as goods_code, -- 商品コード
    other_c_repair_approval_cls::varchar(1) as other_c_repair_approval_cls, -- 他社修理許可区分
    tool_classification_cd::varchar(4) as tool_classification_cd, -- 工具分類CD
    picture_file_pass::varchar(300) as picture_file_pass, -- 画像ファイルパス
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
    "ldts" -- B層取込日時
  from {{ source_table.database }}.{{ source_table.schema }}."{{ source_table.name | lower }}"
)

select * from stg_yhinban_shiiresaki_master_maps_view