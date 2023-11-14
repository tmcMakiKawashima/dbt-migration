{{config(fail_calc="cnt")}}
-- 2-6
select count(*) as cnt
    from {{ref('dm_hosyuhin_noukishitei')}}
        where m_syukkasu = nyukosu
        and m_syukkaymd > nyukoymd
