{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from (
        select
          DLRCD,  --仕向先CD
          YUSOKBN,  --輸送CD
          ORDENO,  --注文NO
          JUCHUYMD,  --受注日
          JHINBAN,  --受注品番
          ORDESYBT,  --オーダー種別
          SIIRECD  --仕入先CD
        from {{ref('stg_dvnp4520')}}  --直送出荷手配
        group by all
      )
    ) a, (
      select count(*) as cnt
      from {{ref('tmp20_dm_tmc_tyokuso_jutyunokikaito')}}
    ) b