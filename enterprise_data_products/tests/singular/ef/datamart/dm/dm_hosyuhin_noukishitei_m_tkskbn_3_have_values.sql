{{config(fail_calc="cnt")}}
-- 2-8
select count(*) as cnt
    from {{ref('dm_hosyuhin_noukishitei')}}
        where nyukoymd is not null
        and m_tkskbn = '3'
        and 
          ( m_jhinban is null
         or m_shinban is null
         or m_juchuymd is null
         or m_syukkaymd is null
         or m_syukkasu is null
          )