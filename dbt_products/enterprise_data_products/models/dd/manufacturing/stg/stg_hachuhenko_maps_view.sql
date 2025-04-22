{{ config(
      materialized='view'
   )
}}

{% set source_table = source('manufacturing_db_public', 'raw_stg_hachuhenko') %}

with stg_hachuhenko_maps_view as (
  select
    odr_chg_id::varchar(15) as odr_chg_id, -- 発注変更ID
    chg_applicant_cls::varchar(1) as chg_applicant_cls, -- 変更申請区分
    chg_applicant_date::varchar(14) as chg_applicant_date, -- 変更申請年月日
    auto_manual_type::varchar(1) as auto_manual_type, -- 自動手動種別
    chg_applicant_type::varchar(1) as chg_applicant_type, -- 変更申請種別
    chg_applicant::varchar(1) as chg_applicant, -- 変更申請元
    chg_applicant_reason::varchar(60) as chg_applicant_reason, -- 変更申請理由
    chg_applicant_reason_list::varchar(10) as chg_applicant_reason_list, -- 変更申請理由_リスト
    emergency_reason::varchar(60) as emergency_reason, -- 緊急理由
    chg_applicant_quantity::varchar(11) as chg_applicant_quantity, -- 変更数量
    chg_delivery_date::varchar(14) as chg_delivery_date, -- 変更納期(年月日)
    chg_delivery_date_truck::varchar(2) as chg_delivery_date_truck, -- 変更納期(便)
    arrangement_serial_no::varchar(6) as arrangement_serial_no, -- 手配連番
    order_date::varchar(14) as order_date, -- 発注日
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    kanban_destination_no_sup::varchar(3) as kanban_destination_no_sup, -- かんばん行先No_調達拠点
    kanban_destination_no_proc::varchar(3) as kanban_destination_no_proc, -- かんばん行先No_統括拠点
    transmission_cls::varchar(1) as transmission_cls, -- 伝送区分
    procurement_cls::varchar(1) as procurement_cls, -- 調達区分
    delivery_date::varchar(14) as delivery_date, -- 納期
    delivery_date_truck::varchar(2) as delivery_date_truck, -- 納期便
    odr_can_date::varchar(14) as odr_can_date, -- 発注キャンセル年月日
    first_delivery_date::varchar(14) as first_delivery_date, -- 1回目納期
    first_delivery_date_truck::varchar(2) as first_delivery_date_truck, -- 1回目納期便
    second_delivery_date::varchar(14) as second_delivery_date, -- 2回目納期
    second_delivery_date_truck::varchar(2) as second_delivery_date_truck, -- 2回目納期便
    third_delivery_date::varchar(14) as third_delivery_date, -- 3回目納期
    third_delivery_date_truck::varchar(2) as third_delivery_date_truck, -- 3回目納期便
    delivery_date_chg_count::varchar(2) as delivery_date_chg_count, -- 納期変更回数
    wh_code::varchar(2) as wh_code, -- 倉庫コード
    item_classification_code::varchar(12) as item_classification_code, -- 品目分類コード
    y_item_no::varchar(10) as y_item_no, -- Y品番
    item_name::varchar(15) as item_name, -- 品名
    spec::varchar(59) as spec, -- スペック
    maker_code::varchar(4) as maker_code, -- メーカーコード
    order_quantity_summary::varchar(11) as order_quantity_summary, -- 発注数(サマリ)
    req_depart_code::varchar(5) as req_depart_code, -- 依頼部署コード
    dismissal_reason::varchar(60) as dismissal_reason, -- 却下理由
    supplier_depart_name::varchar(20) as supplier_depart_name, -- 仕入先部署名
    sup_cont_name_all_digits::varchar(10) as sup_cont_name_all_digits, -- 仕入先担当者名_全桁
    supplier_tel::varchar(13) as supplier_tel, -- 仕入先TEL
    decision_cls::varchar(1) as decision_cls, -- 決裁区分
    sha2('approver', 256) as approver, -- 決裁者
    decision_date::varchar(14) as decision_date, -- 決裁日
    odr_chg_rp_name::varchar(20) as odr_chg_rp_name, -- 発注変更_担当者名
    odr_chg_depart_code::varchar(5) as odr_chg_depart_code, -- 発注変更_部署コード
    sha2('odr_chg_emp_code', 256) as odr_chg_emp_code, -- 発注変更_従業員コード
    odr_chg_depart_name::varchar(20) as odr_chg_depart_name, -- 発注変更_部署名
    sha2('odr_chg_sup_fnd_user_id', 256) as odr_chg_sup_fnd_user_id, -- 発注変更_仕入先FNDユーザー
    odr_chg_sup_user_name::varchar(30) as odr_chg_sup_user_name, -- 発注変更_仕入先ユーザー名
    sha2('odr_chg_sup_employee_code', 256) as odr_chg_sup_employee_code, -- 発注変更_仕入先従業員番号
    odr_chg_sup_employee_name::varchar(10) as odr_chg_sup_employee_name, -- 発注変更_仕入先従業員名
    req_depart_roger::varchar(10) as req_depart_roger, -- 依頼部署了解者
    req_depart_roger_date::varchar(14) as req_depart_roger_date, -- 依頼部署了解年月日
    cost_existing::varchar(1) as cost_existing, -- 費用発生有無
    cost_existing_supplier::varchar(1) as cost_existing_supplier, -- 費用発生有無(仕入先入力)
    cost_existing_reason_sup::varchar(60) as cost_existing_reason_sup, -- 費用発生理由（仕入先入力）
    approver_tel::varchar(13) as approver_tel, -- 決裁者連絡先
    requester_tel_extention::varchar(13) as requester_tel_extention, -- 依頼者連絡先内線
    requester_tel_external::varchar(13) as requester_tel_external, -- 依頼者連絡先外線
    supplier_meeting_date::varchar(14) as supplier_meeting_date, -- 仕入先打合せ年月日
    add_cost_chg_yn::varchar(1) as add_cost_chg_yn, -- 追加費用発生時変更可否
    unodr_cls::varchar(1) as unodr_cls, -- 未発注区分
    req_tel::varchar(1) as req_tel, -- 依頼者連絡
    kanban_return_date::varchar(14) as kanban_return_date, -- かんばん返却日
    req_not_implement_reason::varchar(60) as req_not_implement_reason, -- 依頼者連絡未実施理由
    wh_on_hold_status::varchar(10) as wh_on_hold_status, -- 倉庫保留状況
    can_item_no_abolishment::varchar(1) as can_item_no_abolishment, -- キャンセル時品番廃止
    odr_rqe_confirm_datetime::varchar(14) as odr_rqe_confirm_datetime, -- 発注変更確定日時
    odr_delivery_date_chg_flg::varchar(1) as odr_delivery_date_chg_flg, -- 依頼納期変更フラグ
    emergency::varchar(1) as emergency, -- 緊急
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
    rep_pattern_before::varchar(1) as rep_pattern_before, -- 修理パターン_変更前
    rep_pattern::varchar(1) as rep_pattern, -- 修理パターン
    provisional_unit_price::varchar(8) as provisional_unit_price, -- 仮単価
    provision_amnt_reason_proc::varchar(100) as provision_amnt_reason_proc, -- 仮金額理由(調達)
    unit_price_decision_due_date::varchar(14) as unit_price_decision_due_date, -- 単価決定期限
    tl_gm_dismissal_reason::varchar(60) as tl_gm_dismissal_reason, -- TL/GM却下理由
    cost_existing_ans_date::varchar(14) as cost_existing_ans_date, -- 費用発生回答日
    cost_existing_ans_cnt::varchar(2) as cost_existing_ans_cnt, -- 回答回数
    approver_name::varchar(20) as approver_name, -- 決裁者名
    sha2('approver_fnd_user_id', 256) as approver_fnd_user_id, -- 決裁者_品番担当者
    approver_user_name::varchar(30) as approver_user_name, -- 決裁者_品番担当者ユーザー名
    sha2('approver_employee_code', 256) as approver_employee_code, -- 決裁者_品番担当者従業員番号
    approver_employee_name::varchar(10) as approver_employee_name, -- 決裁者_品番担当者従業員名
    credit_note_sup_on_remand::varchar(1) as credit_note_sup_on_remand, -- 赤伝仕入先差戻し中
    "ldts" -- B層取込日時
  from {{ source_table.database }}.{{ source_table.schema }}."{{ source_table.name | lower }}"
)

select * from stg_hachuhenko_maps_view