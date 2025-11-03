{{
      config (
            materialized = 'incremental',
            unique_key = ['r_prod_month','r_dist_code', 'r_shiyos','r_katashiki','r_pkg_code','r_sfx_code'],
            incremental_strategy = 'merge',
            pre_hook="
                  {% if is_incremental() %}
                        delete from {{this}}
                        where (r_prod_month, r_dist_code, r_shiyos, r_katashiki, r_pkg_code, r_sfx_code) in (select r_prod_month, r_dist_code, r_shiyos, r_katashiki, r_pkg_code, r_sfx_code
                        from {{ source('fivetran_database_oraclerds_orcl_jukyu_osamsp01sam201', 'raw_cam2130') }}
                        where _fivetran_deleted = 'true'
                        and _fivetran_synced >= (select max(ldts) from {{ this }}))
                  {% endif %}
            "
      )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_sfx_kihonjyoho_tbl_jyukyujyoho as (
      select
            r_prod_month::varchar(6) as r_prod_month,
            r_dist_code::varchar(5) as r_dist_code,
            r_shiyos::varchar(2) as r_shiyos,
            r_katashiki::varchar(20) as r_katashiki,
            r_pkg_code::varchar(1) as r_pkg_code,
            r_sfx_code::varchar(2) as r_sfx_code,
            r_validate_month_from::varchar(6) as r_validate_month_from,
            r_validate_month_to::varchar(6) as r_validate_month_to,
            r_sfx_name::varchar(25) as r_sfx_name,
            r_shashu::varchar(4) as r_shashu,
            r_katashiki_code::varchar(5) as r_katashiki_code,
            r_sd_model_cd::varchar(3) as r_sd_model_cd,
            r_sub_series_code::varchar(2) as r_sub_series_code,
            r_ctgcd::varchar(3) as r_ctgcd,
            r_spodr_refno::varchar(10) as r_spodr_refno,
            r_spodr_type::varchar(2) as r_spodr_type,
            r_attach_sheet::varchar(1) as r_attach_sheet,
            r_remarks::varchar(25) as r_remarks,
            r_psc_code::varchar(1) as r_psc_code,
            r_loading_area::varchar(1) as r_loading_area,
            r_exp_country::varchar(3) as r_exp_country,
            r_port_index::varchar(2) as r_port_index,
            r_customer_code::varchar(5) as r_customer_code,
            r_delv_port::varchar(5) as r_delv_port,
            r_fd_code::varchar(5) as r_fd_code,
            r_payment_term::varchar(2) as r_payment_term,
            r_payment_name::varchar(3) as r_payment_name,
            r_payment_currency::varchar(2) as r_payment_currency,
            r_set_count::varchar(1) as r_set_count,
            r_conkata::varchar(20) as r_conkata,
            r_model_year::varchar(1) as r_model_year,
            r_aozuno::varchar(10) as r_aozuno,
            r_aozu_keta::varchar(3) as r_aozu_keta,
            r_aozu_kigo::varchar(2) as r_aozu_kigo,
            r_aozu_flg::varchar(1) as r_aozu_flg,
            r_ref_prod_month::varchar(6) as r_ref_prod_month,
            r_ref_dist_code::varchar(5) as r_ref_dist_code,
            r_ref_shiyos::varchar(2) as r_ref_shiyos,
            r_ref_katashiki::varchar(20) as r_ref_katashiki,
            r_ref_pkg_code::varchar(1) as r_ref_pkg_code,
            r_ref_suffix_no::varchar(2) as r_ref_suffix_no,
            r_ref_katashiki_code::varchar(5) as r_ref_katashiki_code,
            r_spc_chk_month::varchar(6) as r_spc_chk_month,
            r_spc_chk_result::varchar(3) as r_spc_chk_result,
            r_result_prod_month::varchar(1) as r_result_prod_month,
            r_result_dist_code::varchar(1) as r_result_dist_code,
            r_result_k_code::varchar(1) as r_result_k_code,
            r_result_katashiki::varchar(1) as r_result_katashiki,
            r_result_pkg_cd::varchar(1) as r_result_pkg_cd,
            r_result_sfx_code::varchar(1) as r_result_sfx_code,
            r_result_ld_area::varchar(1) as r_result_ld_area,
            r_result_shiyos::varchar(1) as r_result_shiyos,
            r_result_psc::varchar(1) as r_result_psc,
            r_result_port_index::varchar(1) as r_result_port_index,
            r_result_custmer_code::varchar(1) as r_result_custmer_code,
            r_result_delv_port::varchar(1) as r_result_delv_port,
            r_result_fd_code::varchar(1) as r_result_fd_code,
            r_result_pay_term::varchar(1) as r_result_pay_term,
            r_result_pay_name::varchar(1) as r_result_pay_name,
            r_result_pay_currency::varchar(1) as r_result_pay_currency,
            r_result_exp_country::varchar(1) as r_result_exp_country,
            r_result_cms_currency::varchar(1) as r_result_cms_currency,
            r_result_cms_price::varchar(1) as r_result_cms_price,
            r_result_attach_sheet::varchar(1) as r_result_attach_sheet,
            r_result_spodr_refno::varchar(1) as r_result_spodr_refno,
            r_result_fleet::varchar(1) as r_result_fleet,
            r_result_set_count::varchar(1) as r_result_set_count,
            r_result_model_year::varchar(1) as r_result_model_year,
            r_update_time::timestamp_ntz(9) as r_update_time,
            create_user::varchar(15) as create_user,
            create_date::timestamp_ntz(9) as create_date,
            update_user::varchar(15) as update_user,
            update_date::timestamp_ntz(9) as update_date,
            _fivetran_synced::timestamp_ntz(9) as ldts
      from 
            {{source('fivetran_database_oraclerds_orcl_jukyu_osamsp01sam201', 'raw_cam2130')}}
      where
            _fivetran_deleted = 'false'

      {% if is_incremental() %}
            and _fivetran_synced > (select max(ldts) from {{ this }})
      {% endif %}
)
select * from stg_sfx_kihonjyoho_tbl_jyukyujyoho