{{config(fail_calc = "cnt")}}
-- 2-3
select count(*) as cnt
    from {{ref('dm_hosyuhin_noukishitei')}}
    where m_tkskbn = '4'
        and (
            (m_syukkasu <> 0 or m_syukkasu is null)
            and (nyukosu <> 0 or nyukosu is null)
        )
        and m_syukkasu < nyukosu