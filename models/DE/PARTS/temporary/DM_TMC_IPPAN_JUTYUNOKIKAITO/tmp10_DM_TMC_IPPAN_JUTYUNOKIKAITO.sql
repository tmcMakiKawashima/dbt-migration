with jh as (
    select * from {{ref('stg_ORDERJOHOFILE')}}
    where KOKAGKBN = '1'
),
ss as (
    select
         ORDRKEY
        ,listagg(distinct(SHINBAN), ',') SHINBAN
        ,sum(BOSU) BOSU
        ,max(BOSKSTIME) BOSKSTIME
        ,max(KAKNOUKBN) KAKUNOUKBN
    from {{ref('stg_ORDERSHIJISTATUSFILE')}}
    group by ORDRKEY
)
select 
     jh.ORDRKEY
    ,jh.DLRCD
    ,IFF(jh.YUSOKBN is null, '', jh.YUSOKBN) YUSOKBN
    ,jh.ODRNO
    ,jh.JUCHUYMD
    ,jh.JHINBAN
    ,jh.SYUBETSU
    ,ss.SHINBAN
    ,ss.BOSU
    ,ss.BOSKSTIME
    ,ss.KAKUNOUKBN
from jh
left outer join ss
on jh.ORDRKEY = ss.ORDRKEY