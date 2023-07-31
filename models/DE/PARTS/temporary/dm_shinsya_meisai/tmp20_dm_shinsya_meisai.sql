{{ config(materialized='table') }}

with tmp20_dm_shinsya_meisai as (
  select 
    ST_MD5_SINSYAODNO_LINK,
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
    NSDD,
    CUNO,
    EDANO,
    YM,
    RANK() over (partition by HKATA, FLNO order by YM desc, CUNO desc, EDANO desc) as rnk
  from {{ref('tmp10_dm_shinsya_meisai')}}
)
select * from tmp20_dm_shinsya_meisai
