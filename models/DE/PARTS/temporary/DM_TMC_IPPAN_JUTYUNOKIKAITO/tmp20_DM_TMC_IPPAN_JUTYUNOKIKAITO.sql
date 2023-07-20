with
    temp10 as (
        select * from {{ ref("tmp10_DM_TMC_IPPAN_JUTYUNOKIKAITO") }}
        ),
    bonokikkaito as (
        select 
            ORDRKEY,
            JURRSYMD,
            max(IFF(hnnoytime is null, '', hnnoytime)) hnnoytime,
            max(IFF(hnsyytime is null, '', hnsyytime)) hnsyytime,
            max(IFF(hntoytime is null, '', hntoytime)) hntoytime,
            max(IFF(hsnoytime is null, '', hsnoytime)) hsnoytime,
            max(IFF(hssyytime is null, '', hssyytime)) hssyytime
        from {{ref('stg_DVNP0710')}} where KOKAGKBN = '1'
        group by ORDRKEY, JURRSYMD
        )
select
    temp10.*,
    bo.hnnoytime,
    bo.hnsyytime,
    bo.hntoytime,
    bo.hsnoytime,
    bo.hssyytime
from temp10
left outer join bonokikkaito bo
on temp10.ORDRKEY = bo.ORDRKEY
and temp10.JUCHUYMD = bo.JURRSYMD    
{# and iff(temp10.TANSKKEY is null, '', temp10.TANSKKEY)
= iff(bo.TANSKKEY is null, '', bo.TANSKKEY) #}
