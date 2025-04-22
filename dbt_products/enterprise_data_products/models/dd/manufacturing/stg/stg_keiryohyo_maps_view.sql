{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_keiryohyo') %}

with stg_keiryohyo_maps_view as (
  select
    measurement_vote_id::varchar(15) as measurement_vote_id, -- 計量票ID
    weigh_vote_serial_number::varchar(10) as weigh_vote_serial_number, -- 計量票連番
    weigh_vote_cls::varchar(1) as weigh_vote_cls, -- 計量票区分
    total_weight::varchar(9) as total_weight, -- 総重量
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(1) as factory_cls, -- 組織コード（工場区分）
    tare_weight::varchar(9) as tare_weight, -- 風袋重量
    pallet_weight::varchar(9) as pallet_weight, -- パレット重量
    y_item_no_id::varchar(15) as y_item_no_id, -- Y品番ID
    y_item_no::varchar(10) as y_item_no, -- Y品番
    supply_dest_id::varchar(15) as supply_dest_id, -- 支給先ID
    supply_dest_code::varchar(4) as supply_dest_code, -- 支給先コード
    supply_dest_name::varchar(8) as supply_dest_name, -- 支給先名
    gi_date::varchar(14) as gi_date, -- 出庫年月日
    wh_code::varchar(2) as wh_code, -- 倉庫コード
    burden_depart_code::varchar(5) as burden_depart_code, -- 負担部署コード
    gi_weight::varchar(11) as gi_weight, -- 出庫重量
    export::varchar(30) as export, -- 搬出
    export_others::varchar(30) as export_others, -- 搬出_その他
    driver::varchar(15) as driver, -- 運転手
    vehicle_no::varchar(20) as vehicle_no, -- 車両No
    note::varchar(30) as note, -- 備考
    form_output_date::varchar(14) as form_output_date, -- 帳票出力日
    discharge_place_flag::varchar(1) as discharge_place_flag, -- 確定フラグ
    sha2('ht_acceptance_inspect_id', 256) as ht_acceptance_inspect_id, -- 処理者ユーザー内部ID
    fnd_user_name::varchar(30) as fnd_user_name, -- 処理者ユーザー名
    sha2('employee_code', 256) as employee_code, -- 処理者従業員番号
    employee_name::varchar(10) as employee_name, -- 処理者従業員名
    processing_date_time::varchar(14) as processing_date_time, -- 処理日時
    supply_item_no::varchar(9) as supply_item_no, -- 支給品No.
    org_id::varchar(15) as org_id, -- 営業単位ID
    object_version_number::varchar(9) as object_version_number, -- Object Version Number
    sha2('created_by', 256) as created_by, -- 作成者
    created_user_name::varchar(30) as created_user_name, -- 作成者ユーザー名
    creation_date::varchar(14) as creation_date, -- 作成日時
    last_updated_user_name::varchar(30) as last_updated_user_name, -- 最終更新者ユーザー名
    sha2('last_updated_by', 256) as last_updated_by, -- 最終更新者
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

select * from stg_keiryohyo_maps_view