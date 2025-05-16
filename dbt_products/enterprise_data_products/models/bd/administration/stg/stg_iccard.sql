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
with stg_iccard as (
    select
        empcd::varchar(7) as employee_cd, -- 従業員・社外者コード
        prnno::varchar(1) as prnno, -- 発行回数
        pubymd::varchar(8) as pubymd, -- 発行日
        endymd::varchar(8) as endymd, -- 有効期限（マデ）
        location::varchar(4) as location, -- ロケーション
        blackflg::varchar(1) as blackflg, -- ブラックフラグ
        wprnno::varchar(1) as wprnno, -- 最新ホワイト回数
        bprnno::varchar(1) as bprnno, -- 最新ブラック回数
        ldts::timestamp_ntz as ldts, -- B層取込日時
        row_number() over(partition by employee_cd
                       order by ldts desc, line_number desc) as aggkey
    from {{ ref('substr_ktrla0bkzz0kh20001') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{ ref('substr_ktrla0bkzz0kh20001') }})
    {% endif %}
)
select * exclude(aggkey) from stg_iccard where aggkey = 1
