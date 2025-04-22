{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_kijunhyo_kouzaitehai') %}

with stg_kijunhyo_kouzaitehai_maps_view as (
  select
    std_tbl_steel_prct_arng_id::varchar(15) as std_tbl_steel_prct_arng_id, -- 基準表鋼材手配ID
    year_month::varchar(6) as year_month, -- 年月
    inventory_item_id::varchar(15) as inventory_item_id, -- 品目ID
    y_item_no::varchar(10) as y_item_no, -- Y品番
    subinventory_code::varchar(2) as subinventory_code, -- 保管場所コード
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(1) as factory_cls, -- 組織コード（工場区分）
    supplier_id::varchar(15) as supplier_id, -- 仕入先ID
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    supplier_name::varchar(8) as supplier_name, -- 仕入先名
    maker_id::varchar(15) as maker_id, -- メーカーID
    preferred_maker_code::varchar(4) as preferred_maker_code, -- メーカーコード
    preferred_maker_name::varchar(8) as preferred_maker_name, -- メーカー名
    mtl_rqi_y_m_from::varchar(6) as mtl_rqi_y_m_from, -- 内示年月カラ
    mtl_rqi_y_m_to::varchar(6) as mtl_rqi_y_m_to, -- 内示年月マデ
    appricable_period_from::varchar(14) as appricable_period_from, -- 適用期間カラ
    appricable_period_to::varchar(14) as appricable_period_to, -- 適用期間マデ
    delivery_cycle::varchar(6) as delivery_cycle, -- 納入サイクル
    kanban_destination_no_a::varchar(3) as kanban_destination_no_a, -- かんばん行先NoA_調達拠点
    kanban_destination_no_b::varchar(3) as kanban_destination_no_b, -- かんばん行先NoB_統括拠点
    arrangement_cls::varchar(1) as arrangement_cls, -- 手配区分
    standard_weight::varchar(5) as standard_weight, -- 基準重量
    sheet_quantity::varchar(5) as sheet_quantity, -- シート数・本数
    multiple_companies_order_cls::varchar(1) as multiple_companies_order_cls, -- 複社発注区分
    importance_mmt_mtl::varchar(1) as importance_mmt_mtl, -- 重点管理資材
    comments::varchar(400) as comments, -- コメント
    mil_code::varchar(3) as mil_code, -- ミルコード
    new_equipment_switch_mtl_cls::varchar(1) as new_equipment_switch_mtl_cls, -- 新機材切替材区分
    old_y_item_no::varchar(10) as old_y_item_no, -- 旧Y品番
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

select * from stg_kijunhyo_kouzaitehai_maps_view