{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("stg_dvnp0680")}}
      where KOKAGKBN = '1' -- 国内海外区分
    ) a, (
      select count(*) as cnt
      from {{ ref("tmp10_dm_tmc_ippan_jutyunokikaito") }}
    ) b