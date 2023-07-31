with dm_shinsya_meisai as(
  select
    HKATA,
    FLNO,
    TSHAMEIA,
    TSHAMEIB,
    TSHAMEIC,
    TSHAMEID,
    HDKB,
    YOUTOKBN,
    FTDD,
    HIYTDD,
    TOYTDD,
    TODD,
    NSQBDY,
    NSDD
  from {{ref('tmp20_dm_shinsya_meisai')}}
  where rnk = 1
)
select * from dm_shinsya_meisai
