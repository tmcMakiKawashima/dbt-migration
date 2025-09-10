with tmp3 as (
  select * from {{ref('tmp03_dm_kousei_jyufukublktenkai')}}
) recursive dm_kousei_oya as (
  select
    tmp3.syasyu, -- 車種コード
    tmp3.siyoubui, -- 使用部位(重複対象)
    tmp3.aite_siyoubui, -- 重複相手先使用部位
    tmp3.add_hinban, -- 重複の下の重複品番
    tmp3.oyahin, -- 親品番
    tmp3.gc, -- GC
    -- 確認中（この子品は重複対象？）
    tmp3.kohin, -- 品番／BLKコード(重複対象)
    tmp3.kosu, -- 使用個数
    tmp3.sentaku, -- 選択符号
    tmp3.torokujunk_15com, -- 登録生認順カラ(15コメントとして)
    tmp3.torokujunm_15com, -- 登録生認順マデ(15コメントとして)
    tmp3.com -- 構成コメント
    tmp3.torokujunk, -- 登録／生認順カラ
    tmp3.torokujunm, -- 登録／生認順マデ
    tmp3.target, -- ターゲット
    tmp3.torokujun, -- 登録／生認順
    tmp3.seppenno, -- 設変No.
    tmp3.maxmttime, -- MAXMTTIME
    tmp3.mttime, -- MTTIME
    1 as lv, -- レベル
    id -- ID
    from tmp3
  where jyufuku_siyoubui = oyahin
  union all
  select 
    sg.syasyu,-- 車種コード
    sg.siyoubui, -- 使用部位(重複対象)
    sg.aite_siyoubui, -- 重複相手先使用部位
    sg.add_hinban, -- 重複の下の重複品番
    sg.oyahin, -- 親品番
    sg.gc, -- GC
    -- 確認中（この子品は重複対象？）
    sg.kohin, -- 品番／BLKコード(重複対象)
    sg.kosu, -- 使用個数
    sg.sentaku, -- 選択符号
    sg.torokujunk_15com, -- 登録生認順カラ(15コメントとして)
    sg.torokujunm_15com, -- 登録生認順マデ(15コメントとして)
    sg.com, -- 構成コメント
    case 
      when oy.torokujunk > sg.torokujunk 
      then oy.torokujunk
      else sg.torokujunk
    end as torokujunk, -- 登録／生認順カラ
    case
      when oy.torokujunm < sg.torokujunm
      then oy.torokujunm
      else sg.torokujunm
    end as torokujunm, -- 登録／生認順マデ
    sg.target, -- ターゲット
    sg.torokujun, -- 登録／生認順
    sg.seppenno, -- 設変No.
    sg.maxmttime, -- MAXMTTIME
    sg.mttime, -- MTTIME
    oy.lv + 1 as lv, -- レベル
    concat(oy.id, '.', sg.id) as id -- ID
  from dm_kousei_oya as oy
  inner join tmp3 as sg
    on(
        sg.oyahin   = oy.kohin
    and sg.jyoufuku_siyoubui = oy.jyoufuku_siyoubui
    and sg.syasyu   = oy.syasyu
    and not (sg.torokujunm <= oy.torokujunk 
         or oy.torokujunm <= sg.torokujunk)
    and ( sg.torokujunk_15com != ''
        and (oy.torokujunm_15com <= oy.torokujunk 
         or oy.torokujunm <= oy.torokujunk_15com))
    )
  where sg.aite_siyoubui = oy.aite_siyoubui
      or oy.kohin = oy.add_hinban
  ) 
select 
  ko.* exclude(torokujunk_15com, torokujunm_15com),
  left(ko.siyoubui, 4) as kumitate,
  substr(ko.siyoubui, 5, 2) as bui,
  substr(ko.siyoubui, 7, 2) as vari,
  row_number() over (partition by ko.syasyu,ko.siyoubui order by ko.id) as kouseijyun,
from dm_kousei_oya as ko