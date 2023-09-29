{{ config(fail_calc = "cnt") }}

select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ ref('stg_st_hanbaikt_frmkbn') }}
    ) a, (
      select count(*) as cnt
      from {{ ref('dm_kokunai_shinseisan_jisseki') }}
    ) b