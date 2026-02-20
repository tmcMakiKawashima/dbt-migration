{{
  config(
    materialized = 'table'
  )
}}
-- 処理レスポンスを考慮しtable実装
-- 再帰処理の為、with句内で結合
with recursive siyoubui_jyufuku as (
  -- 使用部位単位で関係するjyufukuを求める
  select
    kj1.syasyu, -- 車種コード
    kj1.siyoubui, -- 使用部位
    kj1.kohin, -- 品番／BLKコード
    1 as jyufuku_kaisou, -- 重複階層
    kj2.siyoubui as shusiyoubui, -- 主側使用部位
    ksc.torokujunk, -- 登録／生認順カラ
    ksc.torokujunm, -- 登録／生認順マデ
    kj3.kohin as add_hinban, -- 重複の下の重複品番
    kj3.tyohuku, -- 重複記載
    ksc.com, -- 構成コメント
    array_construct(
      (
        kj1.syasyu || '|' ||
        kj1.siyoubui || '|' ||
        kj1.kohin || '|' ||
        left(kj2.siyoubui, 4)
      )::variant
    ) as node_key
  -- 重複コメントの使用部位を集める
  from 
    (
      select distinct
        syasyu,
        siyoubui,
        kohin,
        tyohuku,
        motosiyoubui,
        gc
      from {{ref('tmp01_dm_kousei_jyufukublktenkai')}}
      where tyohuku != ''
    ) as kj1
    -- 対象のコメントの使用部位を集める
    inner join {{ref('tmp01_dm_kousei_jyufukublktenkai')}} as kj2
    on (
        kj1.syasyu = kj2.syasyu
    and left(kj1.tyohuku, 4) = left(kj2.siyoubui, 4)
    and kj1.kohin = kj2.kohin
    )
    inner join {{ref('stg_kouseicom')}} as ksc
    on (
        kj2.syasyu = ksc.syasyu
    and kj2.motosiyoubui = ksc.siyoubui
    and kj2.kohin = ksc.kohin
    and kj2.gc = ksc.gc
    and ksc.comkbn = '15'
    and trim(ksc.jigyoutai) = ''
    and ksc.com like '%' || left(kj1.siyoubui, 4) || '%'
    )
    left join (
      select distinct
        syasyu,
        siyoubui,
        kohin,
        tyohuku
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
      sj.siyoubui, -- 使用部位
      sj.kohin, -- 品番／BLKコード
      sj.jyufuku_kaisou + 1, -- 重複階層
      kj2.siyoubui, -- 主側使用部位
      ksc.torokujunk, -- 登録／生認順カラ
      ksc.torokujunm, -- 登録生認順マデ
      kj3.kohin, -- 重複の下の重複品番
      kj3.tyohuku, -- 重複記載
      ksc.com, -- 構成コメント
      array_cat(
        sj.node_key,
        array_construct(
          (
            sj.syasyu || '|' ||
            sj.siyoubui || '|' ||
            sj.kohin || '|' ||
            left(kj2.siyoubui, 4)
          )::variant
        )
      )
    from siyoubui_jyufuku as sj
    -- 対象のコメントの使用部位を集める
    inner join {{ref('tmp01_dm_kousei_jyufukublktenkai')}} as kj2
    on (
        sj.syasyu = kj2.syasyu
    and left(sj.tyohuku, 4) = left(kj2.siyoubui,4)
    and sj.add_hinban = kj2.kohin
    )
    inner join {{ref('stg_kouseicom')}} as ksc
    on (
        kj2.syasyu = ksc.syasyu
    and kj2.motosiyoubui = ksc.siyoubui
    and kj2.kohin = ksc.kohin
    and kj2.gc = ksc.gc
    and ksc.comkbn = '15'
    and trim(ksc.jigyoutai) = ''
    and ksc.com like '%' || left(sj.shusiyoubui, 4) || '%'
    )
    left join (
      select distinct
        syasyu,
        siyoubui,
        kohin,
        tyohuku
      from {{ref('tmp01_dm_kousei_jyufukublktenkai')}}
      where tyohuku != ''
    ) as kj3
    -- 更に重複の下に重複がないか？求める
    on (
        kj2.syasyu = kj3.syasyu
    and kj2.siyoubui = kj3.siyoubui
    )
  where sj.jyufuku_kaisou < 99
    and not array_contains(
      (
        sj.syasyu || '|' ||
        sj.siyoubui || '|' ||
        sj.kohin || '|' ||
        left(kj2.siyoubui, 4)
      )::variant,
      sj.node_key
    )
),
tmp01_dm_kousei_jyufukublktenkai as (
select distinct 
  syasyu, -- 車種コード
  siyoubui, -- 使用部位
  kohin, -- 品番／BLKコード
  0 as jyufuku_kaisou, -- 重複階層
  siyoubui as shusiyoubui, -- 主側使用部位
  '' as torokujunk, -- 登録／生認順カラ
  '' as torokujunm, -- 登録／生認順マデ
  kohin as add_hinban, -- 重複の下の重複品番
  tyohuku, -- 重複記載
  '' as com -- 構成コメント
  from {{ref('tmp01_dm_kousei_jyufukublktenkai')}}
  where tyohuku != ''
)
select distinct * exclude(node_key) from siyoubui_jyufuku
union all
-- 最初の使用部位を足す
select * from tmp01_dm_kousei_jyufukublktenkai