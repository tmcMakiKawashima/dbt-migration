{{ config(
      materialized='view'
   )
}}

with stg_yhinban_master_maps_view as (
  select
    y_item_no_id::varchar(15) as y_item_no_id, -- Y品番ID
    inventory_item_id::varchar(15) as inventory_item_id, -- 品目ID
    y_item_no::varchar(10) as y_item_no, -- Y品番
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(3) as factory_cls, -- 組織コード（工場区分）
    item_name::varchar(15) as item_name, -- 品名
    item_name_unneeded_char_del::varchar(15) as item_name_unneeded_char_del, -- 品名(不要文字削除)
    tool_no::varchar(24) as tool_no, -- ツールNo
    tool_no_unneeded_char_del::varchar(24) as tool_no_unneeded_char_del, -- ツールNo(不要文字削除)
    shortening_tool_no::varchar(24) as shortening_tool_no, -- 短縮ツールNo
    iron_cls::varchar(1) as iron_cls, -- 鉄区分
    y_item_no_subject::varchar(2) as y_item_no_subject, -- Y品番科目
    weigh_necessity_cls::varchar(1) as weigh_necessity_cls, -- 計量要否区分
    multiple_companies_order_cls::varchar(1) as multiple_companies_order_cls, -- 複社発注区分
    order_quantity_unit_code::varchar(2) as order_quantity_unit_code, -- 発注数量単位コード
    sheet_quantity_unit::varchar(1) as sheet_quantity_unit, -- シート数・本数単位
    packing_code::varchar(2) as packing_code, -- 荷姿コード
    packing_weight::varchar(9) as packing_weight, -- 荷姿重量
    un_total_cls::varchar(1) as un_total_cls, -- 非集計区分
    wh_code_intensive_stock::varchar(2) as wh_code_intensive_stock, -- 集中在庫倉庫コード
    product_mfg_cls::varchar(1) as product_mfg_cls, -- 製品製造区分
    in_house_repair_item_cls::varchar(1) as in_house_repair_item_cls, -- 内製修理品区分
    in_house_make_item_cls::varchar(1) as in_house_make_item_cls, -- 内製製作品区分
    z_item_cls::varchar(1) as z_item_cls, -- Z品区分
    weight_cv_cls::varchar(1) as weight_cv_cls, -- 重量変換区分
    tool_classification_code::varchar(1) as tool_classification_code, -- 工具種別コード
    tool_mmt_cls::varchar(2) as tool_mmt_cls, -- 工具管理用区分
    tool_abls_date::varchar(14) as tool_abls_date, -- 工具廃止予定日
    metre_weight::varchar(8) as metre_weight, -- メートル重量
    square_metre_weight::varchar(7) as square_metre_weight, -- 平方メートル重量
    y_item_no_new_date::varchar(14) as y_item_no_new_date, -- Y品番新設年月日
    y_item_no_update_date::varchar(14) as y_item_no_update_date, -- Y品番訂正年月日
    supply_cls::varchar(1) as supply_cls, -- 支給区分
    poisonous_mtls_cls::varchar(1) as poisonous_mtls_cls, -- 毒劇物区分
    machine_number_mmt_cls::varchar(1) as machine_number_mmt_cls, -- 機番管理区分
    hazardous_mtl_cls::varchar(1) as hazardous_mtl_cls, -- 危険物区分
    item_classification_id::varchar(15) as item_classification_id, -- 品目分類ID
    item_classification_code::varchar(12) as item_classification_code, -- 品目分類コード
    item_classification_name::varchar(18) as item_classification_name, -- 品目分類名
    gas_cylinder_mmt_cls::varchar(1) as gas_cylinder_mmt_cls, -- ガスボンベ管理区分
    inexpensive_item_no::varchar(200) as inexpensive_item_no, -- 安価品品番
    base_metal_item_no::varchar(54) as base_metal_item_no, -- 母材品番
    recycle_item_cls::varchar(1) as recycle_item_cls, -- 再生品区分
    recycle_item_no::varchar(10) as recycle_item_no, -- 再生品番
    small_large_qty_cls::varchar(1) as small_large_qty_cls, -- 少多区分
    pulling_up_cls::varchar(1) as pulling_up_cls, -- 引上区分
    quality_of_mtl::varchar(18) as quality_of_mtl, -- 材質
    coating::varchar(8) as coating, -- 目付
    board_thickness::varchar(6) as board_thickness, -- 板厚
    width::varchar(8) as width, -- 幅
    first_dimension::varchar(8) as first_dimension, -- 第1寸法
    second_dimension::varchar(8) as second_dimension, -- 第2寸法
    tolerance::varchar(1) as tolerance, -- 公差
    dimension_diameter::varchar(7) as dimension_diameter, -- 寸法・径
    shape_finish::varchar(4) as shape_finish, -- 形状･仕上げ
    y2_length::varchar(5) as y2_length, -- Y2(長さ)
    cut_dimension::varchar(8) as cut_dimension, -- 切断寸法
    use::varchar(2) as use, -- 用途
    state::varchar(2) as state, -- 状態
    jominy::varchar(5) as jominy, -- ジョミニ
    others::varchar(1) as others, -- その他
    outer_diameter1::varchar(5) as outer_diameter1, -- 外径1
    outer_diameter2::varchar(5) as outer_diameter2, -- 外径2
    wall_thickness::varchar(6) as wall_thickness, -- 肉厚
    y3_length::varchar(8) as y3_length, -- Y3(長さ)
    spec_iron::varchar(59) as spec_iron, -- スペック(鉄)
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
  from {{source('manufacturing_db_public', 'raw_stg_yhinban_master')}}
)
select * from stg_yhinban_master_maps_view