{{ config(fail_calc = "cnt") }}
select b.cnt - a.cnt as cnt
    from
    (
      select count(*) as cnt
      from {{ref("dm_vinhis_nyukodetail")}}
      where nyuko_no in (
        select nyukono
        from {{ref("stg_seibireki")}}
        where delflg = '0'
      )
    ) a, (
      select count(*) as cnt
      from (
        select distinct
          syadai_kt,
          frm_no,
          nyuko_dlrcd,
          jutyu_no,
          payment_date,
          nyuko_no
        from {{ref("tmp10_dm_vinhis_seibireki")}}
      )
    ) b