{{
  config(
    materialized = 'table'
  )
}}
-- 処理レスポンスを考慮しtable実装
with tmp04_dm_kousei_jyufukublktenkai as (
  select
    syasyu, -- 車種コード
    siyoubui, -- 使用部位
    kumitate, -- 組立番号
    bui, -- 部位
    shusiyoubui, -- 主側使用部位
    vari, -- バリエーション
    oyahin, -- 親品番
    lv, -- レベル
    kouseijyun, -- 構成順
    gc, -- GC
    kohin, -- 品番／BLKコード
    tyohuku, -- 重複記載
    torokujunk, -- 登録／生認順カラ
    torokujunm, -- 登録／生認順マデ
    target, -- ターゲット
    torokujun, -- 登録／生認順
    seppenno, -- 設変No.
    maxmttime, -- MAXMTTIME
    mttime -- MTTIME
  from {{ref('tmp04_dm_kousei_jyufukublktenkai')}}
), dm_kousei_blktenkai as (
  select
    syasyu, -- 車種コード
    siyoubui, -- 使用部位
    oyahin, -- 親品番
    kohin, -- 品番／BLKコード
    motosiyoubui, -- 元使用部位
    kohinmei, -- 品名／BLKコード名称
    kosu, -- 使用個数
    sentaku, -- 選択符号
    seppennok, -- 設変No.カラ
    seppennom, -- 設変No.マデ
    torokutimek, -- LOAD TIMEカラ
    torokutimem -- LOAD TIMEマデ
  from {{ref('dm_kousei_blktenkai')}}
)
select
  zt.syasyu, -- 車種コード
  zt.siyoubui, -- 使用部位
  zt.kumitate, -- 組立番号
  zt.bui, -- 部位
  ks.motosiyoubui, -- 元使用部位
  zt.shusiyoubui, -- 主側使用部位
  zt.vari, -- バリエーション
  zt.oyahin, -- 親品番
  zt.lv, -- レベル
  zt.kouseijyun, -- 構成順
  zt.gc, -- GC
  zt.kohin, -- 品番／BLKコード
  ks.kohinmei, -- 品名／BLKコード名称
  ks.kosu, -- 使用個数
  ks.sentaku, -- 選択符号
  zt.tyohuku, -- 重複記載
  '1' as tyohuku_flg, -- 重複FLG
  zt.torokujunk, -- 登録／生認順カラ
  zt.torokujunm, -- 登録／生認順マデ
  ks.seppennok, -- 設変No.カラ
  ks.seppennom, -- 設変No.マデ
  ks.torokutimek, -- LOAD TIMEカラ
  ks.torokutimem, -- LOAD TIMEマデ
  zt.target, -- ターゲット
  zt.torokujun, -- 登録／生認順
  zt.seppenno, -- 設変No.
  zt.maxmttime, -- MAXMTTIME
  zt.mttime -- MTTIME
from tmp04_dm_kousei_jyufukublktenkai as zt
left join dm_kousei_blktenkai as ks
on (
    zt.syasyu = ks.syasyu
and zt.shusiyoubui = ks.siyoubui
and zt.oyahin = ks.oyahin
and zt.kohin = ks.kohin
)