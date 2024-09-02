{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ ref('tmp10_dm_yohin_tmp_juhattyuuriage') }}
    ) a, (
      select count(*) as cnt
      from {{ ref('tmp20_dm_yohin_tmp_juhattyuuriage') }}
    ) b