{{ config(fail_calc = "cnt") }}
--データ結合１のチェック
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("stg_tbnokjs")}} -- 納期指定受注蓄積F
    ) a, (
      select count(*) as cnt
      from {{ref("tmp10_dm_hosyuhin_tmp_juhattyuuriage")}}
    ) b