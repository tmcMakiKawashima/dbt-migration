with tmp as (
  select * from {{ source('parts_list_db_sms', 'raw_tmp_junkanri_blktenkai')}}
) zt as (
  select * from {{ source('parts_list_db', 'raw_tmp_junkanri_blktenkai')}}
) ks as (
  select * from {{ source('parts_list_db', 'raw_dm_kousei_blktenkai')}}
)
select
  ks.*,
  tmp.* exclude(syasyu)
from ks
inner join tmp
on (
    ks.syasyu = tmp.syasyu
)
left join zt
on (
    tmp.syasyu = zt.syasyu
and tmp.target = 'KOUSEI'
and	tmp.maxmttime	> zt.maxmttime
)