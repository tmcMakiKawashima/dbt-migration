with
  siyoubui_target as (
    select
      syasyu, -- 車種コード
      siyoubui -- 使用部位
    from {{ref('tmp_kousei00_blktenkai_3_siyoubui_target')}}
  ),
  siyoubui_all as (
    select 
      syasyu, -- 車種コード
      siyoubui, -- 使用部位
      blkko -- blkko
    from {{ref('tmp_kousei00_blktenkai_2_siyoubui_all')}}
  ),
  kousei as (
    select
      syasyu, -- 車種コード
      siyoubui, -- 使用部位
      oyahin, -- 親使用部位／品番
      gc, -- GC
      kohin, -- 子品番／BLK
      kosu, -- 使用個数
      sentaku, -- 選択符号
      torokujunk, -- 登録／生認順カラ
      torokujunm, -- 登録／生認順マデ
      mttime, -- MT日時
      ldts -- B層取込日時
    from {{ref('stg_kousei')}}
    where jigyoutai = '  '
    group by 
      syasyu,
      siyoubui,
      oyahin,
      gc,
      kohin,
      kosu,
      sentaku,
      torokujunk,
      torokujunm,
      mttime,
      ldts
  )
--更新対象の使用部位が求まった為、blkまで考慮し構成まで求める
select distinct
    c.syasyu,
    b.siyoubui as siyoubui,
    c.siyoubui as motosiyoubui,
    c.oyahin, 
    c.gc,
    c.kohin,
    c.kosu,
    c.sentaku,
    c.torokujunk,
    c.torokujunm,
    c.mttime,
    c.ldts,
--gc含めた行idを振るため事前に求める項目
    case
      when c.gc is null or trim(c.gc) = '' then '0'
      else '1' 
    end as gc_fill
from siyoubui_target a
inner join siyoubui_all b
  on a.siyoubui = b.siyoubui
  and a.syasyu = b.syasyu
inner join kousei c
  on b.blkko = c.siyoubui
  and a.syasyu = c.syasyu