{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from (
        select
          DLRCD,  --仕向先CD
          ORDESYBT,  --オーダー種別
          YUSOKBN,  --輸送CD
          JHINBAN,  --受注品番
          JUCHUYMD,  --受注日
          ORDENO,  --注文No
          TKSKBN,  --一般直送区分
          SHINBAN,  --出荷品番
          SIRISSUENO  --仕入先ISSUE_NO
        from {{ref('stg_dvnp4330')}}  --国内出荷実績直送
        group by all
      )
    ) a, (
      select count(*) as cnt
      from {{ref('tmp10_dm_tmc_tyokuso_jutyunokikaito')}}
    ) b