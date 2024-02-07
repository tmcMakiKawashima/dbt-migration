with ippan as (
    select * from {{ ref('dm_tmc_ippan_jutyunokikaito') }}
    where substr(m_ordeno, 1, 1) in ('P', 'Q')
),
tyoku as (
    select * exclude(m_nonuhikiatnis, m_jsksyseiymd) 
      from {{ ref('dm_tmc_tyokuso_jutyunokikaito') }}
     where substr(m_ordeno, 1, 1) in ('P', 'Q')
       and m_jsksyseiymd = ''
)
select * from ippan union all select * from tyoku