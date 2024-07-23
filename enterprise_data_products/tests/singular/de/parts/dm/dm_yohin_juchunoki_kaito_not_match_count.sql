{{ config(fail_calc = "cnt") }}

select c.cnt - a.cnt - b.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref('dm_tmc_ippan_jutyunokikaito')}} -- TMC一般オーダー受注納期回答DM
      where substr(m_ordeno,0,2) = 'ZZ' -- メーカーオーダーNO（先頭２桁）
    ) a, (
      select count(*) as cnt
      from {{ref('dm_tmc_tyokuso_jutyunokikaito')}} -- TMC直送オーダー受注納期回答DM
      where substr(m_ordeno,0,2) = 'ZZ' -- メーカーオーダーNO（先頭２桁）
        and m_jsksyseiymd = ''
    ) b, (
      select count(*) as cnt
      from {{ref('dm_yohin_juchunoki_kaito')}}
    ) c