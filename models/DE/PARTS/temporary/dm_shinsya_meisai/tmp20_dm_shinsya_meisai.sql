{{ config(materialized='table') }}

with tmp20_dm_shinsya_meisai as (
  select 
    st_md5_sinsyaodno_link,
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
    cuno,
    edano,
    ym,
    dlrcd,
    rank() over (partition by hkata, flno order by ym desc, cuno desc, edano desc) as rnk
  from {{ref('tmp10_dm_shinsya_meisai')}}
)
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
  dlrcd,
  cuno,
  ym,
  rnk
from tmp20_dm_shinsya_meisai
