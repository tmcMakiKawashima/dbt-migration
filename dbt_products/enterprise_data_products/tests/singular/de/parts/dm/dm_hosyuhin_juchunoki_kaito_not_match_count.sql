{{ config(fail_calc = "cnt") }}

select c.cnt - (a.cnt  + b.cnt) as cnt
    from
    (
      select count(*) as cnt 
      from {{ref('dm_tmc_ippan_jutyunokikaito')}}
      where substr(m_ordeno, 1, 1) in ('P', 'Q')
    ) a, (
      select count(*) as cnt
      from {{ref('dm_tmc_tyokuso_jutyunokikaito')}}
      where substr(m_ordeno, 1, 1) in ('P', 'Q')
        and m_jsksyseiymd = ''
    ) b, (
      select count(*) as cnt
      from {{ref('dm_hosyuhin_juchunoki_kaito')}}
    ) c