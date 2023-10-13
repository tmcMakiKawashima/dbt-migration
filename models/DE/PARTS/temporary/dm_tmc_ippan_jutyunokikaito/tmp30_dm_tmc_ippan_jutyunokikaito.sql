with
    temp20 as (select * from {{ ref("tmp20_dm_tmc_ippan_jutyunokikaito") }}),
    temp20_tehai as (select * from {{ ref("tmp20_tehai_dm_tmc_ippan_jutyunokikaito") }})
select
    temp20.* exclude (
        kaknoukbn,
        jurrsymd,
        srsirskcd,
        kozyocd,
        brsirskcd,
        nonukyokbn,
        ukeirecd,
        nonyutni,
        picloke,
        sykikicd,
        sksijbsy
    ),
    tehai.* exclude(dlrcd, yusokbn, odrno, juchuymd, jhinban, syubetsu)
from temp20
left outer join
    temp20_tehai tehai
    on temp20.dlrcd = tehai.dlrcd
    and temp20.syubetsu = tehai.syubetsu
    and temp20.yusokbn = tehai.yusokbn
    and temp20.odrno = tehai.odrno
    and temp20.juchuymd = tehai.juchuymd
    and temp20.jhinban = tehai.jhinban
