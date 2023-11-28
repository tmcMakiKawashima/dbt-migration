{{config(fail_calc = "cnt")}}
-- 2-3
select count(*) as cnt
    from {{ref('dm_hosyuhin_noukishitei')}}
    where m_tkskbn = '4'
      and (
            m_syukkasu is not null
        and nyukosu is not null
      )
      and m_syukkasu < nyukosu