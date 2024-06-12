{{ config(fail_calc = "cnt") }}
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("tmp10_dm_vinhis_goyomei")}}
    ) a, (
      select count(*) as cnt
      from {{ref("tmp20_dm_vinhis_goyomei")}}
    ) b