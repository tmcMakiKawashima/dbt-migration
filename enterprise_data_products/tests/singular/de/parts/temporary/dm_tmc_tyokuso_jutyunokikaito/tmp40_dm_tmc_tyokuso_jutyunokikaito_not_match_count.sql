{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref('tmp30_dm_tmc_tyokuso_jutyunokikaito')}}
    ) a, (
      select count(*) as cnt
      from {{ref('tmp40_dm_tmc_tyokuso_jutyunokikaito')}}
    ) b