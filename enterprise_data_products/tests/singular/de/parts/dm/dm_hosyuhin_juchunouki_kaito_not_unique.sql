{{config(fail_calc="cnt")}}

select count(*) as cnt
    from
    (
        select
            m_dlrcd, m_yusokbn, m_syubetsu, m_ordeno, m_juchuymd, iff(m_jhinban = '', m_shinban, m_jhinban) as hinban
            from {{ref('dm_hosyuhin_juchunoki_kaito')}}
            group by m_dlrcd, m_yusokbn, m_syubetsu, hinban, m_ordeno, m_juchuymd
            having count(*) > 1
    )						