{{ 
  config(
    materialized='incremental',
    unique_key = ['r_prod_month','r_edno'],
    incremental_strategy = 'append',
    transient = false,
    pre_hook = "
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
 }}

with stg_cam2146_jyukyujyoho as (
    select
        r_prod_month::varchar(6) as r_prod_month, -- 生産年月
        r_edno::varchar(6) as r_edno, -- ＥＤ№
        r_odr_inp_month::varchar(6) as r_odr_inp_month, -- オーダー受理年月（月度）
        r_tmc_odrno::varchar(8) as r_tmc_odrno, -- ＴＭＣ受付№
        r_dist_odrno::varchar(12) as r_dist_odrno, -- 現地オーダー№
        r_dist_code::varchar(5) as r_dist_code, -- 受注先コード
        r_dist_country_code::varchar(3) as r_dist_country_code, -- 受注国コード（受注先中３桁）
        r_shashu::varchar(4) as r_shashu, -- 車種コード
        r_shiyos::varchar(2) as r_shiyos, -- 仕様書№
        r_katashiki::varchar(20) as r_katashiki, -- 呼称型式
        r_katashiki_code::varchar(5) as r_katashiki_code, -- 型式コード
        r_sd_model_cd::varchar(3) as r_sd_model_cd, -- 需給車名コード
        r_sub_series_code::varchar(2) as r_sub_series_code, -- ATOMS車名
        r_ctgcd::varchar(3) as r_ctgcd, -- ビークルカテゴリ
        r_pkg_code::varchar(1) as r_pkg_code, -- 荷姿
        r_pkg_code2::varchar(1) as r_pkg_code2, -- 荷姿コード②（自走可否）
        r_sfx_code::varchar(2) as r_sfx_code, -- ＳＦＸ№
        r_spodr_refno::varchar(10) as r_spodr_refno, -- Special Order Ref№
        r_spodr_type::varchar(2) as r_spodr_type, -- Special Order タイプ
        r_attach_sheet::varchar(1) as r_attach_sheet, -- アタッチシート区分
        r_remarks::varchar(25) as r_remarks, -- 上流メモ（Remarks）
        r_psc_code::varchar(1) as r_psc_code, -- 工場コード（PSC）
        r_loading_area::varchar(1) as r_loading_area, -- 積地コード
        r_input_type::varchar(3) as r_input_type, -- 入力種別
        r_model_change::varchar(1) as r_model_change, -- 月内切替区分
        r_koku::varchar(1) as r_koku, -- 工区
        r_lot_code::varchar(5) as r_lot_code, -- ＬＯＴコード
        r_usa_alloc_flag::varchar(1) as r_usa_alloc_flag, -- ＵＳＡ配分外フラグ
        r_usa_spodr_flg::varchar(1) as r_usa_spodr_flg, -- （ＵＳＡ特設フラグ）
        r_usa_mup_flag::varchar(1) as r_usa_mup_flag, -- ＵＳＡ前出生産フラグ
        r_usa_regin::varchar(3) as r_usa_regin, -- ＵＳＡリージョン名称
        r_usa_port_code::varchar(2) as r_usa_port_code, -- ＵＳＡポートコード
        r_exp_country::varchar(3) as r_exp_country, -- 輸出国コード
        r_port_index::varchar(2) as r_port_index, -- 取引先属性Index
        r_custmer_code::varchar(5) as r_custmer_code, -- 決済先コード
        r_delv_port::varchar(5) as r_delv_port, -- 荷揚港コード
        r_fd_code::varchar(5) as r_fd_code, -- 最終仕向地コード（F/D）
        r_payment_term::varchar(2) as r_payment_term, -- 決済条件コード
        r_payment_name::varchar(3) as r_payment_name, -- 建値
        r_payment_currency::varchar(2) as r_payment_currency, -- 建値通貨
        r_cms_currency::varchar(2) as r_cms_currency, -- コミッション通貨
        r_cms_price::number(9,2) as r_cms_price, -- コミッション単価
        r_kesaino::varchar(10) as r_kesaino, -- 決済管理№
        r_settle_kbn::varchar(1) as r_settle_kbn, -- 決済区分
        r_settle_type_syu::varchar(1) as r_settle_type_syu, -- 決済種別－主
        r_settle_type_fuku::varchar(1) as r_settle_type_fuku, -- 決済種別－副
        r_fleet::varchar(1) as r_fleet, -- フリート区分
        r_set_count::varchar(1) as r_set_count, -- 統計用区分
        r_area_priorty::varchar(8) as r_area_priorty, -- Area Priority
        r_hozei_flg::varchar(1) as r_hozei_flg, -- 保税車フラグ
        r_conkata::varchar(20) as r_conkata, -- コントロール型式
        r_model_year::varchar(1) as r_model_year, -- 年式（Model Year）
        r_color_opt::varchar(1) as r_color_opt, -- カラーオプション（Spec250）
        r_aozuno::varchar(10) as r_aozuno, -- 青図№
        r_aozu_keta::varchar(3) as r_aozu_keta, -- 青図SPEC桁
        r_aozu_kigo::varchar(2) as r_aozu_kigo, -- 青図SPEC記号
        r_aozu_flg::varchar(1) as r_aozu_flg, -- 青図フラグ
        r_brand::varchar(1) as r_brand, -- ブランド
        r_spr_rank::varchar(1) as r_spr_rank, -- 船積重点ランク
        r_spr_shipping_date::varchar(8) as r_spr_shipping_date, -- 船重－指定年月日
        r_spr_prod_date::varchar(8) as r_spr_prod_date, -- 船重－生産年月日
        r_spr_arrv_date::varchar(8) as r_spr_arrv_date, -- 船重－到着年月日（ＵＳＡ）
        r_spodr_req_date::varchar(8) as r_spodr_req_date, -- 特設－船積希望日
        r_ref_dist_code::varchar(5) as r_ref_dist_code, -- Ref情報受注先コード
        r_ref_shiyos::varchar(2) as r_ref_shiyos, -- Ref情報仕様書№
        r_ref_katashiki::varchar(20) as r_ref_katashiki, -- Ref情報呼称型式
        r_ref_katashiki_code::varchar(5) as r_ref_katashiki_code, -- Ref情報型式コード
        r_ref_prod_month::varchar(6) as r_ref_prod_month, -- Ref情報生産年月
        r_ref_edno::varchar(6) as r_ref_edno, -- Ref情報ＥＤ№
        r_spc_chk_month::varchar(6) as r_spc_chk_month, -- 仕様チェック用年月
        r_spc_chk_result::varchar(3) as r_spc_chk_result, -- 仕様チェック結果
        r_result_prod_month::varchar(1) as r_result_prod_month, -- チェック結果生産年月
        r_result_dist_code::varchar(1) as r_result_dist_code, -- チェック結果受注先コード
        r_result_k_code::varchar(1) as r_result_k_code, -- チェック結果型式コード
        r_result_katashiki::varchar(1) as r_result_katashiki, -- チェック結果呼称型式
        r_result_pkg_cd::varchar(1) as r_result_pkg_cd, -- チェック結果荷姿
        r_result_sfx_code::varchar(1) as r_result_sfx_code, -- チェック結果ＳＦＸ№
        r_result_ld_area::varchar(1) as r_result_ld_area, -- チェック結果積地コード
        r_result_shiyos::varchar(1) as r_result_shiyos, -- チェック結果仕様書№
        r_result_psc::varchar(1) as r_result_psc, -- チェック結果工場コード（PSC）
        r_result_port_index::varchar(1) as r_result_port_index, -- チェック結果取引先属性Index
        r_result_custmer_code::varchar(1) as r_result_custmer_code, -- チェック結果決済先コード
        r_result_delv_port::varchar(1) as r_result_delv_port, -- チェック結果荷揚港コード
        r_result_fd_code::varchar(1) as r_result_fd_code, -- チェック結果最終仕向地コード
        r_result_pay_term::varchar(1) as r_result_pay_term, -- チェック結果決済条件コード
        r_result_pay_name::varchar(1) as r_result_pay_name, -- チェック結果建値
        r_result_pay_currency::varchar(1) as r_result_pay_currency, -- チェック結果建値通貨
        r_result_exp_country::varchar(1) as r_result_exp_country, -- チェック結果輸出国コード
        r_result_cms_currency::varchar(1) as r_result_cms_currency, -- チェック結果コミッション通貨
        r_result_cms_price::varchar(1) as r_result_cms_price, -- チェック結果コミッション単価
        r_result_attach_sheet::varchar(1) as r_result_attach_sheet, -- チェック結果アタッチシート区分
        r_result_spodr_refno::varchar(1) as r_result_spodr_refno, -- チェック結果Special Order Ref№
        r_result_fleet::varchar(1) as r_result_fleet, -- チェック結果フリート区分
        r_result_set_count::varchar(1) as r_result_set_count, -- チェック結果統計用区分
        r_result_model_year::varchar(1) as r_result_model_year, -- チェック結果年式（Model Year）
        r_confirm_ttl::number(38) as r_confirm_ttl, -- 確定台数合計
        r_swap_unit_ttl::number(38) as r_swap_unit_ttl, -- 巻替台数合計
        r_ship_unit_ttl_kd::number(38) as r_ship_unit_ttl_kd, -- ＫＤ船積台数合計
        r_shipping_complete_date_kd::varchar(8) as r_shipping_complete_date_kd, -- ＫＤ船積完了年月日
        r_shipping_complete_flg_kd::varchar(1) as r_shipping_complete_flg_kd, -- ＫＤ船積完了フラグ
        r_division_code::varchar(1) as r_division_code, -- 本部コード
        r_area_code::varchar(1) as r_area_code, -- 部（地域）コード
        r_atukai::varchar(1) as r_atukai, -- 取扱い区分：商社／直貿
        r_ed_amend_flg::varchar(1) as r_ed_amend_flg, -- ＥＤ修正未反映フラグ
        r_woc_flag::varchar(1) as r_woc_flag, -- ＷＯＣ未反映フラグ
        r_update_time::timestamp_ntz(9) as r_update_time, -- 更新日時
        create_user::varchar(15) as create_user, -- 作成ユーザコード
        create_date::timestamp_ntz(9) as create_date, -- 作成日付
        update_user::varchar(15) as update_user, -- 更新ユーザコード
        update_date::timestamp_ntz(9) as update_date, -- 更新日付
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_oracle_rds_osamsp01sam201', 'raw_cam2146') }}
    where _fivetran_deleted = 'false'
)
select * from stg_cam2146_jyukyujyoho
