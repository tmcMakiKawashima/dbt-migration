{{
    config(
        materialized='table'
    )
}}
with
  siyoubui_all as (
    select 
      syasyu, -- 車種コード
      siyoubui, -- 使用部位
      blkko -- blkko
    from {{ref('tmp_kousei00_blktenkai_2_siyoubui_all')}} 
  ),
  kousei as (
    select
      syasyu,-- 車種コード
      siyoubui, -- 使用部位
      mttime -- MT日時
    from {{ref('stg_kousei')}}
    where jigyoutai = '  ' 
    group by 
      syasyu,
      siyoubui,
      mttime
  ),
  kouseicom as (
    select
      syasyu, -- 車種コード
      siyoubui, -- 使用部位
      comkbn, -- コメント区分
      mttime -- MT日時
    from {{ref('stg_kouseicom')}}
    where jigyoutai = '  '
    group by
      syasyu,
      siyoubui,
      comkbn,
      mttime
  ),
  junkanri as (
    select
      syasyu,-- 車種コード
      target, -- ターゲット
      maxmttime -- maxmttime
    from {{ source('parts_list_db_sms', 'raw_tmp_junkanri_blktenkai') }}
  )
--構成側でメンテがあった使用部位を求める
select
  a.syasyu,
  a.siyoubui,
  max(b.mttime) as maxmttime,
  '0' as flg
from siyoubui_all a
inner join kousei b
  on substr(a.blkko,1,6) = substr(b.siyoubui,1,6)
  and a.syasyu = b.syasyu
left outer join junkanri c
  on a.syasyu = c.syasyu
  where (c.target = 'KOUSEI' or c.target is null)
  and (c.syasyu is null or( a.syasyu = c.syasyu and b.mttime > c.maxmttime))
  group by
    a.syasyu,
    a.siyoubui
union all
--コメント側でメンテがあった使用部位を求める
select
  d.syasyu,
  d.siyoubui,
  max(e.mttime) as maxmttime,
  '1' as flg
from siyoubui_all d
inner join kouseicom e
  on substr(d.blkko,1,6) = substr(e.siyoubui,1,6)
  and d.syasyu = e.syasyu
left outer join junkanri f
  on d.syasyu = f.syasyu
  where (f.target = 'KOUSEI' or f.target is null)
  and (f.syasyu is null or (d.syasyu = f.syasyu and e.mttime > f.maxmttime))
  and e.comkbn in ('11')
  group by
    d.syasyu,
    d.siyoubui