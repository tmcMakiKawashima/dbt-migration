with ippan as (
    select * from {{ ref('dm_tmc_ippan_jutyunokikaito') }}
    where substr(m_ordeno, 0, 1) in ('p', 'q')
),
tyoku as (
    select * exclude(m_nonuhikiatnis) from {{ ref('dm_tmc_tyokuso_jutyunokikaito') }}
    where substr(m_ordeno, 0, 1) in ('p', 'q')
)
select * from ippan union all select * from tyoku