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

with dm_siyo_daisu as (
    select
        syasyu,
        haisya_kt,
        max(r_sfx_code) as r_sfx_code,
        spec200,
        max(daisai200) as daisai200,
        sk_y,
        sk_m,
        sum(daisu) as daisu
    from
        {{ ref('dm_siyo_seisan_daisu') }}
    group by
        syasyu,
        haisya_kt,
        sk_y,
        sk_m,
        spec200
)
select 
  syasyu,
  haisya_kt,
  r_sfx_code,
  spec200,
  daisai200,
  sk_y,
  sk_m,
  daisu,
  current_timestamp()::timestamp_ntz(9) as ldts -- 最終更新日時
from dm_siyo_daisu