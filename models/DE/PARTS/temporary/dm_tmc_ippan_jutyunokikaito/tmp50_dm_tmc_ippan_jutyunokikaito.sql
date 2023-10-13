with
    nyusyukko as (select * from {{ ref("nyusyukko_x_shimuke") }}),
    syukkaippan as (
        select
            dlrcd,
            ordesybt,
            iff(yusokbn is null, '', yusokbn) yusokbn,
            ordeno,
            jhinban,
            juchuymd,
--            tkskbn,
 --           kyotnkbn,
            shinban,
            syksu6,
            syukkaymd,
            caseno6
        from {{ ref("stg_dvnp5770") }}
    )
select nyusyukko.* exclude(shimukesaki_nyuko, chumon_no_nyuko, hinban_nyuko), syukkaippan.*
from syukkaippan
left outer join
    nyusyukko
    on syukkaippan.dlrcd = nyusyukko.shimukesaki_nyuko
    and syukkaippan.ordeno = nyusyukko.chumon_no_nyuko
    and syukkaippan.shinban = nyusyukko.hinban_nyuko
    and syukkaippan.syukkaymd = nyusyukko.jdate_nyuko
    and syukkaippan.caseno6 = nyusyukko.dennoj_nyuko
