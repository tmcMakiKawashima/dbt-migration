{{
  config(
    materialized='table'
  )
}}
-- 処理レスポンスを考慮しtable実装
with tmp as (
  select * from {{source('parts_list_db_sms', 'raw_tmp_junkanri_blktenkai')}}
), zt as (
  select * from {{ref('tmp_junkanri_jyufukublktenkai_eph')}}
), ks as (
  select * from {{source('parts_list_db_sms', 'raw_dm_kousei_blktenkai')}}
)
select
  ks.*,
  tmp.* exclude(syasyu)
from tmp
left join zt
on (
    tmp.syasyu = zt.syasyu
and tmp.target = 'KOUSEI'
and	tmp.maxmttime	> zt.maxmttime
)
inner join ks
on (
    tmp.syasyu = ks.syasyu
)