{{ 
  config(
    materialized='incremental',
    unique_key = ['employee_cd'],
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
with stg_iccard as (
    select
        substr(raw_data, 1, 7)::varchar(7) as employee_cd, -- 従業員・社外者コード
        substr(raw_data, 8, 1)::varchar(1) as prnno, -- 発行回数
        substr(raw_data, 9, 8)::varchar(8) as pubymd, -- 発行日
        substr(raw_data, 17, 8)::varchar(8) as endymd, -- 有効期限（マデ）
        substr(raw_data, 25, 4)::varchar(4) as location, -- ロケーション
        substr(raw_data, 29, 1)::varchar(1) as blackflg, -- ブラックフラグ
        substr(raw_data, 30, 1)::varchar(1) as wprnno, -- 最新ホワイト回数
        substr(raw_data, 31, 1)::varchar(1) as bprnno, -- 最新ブラック回数
        ldts::timestamp_ntz as ldts, -- B層取込日時
        row_number() over(partition by substr(raw_data, 1, 7)
                       order by ldts desc, line_number desc) as aggkey
    from {{ source('snowpipe_db_administration', 'raw_ktrla0bkzz0kh20001') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla0bkzz0kh20001')}})
    {% endif %}
)
select *  exclude(aggkey) from stg_iccard where aggkey = 1
