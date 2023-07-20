with nyusyukko as (
    select * from {{ref('nyusyukko_x_shimuke')}}
),
syukkaippan as (
    select
        DLRCD,
        ORDESYBT,
        IFF(YUSOKBN is null, '', YUSOKBN) YUSOKBN,
        ORDENO,
        JHINBAN,
        JUCHUYMD,
        TKSKBN,
        KYOTNKBN,
        SHINBAN,
        SUM(SYKSU6) SYUKKASU,
        MAX(SYUKKAYMD) SYUKKAYMD,
        CASENO6 DENNO
    from {{ref('stg_DVNP5770')}}
    group by
        DLRCD,
        ORDESYBT,
        YUSOKBN,
        ORDENO,
        JHINBAN,
        JUCHUYMD,
        TKSKBN,
        KYOTNKBN,
        SHINBAN,
        CASENO6
)
select
     nyusyukko.*
    ,syukkaippan.*
from syukkaippan
left outer join nyusyukko
on syukkaippan.DLRCD = nyusyukko.SHIMUKESAKI_NYUKO
and syukkaippan.ORDENO = nyusyukko.CHUMON_NO_NYUKO
and syukkaippan.SHINBAN = nyusyukko.HINBAN_NYUKO
and syukkaippan.SYUKKAYMD = nyusyukko.JDATE_NYUKO
and syukkaippan.DENNO = nyusyukko.DENNOJ_NYUKO
