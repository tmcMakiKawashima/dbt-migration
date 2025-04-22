{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_tokorobanchi_tetsuigai_haishi') %}

with stg_tokorobanchi_tetsuigai_haishi_maps_view as (
  select
    location_abls_not_iron_id::varchar(15) as location_abls_not_iron_id, -- 所番地廃止(鉄以外)ID
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(1) as factory_cls, -- 組織コード（工場区分）
    inventory_item_id_y::varchar(15) as inventory_item_id_y, -- 品目ID（Y品番)
    y_item_no::varchar(10) as y_item_no, -- Y品番
    subinventory_code::varchar(2) as subinventory_code, -- 保管場所コード
    control_key::varchar(1) as control_key, -- コントロールキー
    spot_post_no::varchar(3) as spot_post_no, -- 現場ポストNo
    tank_no::varchar(3) as tank_no, -- タンクNo
    supplier_id::varchar(15) as supplier_id, -- 仕入先ID
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    supplier_abbreviation::varchar(8) as supplier_abbreviation, -- 仕入先名
    location_code::varchar(10) as location_code, -- 所番地
    discharge_place::varchar(6) as discharge_place, -- 荷卸場
    order_point::varchar(12) as order_point, -- 発注点
    surplus_exisit_cls::varchar(1) as surplus_exisit_cls, -- 余剰有無区分
    kanban_sheet_qty::varchar(3) as kanban_sheet_qty, -- かんばん枚数
    sheet_lot_quantity::varchar(11) as sheet_lot_quantity, -- 枚当りロット数量
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
    new_date::varchar(14) as new_date, -- 新設年月日
    update_date::varchar(14) as update_date, -- 更新年月日
    location_abls_reason::varchar(30) as location_abls_reason, -- 所番地廃止理由
    kanban_order_decision::varchar(1) as kanban_order_decision, -- かんばん発注決裁
    spec::varchar(59) as spec, -- スペック
    abls_depart_code::varchar(5) as abls_depart_code, -- 廃止(部署コード)
    sha2('abls_emp_code', 256) as abls_emp_code, -- 廃止(従業員コード)
    abls_update_date::varchar(14) as abls_update_date, -- 廃止日
    subinventory_code_gi::varchar(2) as subinventory_code_gi, -- 保管場所コード(出庫元)
    sha2('rqe_emp_code', 256) as rqe_emp_code, -- 依頼者従業員コード
    rqe_date::varchar(14) as rqe_date, -- 依頼年月日
    sha2('new_emp_code', 256) as new_emp_code, -- 新設(従業員コード)
    sha2('update_emp_code', 256) as update_emp_code, -- 更新(従業員コード)
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

select * from stg_tokorobanchi_tetsuigai_haishi_maps_view