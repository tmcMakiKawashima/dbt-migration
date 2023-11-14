{{ config(fail_calc = "cnt") }}
-- 2-1
select count(*) as cnt
    from {{ref('dm_hosyuhin_noukishitei')}}
    where m_tkskbn in ('1', '3')
      and (
            (m_juchusu <> 0 or m_juchusu is not null)
        and (m_syukkasu <> 0 or m_syukkasu is not null)
        and (nyukosu <> 0 or nyukosu is not null)
        )
      and (m_juchusu < m_syukkasu or m_syukkasu < nyukosu)