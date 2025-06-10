{{ config(
      materialized='view'
   )
}}

with stg_gashokanbasyo_maps_view as (
  select
    gas_cylinder_storage_hstr_id::varchar(15) as gas_cylinder_storage_hstr_id, -- ガスボンベ保管場所履歴ID
    gas_cylinder_no::varchar(20) as gas_cylinder_no, -- ボンベNo
    arrangement_serial_no::varchar(6) as arrangement_serial_no, -- 手配連番
    arrangement_branch_no::varchar(6) as arrangement_branch_no, -- 手配連番枝番
    seq_no::varchar(15) as seq_no, -- シーケンスNo
    trade_dttm::varchar(14) as trade_dttm, -- 取引日時
    trade_type::varchar(1) as trade_type, -- 取引タイプ
    subinventory_type::varchar(1) as subinventory_type, -- 保管場所タイプ
    subinventory_code::varchar(5) as subinventory_code, -- 保管場所コード
    y_item_no_id::varchar(15) as y_item_no_id, -- Y品番ID
    y_item_no::varchar(10) as y_item_no, -- Y品番
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(1) as factory_cls, -- 組織コード（工場区分）
    wh_code::varchar(2) as wh_code, -- 倉庫コード
    gi_depart_code::varchar(5) as gi_depart_code, -- 部署コード(出庫先)
    post_no::varchar(3) as post_no, -- ポストNo
    supplier_id::varchar(15) as supplier_id, -- 仕入先ID
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    supplier_name::varchar(8) as supplier_name, -- 仕入先名
    comment_msg::varchar(100) as comment_msg, -- コメント
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
  from {{source('manufacturing_db_public', 'raw_stg_gashokanbasyo')}}
)
select * from stg_gashokanbasyo_maps_view