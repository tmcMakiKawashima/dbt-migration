with vd1 as (
  select * from {{ref('tmp20_dm_variation_seisan_daisu')}}
),sd as (
  select * from {{ref('dm_siyo_daisu')}}
)
select
  vd1.*,
  sd.daisu as daisu_spec200  -- 台数(SPEC200)
from vd1
left join sd
on (
    vd1.syasyu = sd.syasyu
and vd1.haisya_kt = sd.haisya_kt
and vd1.spec200 = sd.spec200
and vd1.spec200_siyo = sd.spec200_siyo
and vd1.sk_y = sd.sk_y
and vd1.sk_m = sd.sk_m
)