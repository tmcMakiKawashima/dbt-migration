with nyusyukko as (
    select
        KYOUHAN KYOUHAN_NYUKO,
        HINBAN HINBAN_NYUKO,
        DENNOJ DENNOJ_NYUKO,
        SUM(SYUKAJ) NYUKOSU,
        MAX(SDATE) NYUKOYMD,
        JDATE JDATE_NYUKO,
        CHOKSO CHOKSO_NYUKO,
        UKEKTEN UKEKTEN_NYUKO,
        IFF(REMARK2 is null, '', RIGHT(REMARK2, 5)) CHUMON_NO_NYUKO
    from {{ ref('stg_tbnsyus') }}
    where GDENK in ('71', '72', '73', '74', '75', '78')
    and DSYUBETS = '6'
    group by
            KYOUHAN,
            HINBAN,
            DENNOJ,
            JDATE,
            CHOKSO,
            UKEKTEN,
            CHUMON_NO_NYUKO
),
shimuke as (
    select * from {{ref('stg_tbsmksk')}}
    )
select 
     nyusyukko.*
    ,shimuke.SISHACD
    ,RTRIM(nyusyukko.KYOUHAN_NYUKO || IFF(shimuke.SISHACD is null, '', shimuke.SISHACD)) SHIMUKESAKI_NYUKO
from nyusyukko
left outer join shimuke
on nyusyukko.KYOUHAN_NYUKO = shimuke.KYOUHAN
and nyusyukko.UKEKTEN_NYUKO = shimuke.KYOTEN