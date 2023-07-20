with
    temp50 as (select * from {{ ref("tmp50_DM_TMC_IPPAN_JUTYUNOKIKAITO") }}),
    tehai as (select * from {{ref('stg_DVSF509A')}})
select
     temp50.*
    ,tehai.KAKNOUKBN
    ,tehai.THIBUSYOCD
    ,tehai.THITATOCD
    ,tehai.TEHAIKBN
from temp50
left outer join tehai
on ARRAY_CONTAINS(tehai.TYOTATHB::variant,SPLIT(temp50.SHINBAN,',')) 
and temp50.KAKUNOUKBN = tehai.KAKNOUKBN
and TO_VARCHAR(CURRENT_DATE,'yyyyMMdd') >= tehai.TEKIYOKAISIYMD
and TO_VARCHAR(CURRENT_DATE,'yyyyMMdd') <= tehai.TEKIYOSYURYOYMD
and temp50.SIIRECD = tehai.SRSIRSKCD