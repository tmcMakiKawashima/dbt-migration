{{config(fail_calc="cnt")}}
-- 2-7
select count(*) as cnt
    from {{ref('dm_hosyuhin_noukishitei')}}
    where nyukoymd is not null
        and m_tkskbn = '1'
        and (m_jhinban is null
            and m_shinban is null
            and m_juchuymd is null
            and m_syukkaymd is null
            and m_syukkasu is null
            and m_kaknoukbn is null
            and m_thibusyocd is null
            and m_thitatocd is null
            and m_tehaikbn is null
        )







