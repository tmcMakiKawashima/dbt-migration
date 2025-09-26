{{
    config(
        materialized='table'
    )
}}
-- 処理レスポンスを考慮しtable実装
with recursive siyoubui_jyufuku as (
  -- 使用部位単位で関係するjyufukuを求める
  select
    kj1.syasyu, -- 車種コード
    kj1.siyoubui, -- 使用部位(重複対象)
    kj1.kohin, -- 品番／BLKコード(重複対象)
    1 as jyufuku_kaisou, -- 重複階層
    kj2.siyoubui as shusiyoubui, -- 重複相手先使用部位
    ksc.torokujunk, -- 登録生認順カラ(15コメントとして)
    ksc.torokujunm, -- 登録生認順マデ(15コメントとして)
    kj3.kohin as add_hinban, -- 重複の下の重複品番
    kj3.tyohuku, -- 重複の下の重複コメント
    ksc.com -- 構成コメント
  -- 重複コメントの使用部位を集める
  from (
    select distinct syasyu, siyoubui ,kohin, tyohuku, motosiyoubui, gc
    from {{ref('tmp01_dm_kousei_jyufukublktenkai')}}
    where tyohuku != ''
    ) as kj1 
    -- 対象のコメントの使用部位を集める
    left join {{ref('tmp01_dm_kousei_jyufukublktenkai')}} as kj2
      on (
          kj1.syasyu = kj2.syasyu
      and left(kj1.tyohuku, 4) = left(kj2.siyoubui, 4)
      and kj1.kohin = kj2.kohin
      )
    -- 対象の使用部位に15コメントがあるか確かめる
    inner join {{source('engineering_db_public', 'raw_stg_kouseicom')}} as ksc
      on (
          kj2.syasyu = ksc.syasyu
      and kj2.motosiyoubui = ksc.siyoubui
      and kj2.kohin = ksc.kohin
      and kj2.gc = ksc.gc
      and ksc.comkbn = '15'
      and ksc.jigyoutai = ''
      and ksc.com like '%' || left(kj1.siyoubui, 4) || '%'
      )
    left join (
      select distinct syasyu, siyoubui, kohin, tyohuku
      from {{ref('tmp01_dm_kousei_jyufukublktenkai')}}
      where tyohuku != ''
    ) as kj3
      -- 更に重複の下に重複がないか？求める
      on (
          kj2.syasyu = kj3.syasyu
      and kj2.siyoubui = kj3.siyoubui 
      )
    union all
    -- jyufukuのjyufukuがあるので再帰する
    select
      sj.syasyu, -- 車種コード
      sj.siyoubui, -- 使用部位(重複対象)
      sj.kohin, -- 品番／BLKコード(重複対象)
      sj.jyufuku_kaisou + 1 as jyufuku_kaisou, -- 重複階層
      kj2.siyoubui as shusiyoubui, -- 重複相手先使用部位
      ksc.torokujunk, -- 登録生認順カラ(15コメントとして)
      ksc.torokujunm, -- 登録生認順マデ(15コメントとして)
      kj3.kohin as add_hinban, -- 重複の下の重複品番
      kj3.tyohuku, -- 重複の下の重複コメント
      ksc.com -- 構成コメント
    from siyoubui_jyufuku as sj
    -- 対象のコメントの使用部位を集める
    inner join {{ref('tmp01_dm_kousei_jyufukublktenkai')}} as kj2
      on (
          sj.syasyu = kj2.syasyu
      and left(sj.tyohuku, 4) = left(kj2.siyoubui,4)
      and sj.add_hinban = kj2.kohin
      )
    -- 対象の使用部位に15コメントがあるか確かめる
    inner join {{source('engineering_db_public', 'raw_stg_kouseicom')}} as ksc
      on (
          kj2.syasyu = ksc.syasyu
      and kj2.motosiyoubui = ksc.siyoubui
      and kj2.kohin = ksc.kohin
      and kj2.gc = ksc.gc
      and ksc.comkbn = '15'
      and ksc.jigyoutai = ''
      and ksc.com like '%' || left(sj.shusiyoubui, 4) || '%'
      )
    left join (
      select distinct syasyu, siyoubui, kohin, tyohuku
      from {{ref('tmp01_dm_kousei_jyufukublktenkai')}}
      where tyohuku != ''
    ) as kj3
    -- 更に重複の下に重複がないか？求める
      on (
          kj2.syasyu = kj3.syasyu
      and kj2.siyoubui = kj3.siyoubui
      )
)
select * from siyoubui_jyufuku
union all
-- 最初の使用部位を足す
select distinct 
  syasyu, -- 車種コード
  siyoubui, -- 使用部位(重複対象)
  kohin, -- 品番／BLKコード(重複対象)
  0 as jyufuku_kaisou, -- 重複階層
  siyoubui as shusiyoubui, -- 重複相手先使用部位
  '' as torokujunk, -- 登録生認順カラ(15コメントとして)
  '' as torokujunm, -- 登録生認順マデ(15コメントとして)
  kohin as add_hinban, -- 重複の下の重複品番
  tyohuku, -- 重複の下の重複コメント
  '' as com -- 構成コメント
  from {{ref('tmp01_dm_kousei_jyufukublktenkai')}}
  where tyohuku != ''