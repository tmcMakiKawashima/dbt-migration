{{ config(fail_calc = "cnt") }}
--データ結合３のチェック
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("tmp20_dm_hosyuhin_tmp_juhattyuuriage")}} -- データ結合２
    ) a, (
      select count(*) as cnt
      from {{ref("tmp30_dm_hosyuhin_tmp_juhattyuuriage")}}
    ) b