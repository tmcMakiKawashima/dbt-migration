with
  kousei as (
    select
      syasyu, -- 車種コード
      siyoubui, -- 使用部位
      kohin -- 子品番／BLK
    from {{ref('stg_kousei')}} 
    where jigyoutai = '  '
    group by
      syasyu,
      siyoubui,
      kohin
  ),
  target_syasyu as (
    select
      syasyu -- 車種コード
    from {{ref('tmp_target_syasyu')}} 
  )
select
  a.syasyu,
  a.siyoubui,
  a.kohin
from kousei a
inner join target_syasyu b
  on a.syasyu = b.syasyu