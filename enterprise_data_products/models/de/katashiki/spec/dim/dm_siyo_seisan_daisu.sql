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
  select * from {{source('katashiki_db_spec','raw_tmp52_dm_siyo_seisan_daisu_test')}}
  {% raw %}
    --from {{ref('tmp52_dm_siyo_seisan_daisu')}}
  {% endraw %}
), t71 as (
  select * from {{source('katashiki_db_spec','raw_tmp71_dm_siyo_seisan_daisu_test')}}
  {% raw %}
    --from {{ref('tmp71_dm_siyo_seisan_daisu')}}
  {% endraw %}
)
select
    T52.*,
    current_timestamp::timestamp_ntz(9) as ldts -- 作成日時
from t52
union all
select
    T71.*,
    current_timestamp::timestamp_ntz(9) as ldts -- 作成日時
from t71