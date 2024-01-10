-- データ結合１ 1-1
{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from (
        select
          dlrcd,  --仕向先cd
          ordesybt,  --オーダー種別
          yusokbn,  --輸送cd
          jhinban,  --受注品番
          juchuymd,  --受注日
          ordeno,  --注文no
          tkskbn,  --一般直送区分
          shinban,  --出荷品番
          sirissueno,  --仕入先issue_no
          siirecd --仕入先cd
        from {{ref('stg_dvnp4330')}}  --国内出荷実績直送
        group by all
      )
    ) a, (
      select count(*) as cnt
      from {{ref('tmp10_dm_tmc_tyokuso_jutyunokikaito')}}
    ) b