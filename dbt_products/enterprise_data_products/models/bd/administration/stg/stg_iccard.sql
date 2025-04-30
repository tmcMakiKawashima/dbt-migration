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
        employee_cd, -- 従業員・社外者コード
        prnno, -- 発行回数
        pubymd, -- 発行日
        endymd, -- 有効期限（マデ）
        location, -- ロケーション
        blackflg, -- ブラックフラグ
        wprnno, -- 最新ホワイト回数
        bprnno, -- 最新ブラック回数
        ldts -- B層取込日時
    from {{ ref('substr_ktrla0bkzz0kh20001') }}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{ ref('substr_ktrla0bkzz0kh20001') }})
    {% endif %}
)
select *  from stg_iccard
