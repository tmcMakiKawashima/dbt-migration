{{ config(fail_calc = "cnt") }}
-- データ結合７のチェック
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from (
        select
          dlrcd, -- 仕向先CD
          yusokbn, -- 輸送CD
          odrno, -- オーダーNO
          juchuymd, -- 受注日
          jhinban, -- 受注品番
          syubetsu -- オーダー種別
        from {{ref("tmp40_dm_tmc_ippan_jutyunokikaito")}} -- データ結合６
        group by all
      )
    ) a, (
      select count(*) as cnt
      from {{ref("tmp60_dm_tmc_ippan_jutyunokikaito")}}
    ) b