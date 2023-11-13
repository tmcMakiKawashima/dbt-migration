{{ config(fail_calc = "cnt") }}

select c.cnt - (a.cnt  + b.cnt) as cnt
    from
    (
      select count(*) as cnt
      from (
        select
          dlrcd, --仕向先CD
          yusokbn, --輸送CD
          ordeno, --注文No
          juchuymd, --受注日
          jhinban, --受注品番
          ordesybt, --オーダー種別
          siirecd --仕入先CD
        from {{ref('stg_dvnp4520')}} --直送出荷手配
        group by all
      )
    ) a, (
      select count(*) as cnt
      from (
        select
          dlrcd, --仕向先CD
          ordesybt, --オーダー種別
          yusokbn, --輸送CD
          ordeno, --注文No
          jhinban, --受注品番
          juchuymd, --受注日
          shinban, --出荷品番
          siirecd --仕入先CD
        from {{ref('tmp10_dm_tmc_tyokuso_jutyunokikaito')}} --データ結合2結果(tmp10_dm_tmc_tyokuso_jutyunokikaito)
        where jusinno = '' --受信No
        and renban2 = '' --連番（直送）
        group by all
      )
    ) b, (
      select count(*) as cnt
      from {{ref('tmp30_dm_tmc_tyokuso_jutyunokikaito')}} --データ結合3結果
    ) c