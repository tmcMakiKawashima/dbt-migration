{{ config(fail_calc = "cnt") }}
--データ結合４のチェック
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("tmp30_dm_hosyuhin_tmp_juhattyuuriage")}} -- データ結合３
    ) a, (
      select count(*) as cnt
      from {{ref("tmp40_dm_hosyuhin_tmp_juhattyuuriage")}}
    ) b