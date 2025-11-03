{{config(fail_calc="cnt")}}
-- 2-2
select count(*) as cnt
    from {{ref('dm_yohin_daiatari')}}
    where m_tkskbn in ('1', '3') -- 一般直送区分が"1"、"3"（一般、新直送）の場合
      -- [メーカー]受注数、[メーカー]出荷数に値がある場合
      and m_juchusu is not null
      and m_syukkasu is not null
      -- [メーカー]受注数に対して、[メーカー]出荷数が大きくないかの確認
      and m_juchusu < m_syukkasu