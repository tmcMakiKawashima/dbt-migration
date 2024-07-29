{{ config(snowflake_warehouse='DBT_WH') }}

with
    temp20 as (select * from {{ ref('tmp20_dm_yohin_tmp_juhattyuuriage') }}),
    UM as (select * from {{ ref('stg_tbuserm') }})

select
    temp20.*
  , UM.KJUSRNM
  , UM.HANBAITEN
  , UM.KYOUHAN as check2_KYOUHAN -- nullチェック用
from temp20
    left outer join UM
        on temp20.KYOUHAN_ML = UM.KYOUHAN
        and temp20.USERCD_ML = UM.USRCOD
