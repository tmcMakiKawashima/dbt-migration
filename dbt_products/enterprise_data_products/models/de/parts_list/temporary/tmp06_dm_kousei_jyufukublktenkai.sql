{{
  config(
    materialized = 'table'
  )
}}
-- 処理レスポンスを考慮しtable実装
-- 再帰処理の為、with句内で結合
with recursive chain_start as (
  select
    zt1.syasyu, -- 車種コード
    zt1.siyoubui, -- 使用部位
    zt1.shusiyoubui, -- 主側使用部位
    zt1.oyahin, -- 親品番
    zt1.lv, -- レベル
    zt1.kouseijyun, -- 構成順
    zt1.GC, -- GC
    zt1.kohin, -- 品番／BLKコード
    zt1.tyohuku, -- 重複記載
    case
      when zt1.siyoubui = zt1.shusiyoubui
      then '3'
      else '0'
    end as tyohuku_flg, -- 重複FLG
    zt1.torokujunk, -- 登録／生認順カラ
    zt1.torokujunm, -- 登録／生認順マデ
    zt1.kumitate, -- 組立番号
    zt1.bui, -- 部位
    zt1.vari, -- バリエーション
    zt1.target, -- ターゲット
    zt1.torokujun, -- 登録／生認順
    zt1.seppenno, -- 設変No.
    zt1.maxmttime, -- MAXMTTIME
    zt1.mttime, -- MTTIME
    1 as kaisou -- 階層
  from {{ref('tmp04_dm_kousei_jyufukublktenkai')}} as zt1
  where not exists (
    select 1
    from {{ref('tmp04_dm_kousei_jyufukublktenkai')}} as zt2
    where zt1.torokujunk = zt2.torokujunm
      and zt1.syasyu = zt2.syasyu
      and zt1.siyoubui = zt2.siyoubui
      and zt1.lv = zt2.lv
      and zt1.oyahin = zt2.oyahin
      and zt1.kohin = zt2.kohin
  )
  union all
  select
    zt.syasyu, -- 車種コード
    zt.siyoubui, -- 使用部位
    zt.shusiyoubui, -- 主側使用部位
    zt.oyahin, -- 親品番
    zt.lv, -- レベル
    zt.kouseijyun, -- 構成順
    zt.GC, -- GC
    zt.kohin, -- 品番／BLKコード
    zt.tyohuku, -- 重複記載
    case 
      when zt.siyoubui = zt.shusiyoubui 
      then '3'
      else '0'
    end, -- 重複FLG
    ch.torokujunk, -- 登録／生認順カラ
    zt.torokujunm, -- 登録／生認順マデ
    zt.kumitate, -- 組立番号
    zt.bui, -- 部位
    zt.vari, -- バリエーション
    zt.target, -- ターゲット
    zt.torokujun, -- 登録／生認順
    zt.seppenno, -- 設変No.
    zt.maxmttime, -- MAXMTTIME
    zt.mttime, -- MTTIME
    ch.kaisou + 1 as kaisou -- 階層
  from {{ref('tmp04_dm_kousei_jyufukublktenkai')}} as zt
  join chain_start ch
  on (
      zt.torokujunk = ch.torokujunm
  and zt.syasyu = ch.syasyu
  and zt.siyoubui = ch.siyoubui
  and zt.lv = ch.lv
  and zt.oyahin = ch.oyahin
  and zt.kohin = ch.kohin
  )
  where ch.kaisou < 99
)
select
  syasyu, -- 車種コード
  siyoubui, -- 使用部位
  shusiyoubui, -- 主側使用部位
  oyahin, -- 親品番
  lv, -- レベル
  kouseijyun, -- 構成順
  GC, -- GC
  kohin, -- 品番／BLKコード
  tyohuku, -- 重複記載
  tyohuku_flg, -- 重複FLG
  torokujunk, -- 登録／生認順カラ
  max(torokujunm) as torokujunm, -- 登録／生認順マデ
  kumitate, -- 組立番号
  bui, -- 部位
  vari, -- バリエーション
  target, -- ターゲット
  torokujun, -- 登録／生認順
  seppenno, -- 設変No.
  maxmttime, -- MAXMTTIME
  mttime -- MTTIME
from chain_start
group by
  syasyu,
  siyoubui,
  shusiyoubui,
  lv,
  kouseijyun,
  GC,
  oyahin,
  kohin,
  tyohuku,
  tyohuku_flg,
  torokujunk,
  kumitate,
  bui,
  vari,
  target,
  torokujun,
  seppenno,
  maxmttime,
  mttime