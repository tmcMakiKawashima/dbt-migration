{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_kessairoute') %}

with stg_kessairoute_maps_view as (
  select
    decision_route_id::varchar(15) as decision_route_id, -- 決裁ルート_ID
    arrangement_serial_no::varchar(6) as arrangement_serial_no, -- 手配連番
    order_cls::varchar(1) as order_cls, -- 発注区分
    gate_chk_rp_department_cd::varchar(5) as gate_chk_rp_department_cd, -- ゲートチェック担当部署コード
    sha2('gate_chk_emp_cd1', 256) as gate_chk_emp_cd1, -- ゲートチェック者従業員コード1
    gate_chk_decision_cls1::varchar(1) as gate_chk_decision_cls1, -- ゲートチェック決裁区分1
    gate_chk_decision_date1::varchar(14) as gate_chk_decision_date1, -- ゲートチェック決裁日1
    sha2('gate_chk_emp_cd2', 256) as gate_chk_emp_cd2, -- ゲートチェック者従業員コード2
    gate_chk_decision_cls2::varchar(1) as gate_chk_decision_cls2, -- ゲートチェック決裁区分2
    gate_chk_decision_date2::varchar(14) as gate_chk_decision_date2, -- ゲートチェック決裁日2
    sha2('approver_emp_cd0', 256) as approver_emp_cd0, -- 決裁者従業員コード0
    decision_cls0::varchar(1) as decision_cls0, -- 決裁区分0
    decision_date0::varchar(14) as decision_date0, -- 決裁日0
    sha2('approver_emp_cd1', 256) as approver_emp_cd1, -- 決裁者従業員コード1
    decision_cls1::varchar(1) as decision_cls1, -- 決裁区分1
    decision_date1::varchar(14) as decision_date1, -- 決裁日1
    sha2('approver_emp_cd2', 256) as approver_emp_cd2, -- 決裁者従業員コード2
    decision_cls2::varchar(1) as decision_cls2, -- 決裁区分2
    decision_date2::varchar(14) as decision_date2, -- 決裁日2
    sha2('approver_emp_cd3', 256) as approver_emp_cd3, -- 決裁者従業員コード3
    decision_cls3::varchar(1) as decision_cls3, -- 決裁区分3
    decision_date3::varchar(14) as decision_date3, -- 決裁日3
    sha2('approver_emp_cd4', 256) as approver_emp_cd4, -- 決裁者従業員コード4
    decision_cls4::varchar(1) as decision_cls4, -- 決裁区分4
    decision_date4::varchar(14) as decision_date4, -- 決裁日4
    sha2('approver_emp_cd5', 256) as approver_emp_cd5, -- 決裁者従業員コード5
    decision_cls5::varchar(1) as decision_cls5, -- 決裁区分5
    decision_date5::varchar(14) as decision_date5, -- 決裁日5
    sha2('approver_emp_cd6', 256) as approver_emp_cd6, -- 決裁者従業員コード6
    decision_cls6::varchar(1) as decision_cls6, -- 決裁区分6
    decision_date6::varchar(14) as decision_date6, -- 決裁日6
    sha2('approver_emp_cd7', 256) as approver_emp_cd7, -- 決裁者従業員コード7
    decision_cls7::varchar(1) as decision_cls7, -- 決裁区分7
    decision_date7::varchar(14) as decision_date7, -- 決裁日7
    sha2('approver_emp_cd8', 256) as approver_emp_cd8, -- 決裁者従業員コード8
    decision_cls8::varchar(1) as decision_cls8, -- 決裁区分8
    decision_date8::varchar(14) as decision_date8, -- 決裁日8
    sha2('approver_emp_cd9', 256) as approver_emp_cd9, -- 決裁者従業員コード9
    decision_cls9::varchar(1) as decision_cls9, -- 決裁区分9
    decision_date9::varchar(14) as decision_date9, -- 決裁日9
    sha2('approver_emp_cd10', 256) as approver_emp_cd10, -- 決裁者従業員コード10
    decision_cls10::varchar(1) as decision_cls10, -- 決裁区分10
    decision_date10::varchar(14) as decision_date10, -- 決裁日10
    sha2('approver_emp_cd11', 256) as approver_emp_cd11, -- 決裁者従業員コード11
    decision_cls11::varchar(1) as decision_cls11, -- 決裁区分11
    decision_date11::varchar(14) as decision_date11, -- 決裁日11
    sha2('approver_emp_cd12', 256) as approver_emp_cd12, -- 決裁者従業員コード12
    decision_cls12::varchar(1) as decision_cls12, -- 決裁区分12
    decision_date12::varchar(14) as decision_date12, -- 決裁日12
    approver_charge_cd13::varchar(7) as approver_charge_cd13, -- 決裁担当コード13
    decision_cls13::varchar(1) as decision_cls13, -- 決裁区分13
    decision_date13::varchar(14) as decision_date13, -- 決裁日13
    sha2('approver_emp_cd13', 256) as approver_emp_cd13, -- 決裁者従業員コード13
    approver_charge_cd14::varchar(7) as approver_charge_cd14, -- 決裁担当コード14
    decision_cls14::varchar(1) as decision_cls14, -- 決裁区分14
    decision_date14::varchar(14) as decision_date14, -- 決裁日14
    sha2('approver_emp_cd14', 256) as approver_emp_cd14, -- 決裁者従業員コード14
    decision_type::varchar(1) as decision_type, -- 決裁種別
    dismissal_cls::varchar(1) as dismissal_cls, -- 却下区分
    decision_situation_cls::varchar(1) as decision_situation_cls, -- 決裁状況区分
    sha2('possessor_emp_cd', 256) as possessor_emp_cd, -- 所持者従業員コード
    sha2('req_emp_code', 256) as req_emp_code, -- 依頼者従業員コード
    req_date::varchar(14) as req_date, -- 依頼年月日
    sha2('kanban_odr_appr_emp_cd', 256) as kanban_odr_appr_emp_cd, -- かんばん発注決裁者従業員コード
    kanban_odr_appr_decision_cls::varchar(1) as kanban_odr_appr_decision_cls, -- かんばん発注決裁区分
    kanban_odr_appr_decision_dt::varchar(14) as kanban_odr_appr_decision_dt, -- かんばん発注決裁日
    abolishment_flag::varchar(1) as abolishment_flag, -- 廃止フラグ
    object_version_number::varchar(9) as object_version_number, -- Object Version Number
    created_by::varchar(15) as created_by, -- 作成者
    created_user_name::varchar(30) as created_user_name, -- 作成者ユーザー名
    creation_date::varchar(14) as creation_date, -- 作成日時
    last_updated_by::varchar(15) as last_updated_by, -- 最終更新者
    last_updated_user_name::varchar(30) as last_updated_user_name, -- 最終更新者ユーザー名
    last_update_date::varchar(14) as last_update_date, -- 最終更新日時
    last_update_login::varchar(15) as last_update_login, -- 最終更新ログイン
    last_upd_login_user_name::varchar(30) as last_upd_login_user_name, -- 最終更新ログインユーザー名
    request_id::varchar(15) as request_id, -- 要求ID
    program_application_id::varchar(15) as program_application_id, -- コンカレント・プログラム・アプリケーションID
    program_id::varchar(15) as program_id, -- コンカレント・プログラムID
    program_update_date::varchar(14) as program_update_date, -- プログラム更新日時
    org_id::varchar(15) as org_id, -- 営業単位ID
    "ldts" -- B層取込日時
  from {{ source_table.database }}.{{ source_table.schema }}."{{ source_table.name | lower }}"
)

select * from stg_kessairoute_maps_view