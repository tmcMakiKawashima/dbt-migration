{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    pre_hook=[
      "
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
      "
    ]
  )
}}
-- 洗い替え処理で常に最新断面のみとするためpre_hookで全件削除する処理を記載
with stg_twave_tel as (
    select
        emplid::varchar(7) as employee_cd, -- 従業員ID
        tk_szcd::varchar(5) as syozoku_cd, -- 所属コード
        tk_twave_naisen::varchar(25) as tk_twave_naisen, -- 内線番号
        tk_twave_gaisen::varchar(25) as tk_twave_gaisen, -- 外線番号
        tk_twave_fax::varchar(25) as tk_twave_fax, -- FAX番号
        ldts::timestamp_ntz as ldts, -- B層取込日時
        row_number() over(partition by employee_cd
                       order by ldts desc, line_number desc) as aggkey
    from {{ source('snowpipe_db_administration', 'raw_ktrla015zz0kh20081') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20081')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_twave_tel where aggkey = 1