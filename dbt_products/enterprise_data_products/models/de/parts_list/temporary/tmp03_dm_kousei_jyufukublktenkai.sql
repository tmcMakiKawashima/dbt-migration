{{
  config(
    materialized = 'table'
  )
}}
-- 処理レスポンスを考慮しtable実装
with tmp02_dm_kousei_jyufukublktenkai as (
select
  syasyu, -- 車種コード
  siyoubui, -- 使用部位(重複対象) 
  kohin as jyufku_kohin, -- 品番／BLKコード(重複対象)
  jyufuku_kaisou, -- 重複階層
  shusiyoubui, -- 主側使用部位
  torokujunk as torokujunk_15com, -- 登録生認順カラ(15コメントとして)
  torokujunm as torokujunm_15com, -- 登録生認順マデ(15コメントとして)
  add_hinban, -- 重複の下の重複品番
  tyohuku -- 重複記載
  from {{ref('tmp02_dm_kousei_jyufukublktenkai')}}
), tmp01_dm_kousei_jyufukublktenkai as (
select
  syasyu, -- 車種コード
  siyoubui, -- 使用部位(重複対象) 
  oyahin, -- 親品番
  kohin, -- 品番／BLKコード
  gc, -- GC
  kosu, -- 使用個数
  sentaku, -- 選択符号
  torokujunk, -- 登録／生認順カラ
  torokujunm, -- 登録／生認順マデ
  target, -- ターゲット
  torokujun, -- 登録／生認順
  seppenno, -- 設変No.
  maxmttime, -- MAXMTTIME
  mttime -- MTTIME
  from {{ref('tmp01_dm_kousei_jyufukublktenkai')}}
)
select
  tmp2.*,
  tmp1.* exclude(syasyu, siyoubui),
  cast(lpad(row_number() over (partition by tmp2.syasyu, 
  tmp2.siyoubui order by concat(tmp1.kohin, tmp1.gc)), 4, '0') as varchar) 
  as id -- ID
from tmp02_dm_kousei_jyufukublktenkai as tmp2
left join tmp01_dm_kousei_jyufukublktenkai as tmp1
on (
    tmp2.syasyu = tmp1.syasyu
and tmp2.shusiyoubui = tmp1.siyoubui
)