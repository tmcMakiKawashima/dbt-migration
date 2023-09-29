{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ ref("tmp50_dm_tmc_ippan_jutyunokikaito") }}
    ) a, (
      select count(*) as cnt
      from {{ ref("tmp60_dm_tmc_ippan_jutyunokikaito") }}
    ) b