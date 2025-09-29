{{
  config(
    materialized='table'
  )
}}
-- 処理レスポンスを考慮しtable実装
select
  tmp2.syasyu, -- 車種コード
  tmp2.siyoubui, -- 使用部位(重複対象) 
  tmp2.kohin as jyufku_kohin, -- 品番／BLKコード(重複対象)
  tmp2.jyufuku_kaisou, -- 重複階層
  tmp2.shusiyoubui, -- 主側使用部位
  tmp2.torokujunk as torokujunk_15com, -- 登録生認順カラ(15コメントとして)
  tmp2.torokujunm as torokujunm_15com, -- 登録生認順マデ(15コメントとして)
  tmp2.add_hinban, -- 重複の下の重複品番
  tmp2.tyohuku, -- 重複記載
  tmp1.oyahin, -- 親品番
  tmp1.kohin, -- 品番／BLKコード
  tmp1.gc, -- GC
  tmp1.kosu, -- 使用個数
  tmp1.sentaku, -- 選択符号
  tmp1.torokujunk, -- 登録／生認順カラ
  tmp1.torokujunm, -- 登録／生認順マデ
  tmp1.target, -- ターゲット
  tmp1.torokujun, -- 登録／生認順
  tmp1.seppenno, -- 設変No.
  tmp1.maxmttime, -- MAXMTTIME
  tmp1.mttime, -- MTTIME
  cast(lpad(row_number() over (partition by tmp2.syasyu, 
  tmp2.siyoubui order by concat(tmp1.kohin,tmp1.gc)), 4, '0') as varchar) 
  as id -- ID
from {{ref('tmp02_dm_kousei_jyufukublktenkai')}} as tmp2
left join {{ref('tmp01_dm_kousei_jyufukublktenkai')}} as tmp1
on (
    tmp2.syasyu = tmp1.syasyu
and tmp2.shusiyoubui = tmp1.siyoubui
)