{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from (
        select
          DLRCD, -- 仕向先CD
          ORDESYBT, -- オーダー種別
          YUSOKBN, -- 輸送CD
          ORDENO, -- 注文NO
          JHINBAN, -- 受注品番
          JUCHUYMD, -- 受注日
          TKSKBN, -- 一般直送区分
          SHINBAN, -- 出荷品番
          CASENO6 -- ケースNO
        from {{ref('stg_dvnp5770')}}
        group by all
      )
    ) a, (
      select count(*) as cnt
      from {{ ref("tmp40_dm_tmc_ippan_jutyunokikaito") }}
    ) b