with ippan as (
    select * from {{ref('DM_TMC_IPPAN_JUTYUNOKIKAITO')}}
    where SUBSTR(M_ORDENO,0,2) = 'ZZ'
),
tyoku as (
    select * from {{ref('DM_TMC_TYOKUSO_JUTYUNOKIKAITO')}}	
    where SUBSTR(M_ORDENO,0,2) = 'ZZ'
)
select * from ippan
union
select * from tyoku