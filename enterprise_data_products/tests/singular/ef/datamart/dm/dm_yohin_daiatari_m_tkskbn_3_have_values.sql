{{config(fail_calc="cnt")}}
-- 2-8
select count(*) as cnt
    from {{ref('dm_yohin_daiatari')}}
    where nyukoymd is not null -- [TMP]入庫日に値がある場合
      and m_tkskbn = '3' -- 一般直送区分が"3"(新直)の場合
      and 
        ( m_jhinban is null
       or m_shinban is null
       or m_juchuymd is null
       or m_syukkaymd is null
       or m_syukkasu is null
        )