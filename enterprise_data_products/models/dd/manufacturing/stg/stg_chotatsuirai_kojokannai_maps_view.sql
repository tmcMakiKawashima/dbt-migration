{{ config(
      materialized='view'
   )
}}

with stg_chotatsuirai_kojokannai_maps_view as (
  select
    factory_procurement_rqe_id::varchar(15) as factory_procurement_rqe_id, -- 工場間・工場内調達依頼ID
    rqe_srl_number::varchar(5) as rqe_srl_number, -- 依頼番号
    rqe_srl_number_details::varchar(2) as rqe_srl_number_details, -- 依頼番号枝番
    rqe_to_wh_code::varchar(2) as rqe_to_wh_code, -- 依頼先倉庫コード
    rqe_form_wh_code::varchar(2) as rqe_form_wh_code, -- 依頼元倉庫コード
    packing_weight::varchar(9) as packing_weight, -- 荷姿重量
    application_dttm::varchar(14) as application_dttm, -- 申請日時
    rqe_depart_code::varchar(5) as rqe_depart_code, -- 依頼部署コード
    class_leader_sx_name::varchar(10) as class_leader_sx_name, -- 組長・SX名
    sha2('requester_emp_code', 256) as requester_emp_code, -- 依頼者従業員コード
    phs::varchar(13) as phs, -- 携帯電話
    y_item_no_id::varchar(15) as y_item_no_id, -- Y品番ID
    y_item_no::varchar(10) as y_item_no, -- Y品番
    rqe_quantity::varchar(11) as rqe_quantity, -- 依頼数量
    gi_order::varchar(15) as gi_order, -- 出庫オーダー
    burden_depart_code::varchar(5) as burden_depart_code, -- 負担部署コード
    machine_number::varchar(8) as machine_number, -- 機番
    st_no::varchar(2) as st_no, -- ST-No
    exchange_item_cls::varchar(1) as exchange_item_cls, -- 交換品有無区分
    exchange_item_return_date::varchar(14) as exchange_item_return_date, -- 交換品返却予定日
    exchange_item_delay_reason::varchar(30) as exchange_item_delay_reason, -- 交換品返却遅延理由
    commissioning_sts_cls::varchar(1) as commissioning_sts_cls, -- 稼働状況区分
    commissioning_sts_mil_note::varchar(100) as commissioning_sts_mil_note, -- 稼働状況備考
    get_preferred_dttm::varchar(14) as get_preferred_dttm, -- 入手希望日時
    location_code::varchar(10) as location_code, -- 所番地
    post_no::varchar(3) as post_no, -- ポストNo
    reception_dttm::varchar(14) as reception_dttm, -- 受付日時
    emergency_contact_tel::varchar(13) as emergency_contact_tel, -- 緊急TEL連絡先TEL
    rqe_form_responsible_person::varchar(10) as rqe_form_responsible_person, -- 依頼元担当者ユーザー名
    rqe_to_responsible_person::varchar(10) as rqe_to_responsible_person, -- 依頼先担当者ユーザー名
    spec_confirma_result_cls::varchar(1) as spec_confirma_result_cls, -- スペック相違区分
    real_thing_spec::varchar(59) as real_thing_spec, -- 現物スペック
    rqe_depa_confirmor_user::varchar(10) as rqe_depa_confirmor_user, -- 依頼部署確認者ユーザー名
    ret_truck_cls::varchar(1) as ret_truck_cls, -- 定期便_便区分
    ret_departure_wh::varchar(2) as ret_departure_wh, -- 定期便_発倉庫
    ret_wh_departure_date::varchar(14) as ret_wh_departure_date, -- 定期便_倉庫発日時
    ret_wh_departure_truck::varchar(2) as ret_wh_departure_truck, -- 定期便_倉庫発便
    ret_arrival_wh::varchar(2) as ret_arrival_wh, -- 定期便_着倉庫
    ret_wh_arrival_dttm::varchar(14) as ret_wh_arrival_dttm, -- 定期便_倉庫着日時
    ret_wh_arrival_truck::varchar(2) as ret_wh_arrival_truck, -- 定期便_倉庫着便
    spt_transit_truck_cls::varchar(1) as spt_transit_truck_cls, -- 特別便+定期便_経由地宛便区分
    spt_arrival_plan_date::varchar(14) as spt_arrival_plan_date, -- 特別便_到着予定日時
    spt_transit_departure_wh::varchar(2) as spt_transit_departure_wh, -- 特別便+定期便_経由地宛発倉庫
    spt_transit_wh_departure_dt::varchar(14) as spt_transit_wh_departure_dt, -- 特別便+定期便_経由地宛倉庫発日時
    spt_transit_wh_departure_trk::varchar(2) as spt_transit_wh_departure_trk, -- 特別便+定期便_経由地宛倉庫発便
    spt_transit_arrival_wh::varchar(2) as spt_transit_arrival_wh, -- 特別便+定期便_経由地宛着倉庫
    spt_transit_wh_arrival_date::varchar(14) as spt_transit_wh_arrival_date, -- 特別便+定期便_経由地宛倉庫着日時
    spt_transit_wh_arrival_truck::varchar(2) as spt_transit_wh_arrival_truck, -- 特別便+定期便_経由地宛倉庫着便
    spt_goal_truck_cls::varchar(1) as spt_goal_truck_cls, -- 特別便+定期便_目的地宛便区分
    spt_goal_departure_wh::varchar(2) as spt_goal_departure_wh, -- 特別便+定期便_目的地宛発倉庫
    spt_goal_wh_departure_date::varchar(14) as spt_goal_wh_departure_date, -- 特別便+定期便_目的地宛倉庫発日時
    spt_goal_wh_departure_truck::varchar(2) as spt_goal_wh_departure_truck, -- 特別便+定期便_目的地宛倉庫発便
    spt_goal_arrival_wh::varchar(2) as spt_goal_arrival_wh, -- 特別便+定期便_目的地宛着倉庫
    spt_goal_wh_arrival_date::varchar(14) as spt_goal_wh_arrival_date, -- 特別便+定期便_目的地宛倉庫着日時
    spt_goal_wh_arrival_truck::varchar(2) as spt_goal_wh_arrival_truck, -- 特別便+定期便_目的地宛倉庫着便
    ca_arrangement_ca_wh_code::varchar(10) as ca_arrangement_ca_wh_code, -- CAへ手配連絡_CA倉庫
    ca_arrangement_truck_rqe_cls::varchar(1) as ca_arrangement_truck_rqe_cls, -- CAへ手配連絡_トラック依頼要否区分
    ca_arrangement_wh_code::varchar(10) as ca_arrangement_wh_code, -- CAへ手配連絡_倉庫
    ca_arrangement_notice_dttm::varchar(14) as ca_arrangement_notice_dttm, -- CAへ手配連絡_連絡日時
    contact_exisit_cls::varchar(1) as contact_exisit_cls, -- 入荷連絡_連絡要否区分
    note::varchar(50) as note, -- 備考
    approval_status::varchar(1) as approval_status, -- 承認ステータス
    lengths::varchar(7) as lengths, -- 長さ
    height::varchar(7) as height, -- 縦
    width::varchar(7) as width, -- 横
    cuts_per_minute::varchar(5) as cuts_per_minute, -- 切断数
    sheet_quantity::varchar(5) as sheet_quantity, -- シート数・本数
    subject::varchar(1) as subject, -- 科目
    rep_rqe_quantity::varchar(11) as rep_rqe_quantity, -- 振替依頼数量
    answer_quantity_new::varchar(11) as answer_quantity_new, -- 回答数量(新品)
    answer_quantity_used::varchar(11) as answer_quantity_used, -- 回答数量(中古)
    answer_quantity_utilize::varchar(11) as answer_quantity_utilize, -- 回答数量(活用品)
    organization_id::varchar(3) as organization_id, -- 在庫組織ID
    factory_cls::varchar(1) as factory_cls, -- 組織コード（工場区分）
    rqe_depa_spec_confi_user::varchar(10) as rqe_depa_spec_confi_user, -- 依頼部署スペック確認者ユーザー名
    arrive_fin_date::varchar(14) as arrive_fin_date, -- 入荷完了日
    gi_depart_code::varchar(5) as gi_depart_code, -- 出庫部署コード
    supplier_exisit::varchar(1) as supplier_exisit, -- 仕入先指定有無
    spec::varchar(59) as spec, -- スペック
    contact_tel_extension::varchar(13) as contact_tel_extension, -- 連絡先（内線）
    supplier_id::varchar(15) as supplier_id, -- 仕入先ID
    supplier_code::varchar(4) as supplier_code, -- 仕入先コード
    supplier_name::varchar(8) as supplier_name, -- 仕入先名
    mfg_maker_id::varchar(15) as mfg_maker_id, -- 製造メーカーID
    preferred_maker_code::varchar(4) as preferred_maker_code, -- 製造メーカーコード
    preferred_maker_name::varchar(8) as preferred_maker_name, -- 製造メーカー名
    unused_item_cls::varchar(1) as unused_item_cls, -- 未使用返却有無区分
    unused_item_return_date::varchar(14) as unused_item_return_date, -- 未使用返却期日
    spt_ret_cls::varchar(1) as spt_ret_cls, -- 特別便定期便区分
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
    location_code_not_iron_id::varchar(15) as location_code_not_iron_id, -- 所番地(鉄以外)ID
    ldts -- B層取込日時
  from {{source('manufacturing_db_public', 'raw_stg_chotatsuirai_kojokannai')}}
)
select * from stg_chotatsuirai_kojokannai_maps_view