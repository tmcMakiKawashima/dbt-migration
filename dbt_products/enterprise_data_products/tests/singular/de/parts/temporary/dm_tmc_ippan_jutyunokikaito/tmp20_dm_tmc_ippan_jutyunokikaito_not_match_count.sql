{{ config(fail_calc = "cnt") }}
--データ結合２のチェック
select iff((c.cnt > a.cnt and c.cnt < b.cnt) > 0, 0, 1) as cnt
    from
    (
      select count(*) as cnt
      from {{ref("stg_dvnp0680")}} -- オーダー情報ファイル
      where kokagkbn = '1' -- 国内海外区分
    ) a, (
      select count(*) as cnt
      from {{ref("stg_dvnp0700")}} -- オーダー指示ステータスファイル
    ) b, (
      select count(*) as cnt
      from {{ref("tmp20_dm_tmc_ippan_jutyunokikaito")}}
    ) c