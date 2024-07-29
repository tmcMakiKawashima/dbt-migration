{{ config(fail_calc = "cnt") }}
-- 2-5
select count(*) as cnt
    from {{ref('dm_yohin_daiatari')}}
    where m_juchusu > m_syukkasu -- [メーカー]受注数に対して[メーカー]出荷数が小さい場合
    -- [メーカー]B/O数と[メーカー]出荷数に値がある場合
    and m_bosu is not null
    and m_syukkasu is not null
    -- [メーカー]B/O数が登録されているか確認
    and m_juchusu - m_syukkasu < m_bosu