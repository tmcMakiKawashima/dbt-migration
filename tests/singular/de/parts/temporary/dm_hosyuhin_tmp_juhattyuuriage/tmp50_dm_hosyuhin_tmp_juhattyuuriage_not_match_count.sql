{{ config(fail_calc = "cnt") }}
--データ結合５のチェック
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("tmp40_dm_hosyuhin_tmp_juhattyuuriage")}} -- データ結合４
    ) a, (
      select count(*) as cnt
      from {{ref("tmp50_dm_hosyuhin_tmp_juhattyuuriage")}}
    ) b