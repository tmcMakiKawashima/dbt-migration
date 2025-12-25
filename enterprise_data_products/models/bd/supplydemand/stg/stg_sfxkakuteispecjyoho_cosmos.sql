{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    pre_hook = "
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
 }}
-- 洗い替えであるため、pre_hookで全件削除を行う。
with stg_sfxkakuteispecjyoho_cosmos as (
    select
        r_prod_month::varchar(6) as r_prod_month, -- 生産年月
        r_edno::varchar(6) as r_edno, -- ＥＤ№
        r_spec_keta::varchar(3) as r_spec_keta, -- SPEC桁
        r_spec_kigo::varchar(2) as r_spec_kigo, -- SPEC記号
        r_std_opt::varchar(3) as r_std_opt, -- STD/OPT区分
        r_cnty_rstr_mark::varchar(1) as r_cnty_rstr_mark, -- 国制約記号
        r_opt_mark::varchar(1) as r_opt_mark, -- オプションマーク
        r_free_entry::varchar(1) as r_free_entry, -- FREEエントリ区分
        r_spc_dtl_result::varchar(3) as r_spc_dtl_result, -- 仕様ﾁｪｯｸ詳細結果ﾌﾗｸﾞ
        create_user::varchar(15) as create_user, -- 作成ユーザコード
        create_date::timestamp_ntz(9) as create_date, -- 作成日付
        update_user::varchar(15) as update_user, -- 更新ユーザコード
        update_date::timestamp_ntz(9) as update_date, -- 更新日付
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_oracle_rds_osamsp01sam201', 'raw_cam2148') }}
    where _fivetran_deleted = 'false'
)
select * from stg_sfxkakuteispecjyoho_cosmos
