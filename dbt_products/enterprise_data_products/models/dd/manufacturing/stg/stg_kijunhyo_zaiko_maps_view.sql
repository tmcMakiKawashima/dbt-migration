{{ config(
      materialized='view'
   )
}}

with stg_kijunhyo_zaiko_maps_view as (
  select
    std_tbl_stock_id::varchar(15) as std_tbl_stock_id, -- 基準表在庫ID
    year_month::varchar(6) as year_month, -- 年月
    y_item_no_id::varchar(15) as y_item_no_id, -- Y品番ID
    y_item_no::varchar(10) as y_item_no, -- Y品番
    wh_code::varchar(2) as wh_code, -- 倉庫コード
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(1) as factory_cls, -- 組織コード（工場区分）
    location_code_iron::varchar(10) as location_code_iron, -- 所番地(鉄)
    supplier_id::varchar(15) as supplier_id, -- 仕入先ID
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    supplier_abbreviation::varchar(8) as supplier_abbreviation, -- 仕入先名
    maker_id::varchar(15) as maker_id, -- メーカーID
    preferred_maker_code::varchar(4) as preferred_maker_code, -- メーカーコード
    preferred_maker_name::varchar(8) as preferred_maker_name, -- メーカー名
    entry_test_mtl_cls::varchar(1) as entry_test_mtl_cls, -- 号口テスト材区分
    use_actual::varchar(10) as use_actual, -- 使用実績
    delivery_actual::varchar(9) as delivery_actual, -- 納入実績
    entry_outside_use_actual::varchar(9) as entry_outside_use_actual, -- 号口外使用実績
    last_month_end_stock_qty::varchar(14) as last_month_end_stock_qty, -- 前月末在庫数量
    month_end_stock_quantity::varchar(14) as month_end_stock_quantity, -- 月末在庫数量
    arrangement_branch_cnt::varchar(15) as arrangement_branch_cnt, -- 手配連番枝番件数
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
    stock_correction_use::varchar(9) as stock_correction_use, -- たな卸補正(使用実績)
    stock_correction_delivery::varchar(9) as stock_correction_delivery, -- たな卸補正(納入実績)
    ldts -- B層取込日時
  from {{source('manufacturing_db_public', 'raw_stg_kijunhyo_zaiko')}}
)
select * from stg_kijunhyo_zaiko_maps_view