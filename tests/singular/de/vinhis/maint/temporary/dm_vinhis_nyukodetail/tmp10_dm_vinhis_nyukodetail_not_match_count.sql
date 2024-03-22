{{ config(fail_calc = "cnt") }}
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("stg_nyukoreki")}}
      where delflg = '0'
      and (nyukohanbaitencd, jutyuno, seisanymd) in (
        select
          nyukohanbaitencd,
          jutyuno,
          seisanymd
        from {{ref("stg_nyukomeisaisakuin")}}
        where delflg = '0'
      )
    ) a, (
      select count(*) as cnt
      from {{ref("tmp10_dm_vinhis_nyukodetail")}}
    ) b