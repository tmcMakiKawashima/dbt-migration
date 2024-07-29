{{ config(fail_calc = "cnt") }}
--データ結合５のチェック
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("tmp45_dm_tmc_ippan_jutyunokikaito")}} -- データ結合４
    ) a, (
      select count(*) as cnt
      from {{ref("tmp50_dm_tmc_ippan_jutyunokikaito")}}
    ) b