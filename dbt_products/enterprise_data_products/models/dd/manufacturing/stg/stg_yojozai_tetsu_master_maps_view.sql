{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_yojozai_tetsu_master') %}

with stg_yojozai_tetsu_master_maps_view as (
  select
    iron_spls_mtl_id::varchar(15) as iron_spls_mtl_id, -- 鉄余剰材ID
    spls_mtl_mmt_no::varchar(12) as spls_mtl_mmt_no, -- 余剰材管理No
    wh_code::varchar(2) as wh_code, -- 倉庫コード
    y_item_no_id::varchar(15) as y_item_no_id, -- Y品番ID
    y_item_no::varchar(10) as y_item_no, -- Y品番
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(1) as factory_cls, -- 組織コード（工場区分）
    progress_sts::varchar(1) as progress_sts, -- 進捗状況
    subinventory_cls::varchar(1) as subinventory_cls, -- 保管場所区分
    location_code_iron_id::varchar(15) as location_code_iron_id, -- 所番地(鉄)ID
    location_code::varchar(10) as location_code, -- 所番地
    weight::varchar(7) as weight, -- 重量
    part_item_no::varchar(10) as part_item_no, -- 部品品番
    maker_id::varchar(15) as maker_id, -- メーカーID
    preferred_maker_code::varchar(4) as preferred_maker_code, -- メーカーコード
    maker_name::varchar(8) as maker_name, -- メーカー名称
    mfg_y_m::varchar(6) as mfg_y_m, -- 製造年月
    mil_code::varchar(3) as mil_code, -- ミルコード
    spls_reason_cls::varchar(1) as spls_reason_cls, -- 余剰理由区分
    spls_reason_memo::varchar(1000) as spls_reason_memo, -- 余剰理由メモ
    coil_state::varchar(1) as coil_state, -- コイル状態
    actual_no::varchar(20) as actual_no, -- 現品No
    coil_state_memo::varchar(1000) as coil_state_memo, -- コイル状態メモ
    arrangement_serial_branch_no::varchar(12) as arrangement_serial_branch_no, -- 手配連番(+枝番)
    part_number::varchar(15) as part_number, -- 部品番号
    supply_registry_flag::varchar(1) as supply_registry_flag, -- 支給品登録済フラグ
    supplier_id::varchar(15) as supplier_id, -- 仕入先ID
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    supplier_abbreviation::varchar(8) as supplier_abbreviation, -- 仕入先名
    sha2('requester_fnd_user_id', 256) as requester_fnd_user_id, -- 依頼者ユーザー内部ID
    fnd_user_name::varchar(30) as fnd_user_name, -- 依頼者ユーザー名
    sha2('mployee_number', 256) as mployee_number, -- 依頼者従業員番号
    employee_name::varchar(10) as employee_name, -- 依頼者従業員名
    entry_test_mtl_cls::varchar(1) as entry_test_mtl_cls, -- 号口テスト材区分
    new_date::varchar(14) as new_date, -- 新設年月日
    update_date::varchar(14) as update_date, -- 更新年月日
    depart_code::varchar(5) as depart_code, -- 部署コード
    y_item_no_subject::varchar(2) as y_item_no_subject, -- Y品番科目
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
    note::varchar(30) as note, -- 備考
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

select * from stg_yojozai_tetsu_master_maps_view