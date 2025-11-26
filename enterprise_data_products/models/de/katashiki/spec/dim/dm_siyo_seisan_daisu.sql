{{ 
  config(
    materialized = 'incremental',
    incremental_strategy = 'append',
    transient = false,
    pre_hook = "
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
 }}
 -- 洗い替えであるため、pre_hookで全件削除を行う。
with t52 as (
  select * from {{ref('tmp52_dm_siyo_seisan_daisu')}}
), t71 as (
  select * from {{ref('tmp71_dm_siyo_seisan_daisu')}}
)
select
    t52.*,
    current_timestamp::timestamp_ntz(9) as ldts -- 作成日時
from t52
union all
select
    t71.*,
    current_timestamp::timestamp_ntz(9) as ldts -- 作成日時
from t71