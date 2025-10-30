{{ config(fail_calc = "cnt")}}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref('dm_hosyuhin_tmp_juhattyuuriage')}}
      where tkskbn in ('1', '3', '4')
    ) a, (
      select count(*) as cnt
      from {{ref('tmp10_dm_hosyuhin_noukishitei')}}
    ) b