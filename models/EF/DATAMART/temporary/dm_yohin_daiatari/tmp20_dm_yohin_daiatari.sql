with temp10 as (
    select * from {{ref('tmp10_DM_YOHIN_DAIATARI')}}
),
DM_SHINSYA_MEISAI as (
    select
       RTRIM(HKATA) HKATA, RTRIM(FLNO) FLNO,
       COALESCE(TSHAMEIA,'') || '-'
       || COALESCE(TSHAMEIB,'') || '-'
       || COALESCE(TSHAMEIC,'') || '-'
       || COALESCE(TSHAMEID,'') TSHAMEI,
       HDKB, YOUTOKBN, FTDD, TODD, NSQBDY, NSDD, HIYTDD, TOYTDD
    from {{ref('DM_SHINSYA_MEISAI')}}
)
select * from temp10 t
left outer join DM_SHINSYA_MEISAI h
on t.FRMNO = h.FLNO
and t.HANKATA = h.HKATA