{{ config(fail_calc = "cnt") }}
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("tmp10_dm_vinhis_seibireki")}}
    ) a, (
      select count(*) as cnt
      from {{ref("dm_vinhis_seibireki")}}
    ) b