{{ config(fail_calc = "cnt") }}
--データ結合４のチェック
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from (
        select
          dlrcd, -- 仕向先cd
          ordesybt, -- オーダー種別
          yusokbn, -- 輸送cd
          ordeno, -- 注文no
          jhinban, -- 受注品番
          juchuymd, -- 受注日
          tkskbn, -- 一般直送区分
          shinban, -- 出荷品番
          caseno6 -- ケースno
        from {{ref('stg_dvnp5770')}} -- 国内出荷実績一般
        group by all
      )
    ) a, (
      select count(*) as cnt
      from {{ref("tmp45_dm_tmc_ippan_jutyunokikaito")}}
    ) b