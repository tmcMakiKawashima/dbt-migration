{{ config(fail_calc = "cnt") }}
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("tmp30_dm_vinhis_nyukodetail")}}
    ) a, (
      select count(*) as cnt
      from {{ref("dm_vinhis_nyukodetail")}}
    ) b