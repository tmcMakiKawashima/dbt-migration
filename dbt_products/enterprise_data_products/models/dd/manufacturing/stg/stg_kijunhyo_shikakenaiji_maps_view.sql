{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_kijunhyo_shikakenaiji') %}

with stg_kijunhyo_shikakenaiji_maps_view as (
  select
    std_tbl_in_prcs_mtl_rqi_id::varchar(15) as std_tbl_in_prcs_mtl_rqi_id, -- 基準表仕掛内示ID
    year_month::varchar(6) as year_month, -- 年月
    inventory_item_id::varchar(15) as inventory_item_id, -- 品目ID
    part_item_name::varchar(15) as part_item_name, -- 部品品名
    arrangement_from::varchar(6) as arrangement_from, -- 手配カラ
    subinventory_code::varchar(2) as subinventory_code, -- 保管場所コード
    location_code::varchar(10) as location_code, -- 所番地
    inventory_item_id_y::varchar(15) as inventory_item_id_y, -- 品目ID（Y品番)
    y_item_no::varchar(10) as y_item_no, -- Y品番
    monthly_used::varchar(8) as monthly_used, -- 月間使用個数
    direct_use_quantity_max::varchar(7) as direct_use_quantity_max, -- 直使用個数（MAX）
    parent_child_cls::varchar(1) as parent_child_cls, -- 親子区分
    same_time_cls::varchar(1) as same_time_cls, -- 同時区分
    line::varchar(3) as line, -- ライン
    store_address::varchar(45) as store_address, -- ストアー番地
    lot_size::varchar(7) as lot_size, -- ロットサイズ
    lot_cycle_n_month::varchar(5) as lot_cycle_n_month, -- ロットサイクル（N月）
    pattern_production_cls::varchar(1) as pattern_production_cls, -- パターン生産区分
    supply_parts_quantity::varchar(7) as supply_parts_quantity, -- 補給パーツ数量
    parts_production_line_code::varchar(6) as parts_production_line_code, -- 部品生産ラインコード
    operation::varchar(4) as operation, -- 工程
    part_item_no::varchar(10) as part_item_no, -- 部品品番
    type::varchar(2) as type, -- 類別
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(1) as factory_cls, -- 組織コード（工場区分）
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

select * from stg_kijunhyo_shikakenaiji_maps_view