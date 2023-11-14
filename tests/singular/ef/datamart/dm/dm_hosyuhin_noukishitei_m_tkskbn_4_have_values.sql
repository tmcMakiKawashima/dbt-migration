{{config(fail_calc="cnt")}}
-- 2-9
select count(*) as cnt
    from {{ref('dm_hosyuhin_noukishitei')}}
    where nyukoymd is not null
        and m_tkskbn = '4'
        and (m_jhinban is null
            and m_shinban is null
            and m_juchuymd is null
            and m_syukkaymd is null
            and m_syukkasu is null
        )