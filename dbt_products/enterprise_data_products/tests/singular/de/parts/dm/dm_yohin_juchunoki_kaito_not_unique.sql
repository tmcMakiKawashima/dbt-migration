{{config(fail_calc="cnt")}}
-- データ結合３ 1-2
select count(*) as cnt
    from(
        select
            m_dlrcd, m_yusokbn, m_syubetsu, m_ordeno, m_juchuymd,
            iff(m_jhinban = '', m_shinban, m_jhinban) as hinban
        from {{ref('dm_yohin_juchunoki_kaito')}}
        group by m_dlrcd, m_yusokbn, m_syubetsu, m_ordeno, m_juchuymd, hinban
        having count(*) > 1
    )