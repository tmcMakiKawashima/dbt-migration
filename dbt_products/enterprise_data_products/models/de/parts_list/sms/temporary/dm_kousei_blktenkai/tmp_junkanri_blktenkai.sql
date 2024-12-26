delete from tmp_junkanri_blktenkai a
inner join tmp_kousei03_blktenkai b
where
 a.syasyu = b.syasyu

insert into tmp_junkanri_blktenkai(syasyu,target,torokujun,seppenno,mttime)
select
 a.syasyu,
 'KOUSEI' as target,
 b.torokujun,
 a.seppenno,
 if(c.maxmttime < d.maxmttime, d.maxmttime, c.maxmttime)
 a.mttime
from tmp_kousei03_blktenkai a
,
(
 select
  syasyu
  max(if(torokujunm='999999999', torokujunk, torokujunm)) as torokujun,
 from tmp_kousei03_blktenkai
 group by
  syasyu
) b
,
(
 select
  syasyu,
  max(stg_kousei.mttime) as maxmttime
 from tmp_kousei03_blktenkai
 where
  trim(jigyoutai) = ''
 group by
  syasyu
) c
,
(
 select
  syasyu,
  max(stg_kouseicom.mttime) as maxmttime
 from tmp_kousei03_blktenkai
 where
  trim(jigyoutai) = '' and
  comkbn='11'
 group by
  syasyu
) d
where
 a.syasyu = b.syasyu and
 a.syasyu = c.syasyu and
 a.syasyu = d.syasyu
