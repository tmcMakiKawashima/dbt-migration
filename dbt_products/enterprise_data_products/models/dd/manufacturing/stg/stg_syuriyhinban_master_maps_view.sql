{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_syuriyhinban_master') %}

with stg_syuriyhinban_master_maps_view as (
  select
    repair_y_item_no_id::varchar(15) as repair_y_item_no_id, -- 修理Y品番ID
    y_item_no_id::varchar(15) as y_item_no_id, -- Y品番ID
    y_item_no::varchar(10) as y_item_no, -- Y品番
    supplier_id::varchar(15) as supplier_id, -- 仕入先ID
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    supplier_abbreviation::varchar(8) as supplier_abbreviation, -- 仕入先名
    repair_supplier_id::varchar(15) as repair_supplier_id, -- 修理仕入先ID
    repair_supplier_code::varchar(4) as repair_supplier_code, -- 修理仕入先コード
    repair_supplier_name::varchar(8) as repair_supplier_name, -- 修理仕入先名
    fixed_amount_repair_ptrn::varchar(1) as fixed_amount_repair_ptrn, -- 定額修理パターン
    repair_lt::varchar(3) as repair_lt, -- 修理LT
    fixed_amount_repair_cls::varchar(1) as fixed_amount_repair_cls, -- 定額修理区分
    new_date::varchar(14) as new_date, -- 新設年月日
    update_date::varchar(14) as update_date, -- 更新年月日
    repair_item_take_back_yn::varchar(1) as repair_item_take_back_yn, -- 修理品引取可否
    repair_end_plan_date::varchar(14) as repair_end_plan_date, -- 修理終了予定日
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

select * from stg_syuriyhinban_master_maps_view