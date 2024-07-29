{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref('tmp10_dm_yohin_daiatari')}}
    ) a, (
      select count(*) as cnt
      from {{ref('tmp20_dm_yohin_daiatari')}}
    ) b