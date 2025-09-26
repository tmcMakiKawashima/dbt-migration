{{
    config(
        materialized='table'
    )
}}
-- 処理レスポンスを考慮しtable実装
with recursive dm_kousei_oya as (
  select
    tmp3.syasyu, -- 車種コード
    tmp3.siyoubui, -- 使用部位
    tmp3.shusiyoubui, -- 主側使用部位
    tmp3.add_hinban, -- 重複の下の重複品番
    tmp3.tyohuku, -- 重複記載
    tmp3.oyahin, -- 親品番
    tmp3.gc, -- GC
    tmp3.kohin, -- 品番／BLKコード
    tmp3.kosu, -- 使用個数
    tmp3.sentaku, -- 選択符号
    tmp3.torokujunk_15com, -- 登録生認順カラ(15コメントとして)
    tmp3.torokujunm_15com, -- 登録生認順マデ(15コメントとして)
    tmp3.torokujunk, -- 登録／生認順カラ
    tmp3.torokujunm, -- 登録／生認順マデ
    tmp3.target, -- ターゲット
    tmp3.torokujun, -- 登録／生認順
    tmp3.seppenno, -- 設変No.
    tmp3.maxmttime, -- MAXMTTIME
    tmp3.mttime, -- MTTIME
    1 as lv, -- レベル
    tmp3.id -- ID
    from {{ref('tmp03_dm_kousei_jyufukublktenkai')}} as tmp3
  where tmp3.siyoubui = tmp3.oyahin
  union all
  select 
    zt.syasyu,-- 車種コード
    zt.siyoubui, -- 使用部位(重複対象)
    zt.shusiyoubui, -- 主側使用部位
    zt.add_hinban, -- 重複の下の重複品番
    zt.tyohuku, -- 重複記載
    zt.oyahin, -- 親品番
    zt.gc, -- GC
    zt.kohin, -- 品番／BLKコード
    zt.kosu, -- 使用個数
    zt.sentaku, -- 選択符号
    zt.torokujunk_15com, -- 登録生認順カラ(15コメントとして)
    zt.torokujunm_15com, -- 登録生認順マデ(15コメントとして)
    case 
      when ks.torokujunk > zt.torokujunk 
      then ks.torokujunk
      else zt.torokujunk
    end as torokujunk, -- 登録／生認順カラ
    case
      when ks.torokujunm < zt.torokujunm
      then ks.torokujunm
      else zt.torokujunm
    end as torokujunm, -- 登録／生認順マデ
    zt.target, -- ターゲット
    zt.torokujun, -- 登録／生認順
    zt.seppenno, -- 設変No.
    zt.maxmttime, -- MAXMTTIME
    zt.mttime, -- MTTIME
    ks.lv + 1 as lv, -- レベル
    concat(ks.id, '.', zt.id) as id -- ID
  from dm_kousei_oya as ks
  inner join {{ref('tmp03_dm_kousei_jyufukublktenkai')}} as zt
    on(
        zt.oyahin   = ks.kohin
    and zt.siyoubui = ks.siyoubui
    and zt.syasyu   = ks.syasyu
    and not (zt.torokujunm <= ks.torokujunk 
         or ks.torokujunm <= zt.torokujunk)
    and ( zt.torokujunk_15com != ''
        and (ks.torokujunm_15com <= ks.torokujunk 
         or ks.torokujunm <= ks.torokujunk_15com))
    )
  where zt.shusiyoubui = ks.shusiyoubui
      or ks.kohin = ks.add_hinban
  ) 
select 
  ko.* exclude(add_hinban, torokujunk_15com, torokujunm_15com, id),
  row_number() over (partition by ko.syasyu,ko.siyoubui order by ko.id) as kouseijyun
from dm_kousei_oya as ko