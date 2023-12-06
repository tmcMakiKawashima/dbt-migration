with dm_shinsya_meisai as(
  select
    hkata,
    flno,
    tshameia,
    tshameib,
    tshameic,
    tshameid,
    hdkb,
    youtokbn,
    ftdd,
    hiytdd,
    toytdd,
    todd,
    nsqbdy,
    nsdd,
    jkeidd,
    hanbkjdd
  from {{ref('tmp30_dm_shinsya_meisai')}}
)
select * from dm_shinsya_meisai
