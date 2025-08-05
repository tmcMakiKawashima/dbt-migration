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
with stg_mail as (
    select
        jcd::varchar(7) as employee_cd, -- 従業員コード
        hon_mail::varchar(60) as hon_mail, -- 本社メールアドレス
        gi_mail::varchar(256) as gi_mail, -- 技術メールアドレス
        ldts::timestamp_ntz as ldts, -- B層取込日時
        row_number() over(partition by employee_cd
                       order by ldts desc, line_number desc) as aggkey
    from {{ source('snowpipe_db_administration', 'raw_ktrla015zz0kh20072') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla015zz0kh20072')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_mail where aggkey = 1
