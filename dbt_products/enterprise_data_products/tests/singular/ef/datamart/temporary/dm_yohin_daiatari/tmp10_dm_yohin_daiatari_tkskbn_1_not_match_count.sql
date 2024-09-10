{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref('dm_yohin_tmp_juhattyuuriage')}}
      where TKSKBN = '1' -- 一般直送区分
    ) a, (
      select count(*) as cnt
      from {{ref('tmp10_dm_yohin_daiatari')}}
      where TKSKBN = '1' -- 一般直送区分
    ) b