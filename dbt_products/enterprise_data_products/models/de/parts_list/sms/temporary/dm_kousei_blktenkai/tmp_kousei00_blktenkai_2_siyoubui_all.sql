--再帰処理の為、with句内で結合
with recursive
  siyoubui_blk as (
-- 使用部位単位で関係するblkを求める
-- 使用部位の直下のblkを求める
    select distinct
      syasyu,
      siyoubui,
      siyoubui as blkoya,
      kohin as blkko,
      1 as blk_kaisou
    from {{ref('tmp_kousei00_blktenkai_1_blk')}} 
    where substr(siyoubui, 9, 1) = '*'
    and substr(kohin, 8, 1) = '-'
    union all
-- blkのblkがあるので再帰する
    select
      oy.syasyu,
      oy.siyoubui,
      oy.blkko as blkoya,
      sg.kohin as blkko,
      oy.blk_kaisou + 1 as blk_kaisou
    from siyoubui_blk as oy
-- blkのblkを求める
    inner join (
      select distinct
        syasyu,
        siyoubui,
        kohin
      from {{ref('tmp_kousei00_blktenkai_1_blk')}}
      where substr(siyoubui, 8, 1) = '-'
      and substr(kohin, 8, 1) = '-'
    ) as sg
    on sg.siyoubui = oy.blkko
    and sg.syasyu = oy.syasyu
  )
-- 使用部位本体を足す
select distinct
  syasyu,
  siyoubui,
  siyoubui as blkoya,
  siyoubui as blkko,
  0 as blk_kaisou
from {{ref('tmp_kousei00_blktenkai_1_blk')}}
where substr(siyoubui, 9, 1) = '*'
union all
select * from siyoubui_blk