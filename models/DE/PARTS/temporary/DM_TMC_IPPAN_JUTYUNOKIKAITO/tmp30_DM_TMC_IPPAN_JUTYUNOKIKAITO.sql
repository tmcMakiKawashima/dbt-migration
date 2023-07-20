with temp20 as (
    select * from {{ ref("tmp20_DM_TMC_IPPAN_JUTYUNOKIKAITO") }}
    ),
    bokanri as (
        select ORDRKEY, JURRSYMD, SIIRECD, max(IFF(MARTFLG is null, '',  MARTFLG)) MARTFLG
        from {{ref('stg_DVNP6490')}} where KOKAGKBN = '1'
        group by ORDRKEY, JURRSYMD, SIIRECD
        )
select
     temp20.*
    ,bokanri.MARTFLG
    ,bokanri.SIIRECD
from temp20
left outer join bokanri
on temp20.ORDRKEY = bokanri.ORDRKEY
and temp20.JUCHUYMD = bokanri.JURRSYMD
    {# and IFF(temp20.TANSKKEY is null, '', temp20.TANSKKEY) = IFF(bokanri.TANSKKEY is null, '', bokanri.TANSKKEY) #}

