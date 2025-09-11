{{config(fail_calc="cnt")}}
-- 2-9
select count(*) as cnt
    from {{ref('dm_yohin_daiatari')}}
    where nyukoymd is not null -- [TMP]入庫日に値がある場合
      and m_tkskbn = '4' -- 一般直送区分が"4"(旧直)の場合
      and 
        ( m_jhinban is null
       or m_shinban is null
       or m_juchuymd is null
       or m_syukkaymd is null
       or m_syukkasu is null
        )