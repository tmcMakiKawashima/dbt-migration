{{ config(fail_calc = "cnt") }}
--データ結合６のチェック
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("tmp30_dm_tmc_ippan_jutyunokikaito")}} -- データ結合３
    ) a, (
      select count(*) as cnt
      from {{ref("tmp40_dm_tmc_ippan_jutyunokikaito")}}
    ) b