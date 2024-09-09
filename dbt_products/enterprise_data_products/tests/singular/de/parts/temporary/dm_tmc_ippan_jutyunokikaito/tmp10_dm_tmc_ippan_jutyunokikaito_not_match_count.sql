{{ config(fail_calc = "cnt") }}
--データ結合１のチェック
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("stg_dvnp0680")}} -- オーダー情報ファイル
      where kokagkbn = '1' -- 国内海外区分
    ) a, (
      select count(*) as cnt
      from {{ref("tmp10_dm_tmc_ippan_jutyunokikaito")}}
    ) b