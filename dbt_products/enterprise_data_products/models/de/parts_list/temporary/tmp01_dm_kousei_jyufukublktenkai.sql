{{
  config(
    materialized = 'table'
  )
}}
-- 処理レスポンスを考慮しtable実装
select
  ks.*,
  tmp.* exclude(syasyu)
from {{source('parts_list_db_sms', 'raw_tmp_junkanri_blktenkai')}} as tmp
left join {{ref('tmp_junkanri_jyufukublktenkai_eph')}} as zt
on (
    tmp.syasyu = zt.syasyu
and tmp.target = 'KOUSEI'
and tmp.maxmttime > zt.maxmttime
)
inner join {{source('parts_list_db_sms', 'raw_dm_kousei_blktenkai')}} as ks
on (
    tmp.syasyu = ks.syasyu
)