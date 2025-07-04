{{ config(
      materialized='view'
   )
}}

with stg_postnodaihyosya_master_maps_view as (
  select
    post_no_spokesperson_id::varchar(15) as post_no_spokesperson_id, -- ポストNo.代表者ID
    spot_post_no::varchar(3) as spot_post_no, -- 現場ポストNo
    sha2('spokesperson_fnd_user_id', 256) as spokesperson_fnd_user_id, -- 代表者ユーザー内部ID
    fnd_user_name::varchar(30) as fnd_user_name, -- 代表者ユーザー名
    sha2('employee_number', 256) as employee_number, -- 代表者従業員番号
    employee_name::varchar(10) as employee_name, -- 代表者従業員名
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(1) as factory_cls, -- 組織コード（工場区分）
    spokesperson_external_tel_fg::varchar(1) as spokesperson_external_tel_fg, -- 代表外線番号フラグ
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
  from {{source('manufacturing_db_public', 'raw_stg_postnodaihyosya_master')}}
)
select * from stg_postnodaihyosya_master_maps_view