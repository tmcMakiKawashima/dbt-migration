with
    temp30 as (select * from {{ ref("tmp30_DM_TMC_IPPAN_JUTYUNOKIKAITO") }}),
    tehai_kanban as (
        select
            tyotathb,
            kaknoukbn,
            tekiyokaisiymd,
            tekiyosyuryoymd,
            hinbankaisiymd,
            hinbansryoymd,
            tehaikaisiymd,
            tehaisryoymd,
            thibusyocd,
            thitatocd,
            tehaikbn,
            zaihikbn,
            cycle4,
            kjnziknisu3,
            kjnziksu,
            anzenzaikonisu,
            anznzksu,
            nonyult,
            nbscd,
            orosibacd,
            brsirskkojocd
        from {{ ref("stg_DVSF509A") }}
    ),
    syukkabin as (
        select dlrcd, syubetsu, yusokbn, max(keikanissu) keikanissu
        from {{ ref("stg_CVN35DSYUKABIN") }}
        group by all
    )
select
    temp30.*,
    tehai.* exclude(
        tyotathb,
        kaknoukbn,
        tekiyokaisiymd,
        tekiyosyuryoymd,
        hinbankaisiymd,
        hinbansryoymd,
        tehaikaisiymd,
        tehaisryoymd
    ),
    syukkabin.keikanissu
from temp30
left outer join
    tehai_kanban tehai
    on temp30.tehai_shinban = tehai.tyotathb
    and temp30.kaknoukbn = tehai.kaknoukbn
    and temp30.juchuymd >= tehai.tekiyokaisiymd
    and temp30.juchuymd <= tehai.tekiyosyuryoymd
    and temp30.juchuymd >= tehai.hinbankaisiymd
    and temp30.juchuymd <= tehai.hinbansryoymd
    and temp30.juchuymd >= tehai.tehaikaisiymd
    and temp30.juchuymd <= tehai.tehaisryoymd
left outer join
    syukkabin
    on temp30.dlrcd = syukkabin.dlrcd
    and temp30.syubetsu = syukkabin.syubetsu
    and iff(temp30.yusokbn = '1', '1', '*') = syukkabin.yusokbn
