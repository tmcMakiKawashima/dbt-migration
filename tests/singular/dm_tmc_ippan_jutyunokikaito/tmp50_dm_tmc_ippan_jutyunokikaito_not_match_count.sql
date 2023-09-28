{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from (
        select
          DLRCD, -- 仕向先CD
          YUSOKBN, -- 輸送CD
          ODRNO, -- オーダーNO
          JUCHUYMD, -- 受注日
          JHINBAN, -- 受注品番
          SYUBETSU, -- オーダー種別
          KAKUNOUKBN, -- 格納拠点区分
          SIIRECD -- 仕入先CD
        from {{ ref("tmp30_dm_tmc_ippan_jutyunokikaito") }}
        group by all
      )
    ) a, (
      select count(*) as cnt
      from {{ ref("tmp50_dm_tmc_ippan_jutyunokikaito") }}
    ) b