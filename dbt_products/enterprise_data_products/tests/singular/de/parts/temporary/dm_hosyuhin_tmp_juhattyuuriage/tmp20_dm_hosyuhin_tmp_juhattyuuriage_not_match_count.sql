{{ config(fail_calc = "cnt") }}
--データ結合２のチェック
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("tmp10_dm_hosyuhin_tmp_juhattyuuriage")}} -- データ結合１
    ) a, (
      select count(*) as cnt
      from {{ref("tmp20_dm_hosyuhin_tmp_juhattyuuriage")}}
    ) b