with t52 as (
  select * from {{ref('tmp52_dm_siyo_seisan_daisu')}}
), t60 as (
  select * from {{ref('tmp60_dm_siyo_seisan_daisu')}}
)
select
    t52.*,
    current_timestamp::timestamp_ntz(9) as ldts -- 作成日時
from t52
union all
select
    t60.*,
    current_timestamp::timestamp_ntz(9) as ldts -- 作成日時
from t60