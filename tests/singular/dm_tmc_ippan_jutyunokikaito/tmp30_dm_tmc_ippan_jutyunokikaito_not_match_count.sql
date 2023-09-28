{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ ref("tmp20_dm_tmc_ippan_jutyunokikaito") }}
    ) a, (
      select count(*) as cnt
      from {{ ref("tmp30_dm_tmc_ippan_jutyunokikaito") }}
    ) b