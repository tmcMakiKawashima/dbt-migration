{{
  config(
    materialized = 'table'
  )
}}
-- 処理レスポンスを考慮しtable実装
with tmp05_dm_kousei_jyufukublktenkai as (
  select * from {{ref('tmp05_dm_kousei_jyufukublktenkai')}}
), tmp07_dm_kousei_jyufukublktenkai as (
  select * from {{ref('tmp07_dm_kousei_jyufukublktenkai')}}
)
select
  tmp.syasyu, -- 車種コード
  tmp.siyoubui, -- 使用部位
  tmp.kumitate, -- 組立番号
  tmp.bui, -- 部位
  tmp.motosiyoubui, -- 元使用部位
  tmp.shusiyoubui, -- 主側使用部位
  tmp.vari, -- バリエーション
  tmp.oyahin, -- 親品番
  tmp.lv, -- レベル
  row_number() over (
    partition by tmp.syasyu,tmp.siyoubui 
    order by tmp.id
  ) as kouseijyun, -- 構成順
  tmp.gc, -- GC
  tmp.kohin, -- 品番／BLKコード
  tmp.kohinmei, -- 品名／BLKコード名称
  tmp.kosu, -- 使用個数
  tmp.sentaku, -- 選択符号
  tmp.tyohuku, -- 重複記載
  tmp.tyohuku_flg, -- 重複FLG
  tmp.torokujunk, -- 登録／生認順カラ
  tmp.torokujunm, -- 登録／生認順マデ
  tmp.seppennok, -- 設変No.カラ
  tmp.seppennom, -- 設変No.マデ
  tmp.torokutimek, -- LOAD TIMEカラ
  tmp.torokutimem, -- LOAD TIMEマデ
  tmp.target, -- ターゲット
  tmp.torokujun, -- 登録／生認順
  tmp.seppenno, -- 設変No.
  tmp.maxmttime, -- MAXMTTIME
  tmp.mttime -- MTTIME
from (
  select * from tmp05_dm_kousei_jyufukublktenkai
  union
  select * from tmp07_dm_kousei_jyufukublktenkai
) as tmp
