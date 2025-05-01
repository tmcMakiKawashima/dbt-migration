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

with yousi_all as (
  select * from {{ ref('stg_eci_yousi') }}
)
select 
  yousi_all.* exclude(mttime, ldts),
  current_timestamp()::timestamp_ntz(9) as ldts -- 最終更新日時
from yousi_all