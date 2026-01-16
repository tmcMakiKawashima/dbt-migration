{{
  config(
    materialized = 'table'
  )
}}
-- 処理レスポンスを考慮しtable実装
with tmp05_dm_kousei_jyufukublktenkai as (
  select * from {{ref('tmp05_dm_kousei_jyufukublktenkai')}}
), tmp07_dm_kousei_jyufukublktenkai as (
  select * from {{ref('tmp07_dm_kousei_jyufukublktenkai')}}
)
select
  tmp.*,
  row_number() over (
    partition by tmp.syasyu,tmp.siyoubui 
    order by tmp.id
  )::varchar(6) as kouseijyun -- 構成順
from (
  select * from tmp05_dm_kousei_jyufukublktenkai
  union
  select * from tmp07_dm_kousei_jyufukublktenkai
) as tmp