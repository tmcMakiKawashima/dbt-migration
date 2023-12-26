{{config(fail_calc="cnt")}}
-- 2-7
select count(*) as cnt
    from {{ref('dm_yohin_daiatari')}}
    where nyukoymd is not null -- [TMP]入庫日に値がある場合
      and m_tkskbn = '1' -- 一般直送区分が"1"(一般)の場合
      and 
       (  m_jhinban is null
       or m_shinban is null
       or m_juchuymd is null
       or m_syukkaymd is null
       or m_syukkasu is null
       or m_kaknoukbn is null
       )