{{ config(
      materialized='view'
   )
}}

with stg_calendar_master_maps_view as (
  select
    calendar_id::varchar(15) as calendar_id, -- カレンダー_ID
    calendar_type::varchar(2) as calendar_type, -- カレンダ種別
    wh_code::varchar(2) as wh_code, -- 倉庫コード
    store::varchar(2) as store, -- ストア
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    kanban_destination_no::varchar(3) as kanban_destination_no, -- かんばん行先No
    year_month::varchar(6) as year_month, -- 年月
    decision_status::varchar(1) as decision_status, -- 決裁状況
    decision_comment::varchar(30) as decision_comment, -- 決裁コメント
    straight_number::varchar(2) as straight_number, -- 直数
    first::varchar(1) as first, -- 1日
    second::varchar(1) as second, -- 2日
    third::varchar(1) as third, -- 3日
    fourth::varchar(1) as fourth, -- 4日
    fifth::varchar(1) as fifth, -- 5日
    sixth::varchar(1) as sixth, -- 6日
    seventh::varchar(1) as seventh, -- 7日
    eighth::varchar(1) as eighth, -- 8日
    ninth::varchar(1) as ninth, -- 9日
    tenth::varchar(1) as tenth, -- 10日
    eleventh::varchar(1) as eleventh, -- 11日
    twelfth::varchar(1) as twelfth, -- 12日
    thirteenth::varchar(1) as thirteenth, -- 13日
    fourteenth::varchar(1) as fourteenth, -- 14日
    fifteenth::varchar(1) as fifteenth, -- 15日
    sixteenth::varchar(1) as sixteenth, -- 16日
    seventeenth::varchar(1) as seventeenth, -- 17日
    eighteenth::varchar(1) as eighteenth, -- 18日
    nineteenth::varchar(1) as nineteenth, -- 19日
    twentieth::varchar(1) as twentieth, -- 20日
    twenty_first::varchar(1) as twenty_first, -- 21日
    twenty_second::varchar(1) as twenty_second, -- 22日
    twenty_third::varchar(1) as twenty_third, -- 23日
    twenty_fourth::varchar(1) as twenty_fourth, -- 24日
    twenty_fifth::varchar(1) as twenty_fifth, -- 25日
    twenty_sixth::varchar(1) as twenty_sixth, -- 26日
    twenty_seventh::varchar(1) as twenty_seventh, -- 27日
    twenty_eighth::varchar(1) as twenty_eighth, -- 28日
    twenty_ninth::varchar(1) as twenty_ninth, -- 29日
    thirtieth::varchar(1) as thirtieth, -- 30日
    thirty_first::varchar(1) as thirty_first, -- 31日
    enabled_flag::varchar(1) as enabled_flag, -- 有効フラグ
    supplier_applicant_id::varchar(15) as supplier_applicant_id, -- 仕入先申請者ID
    fnd_user_name::varchar(30) as fnd_user_name, -- 代表者ユーザー名
    sha2('employee_number', 256) as employee_number, -- 代表者従業員番号
    employee_name::varchar(10) as employee_name, -- 代表者従業員名
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
    org_id::varchar(15) as org_id, -- 営業単位ID
    ldts -- B層取込日時
  from {{source('manufacturing_db_public', 'raw_stg_calendar_master')}}
)
select * from stg_calendar_master_maps_view