{{ 
  config(
    materialized='incremental',
    unique_key = ['seppenno','jun'],
    incremental_strategy = 'append',
    transient = false,
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
 }}
-- 洗い替えであるため、pre_hookで全件削除を行う。

with dm_yousi_all as (
    select
        seppenno::varchar(10) as seppenno, -- 設変№
        jun::varchar(3) as jun, -- 順
        eciyousijp::varchar(25) as eciyousijp, -- 要旨日本語
        eciyousien::varchar(50) as eciyousien, -- 要旨英語
        current_timestamp()::timestamp_ntz(9) as load_date -- 最終更新日時
    from {{ ref('stg_eci_yousi') }}
)
select * from dm_yousi_all
