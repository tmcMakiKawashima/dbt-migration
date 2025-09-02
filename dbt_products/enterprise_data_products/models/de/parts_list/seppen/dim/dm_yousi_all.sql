{{ 
  config(
    materialized='incremental',
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

with yousi_all as (
  select
    seppenno, -- 設変№
    jun, -- 順
    eciyousijp, -- 要旨日本語
    eciyousien -- 要旨英語
  from {{ ref('stg_eci_yousi') }}
)
select 
  yousi_all.*,
  current_timestamp()::timestamp_ntz(9) as ldts -- 最終更新日時
from yousi_all