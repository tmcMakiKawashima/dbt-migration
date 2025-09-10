-- 再帰cteを使ってチェーンを辿って1行にまとめる
with recursive chain_start as (
  -- スタートとなる行（他のendと繋がっていない）
  select
    syasu,
    jyufuku_siyoubui,
    lv,
    oyahin,
    kohin,
    case
      when jyufuku_siyoubui = aite_siyoubi
      then 3
      else 0
    end as jyufuku_flg,aite_siyoubi,
    torokujunk as start_date,
    torokujunm as end_date
    from tmp05_dm_kousei_jyufukublktenkai a
    where not exists (
      select 1
      from tmp05_dm_kousei_jyufukublktenkai b
      where a.torokujunk = b.torokujunm
        and a.syasu = b.syasu
        and a.jyufuku_siyoubui = b.jyufuku_siyoubui
        and a.lv = b.lv
        and a.oyahin = b.oyahin
        and a.kohin = b.kohin
    )
    union all
    -- チェーンを辿って末尾を伸ばしていく
    select
      a.syasu,
      a.jyufuku_siyoubui,
      a.lv,
      a.oyahin,
      a.kohin,
      case when a.jyufuku_siyoubui = a.aite_siyoubi then 3
      else 0 end as jyufuku_flg,
      a.aite_siyoubi,
      b.start_date,
      a.torokujunm as end_date
    from tmp05_dm_kousei_jyufukublktenkai a
    join chain_start b
      on a.torokujunk = b.end_date
     and a.syasu = b.syasu
     and a.jyufuku_siyoubui = b.jyufuku_siyoubui
     and a.lv = b.lv
     and a.oyahin = b.oyahin
     and a.kohin = b.kohin
)
-- 最終結果：チェーンのスタートから末尾まで
select
  syasu,
  jyufuku_siyoubui,
  lv,
  oyahin,
  kohin,
  start_date,
  jyufuku_flg,
  aite_siyoubi,
  max(end_date) as end_date
from chain_start
group by
  syasu,
  jyufuku_siyoubui,
  lv,
  oyahin,
  kohin,
  jyufuku_flg,
  start_date