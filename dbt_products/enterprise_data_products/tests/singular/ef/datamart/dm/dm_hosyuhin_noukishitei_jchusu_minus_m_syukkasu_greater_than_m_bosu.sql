{{config(fail_calc="cnt")}}
-- 2-5
select count(*) as cnt
    from {{ref('dm_hosyuhin_noukishitei')}}
    where jchusu > m_syukkasu
        and (m_bosu is not null and m_syukkasu is not null)
        and jchusu - m_syukkasu < m_bosu