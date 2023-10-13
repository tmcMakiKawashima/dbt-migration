with
    temp40 as (
        select
            dlrcd,
            yusokbn,
            odrno,
            juchuymd,
            jhinban,
            syubetsu,
            juchusu,
            rimak1,
            rimak2,
            hnskiboymd,
            hoskiboymd,
            hsskiboymd,
            skibohenkokaisu,
            hnhonyoyakuymd,
            hshonyoyakuymd,
            hnnksyytime,
            honksyytime,
            hsnksyytime,
            allnosicansu,
            hnnosicansu,
            hnnosicantime,
            honosicantime,
            hsnosicantime,
            nosicankaisu,
            iphonyoyakuymd,
            kariyoyakuymd,
            hnnosikbn,
            hsnosikbn,
            honosikbn,
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
            sksijbsy,
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
            brsirskkojocd,
            keikanissu,
            hnnoytime,
            hnsyytime,
            hntoytime,
            hsnoytime,
            hssyytime,
            ptopflg,
            hskkbn,
            hstaytime,
            hstoytime,
            hokkbn,
            honoytime,
            hotaytime,
            hosyytime,
            hotoytime,
            mkaitocd,
            hnkkbn,
            hntaytime,
            ipsyytmie,
            martflg,
            listagg(shinban, ',') shinban,
            sum(bosu) bosu,
            max(boskstime) boskstime,
            max(pendid) pendid,
            sum(pensu) pensu,
            min(pentime) pentime,
            min(skzflg) skzflg,
            min(canzmflg) canzmflg,
            min(m_nokishiteiyoyakuymd) m_nokishiteiyoyakuymd,
            max(syukkokan) m_pikcptime,
            max(konkan) m_paktime
        from {{ ref("tmp40_DM_TMC_IPPAN_JUTYUNOKIKAITO") }}
        group by all
    ),
    temp50 as (
        select
            sum(nyukosu) nyukosu,
            max(nyukoymd) nyukoymd,
            dlrcd,
            ordesybt,
            yusokbn,
            ordeno,
            jhinban,
            juchuymd,
            sum(syksu6) syukkasu,
            max(syukkaymd) syukkaymd
        from {{ ref("tmp50_DM_TMC_IPPAN_JUTYUNOKIKAITO") }}
        group by all
    )
select temp40.*, temp50.* exclude(dlrcd, ordesybt, yusokbn, ordeno, jhinban, juchuymd)
-- shinban.shinban
from temp40
left outer join
    temp50
    on temp40.dlrcd = temp50.dlrcd
    and temp40.syubetsu = temp50.ordesybt
    and temp40.yusokbn = temp50.yusokbn
    and temp40.odrno = temp50.ordeno
    and temp40.juchuymd = temp50.juchuymd
    and temp40.jhinban = temp50.jhinban
    -- left outer join
    -- shinban
    -- on temp40.dlrcd = shinban.dlrcd
    -- and temp40.syubetsu = shinban.syubetsu
    -- and temp40.yusokbn = shinban.yusokbn
    -- and temp40.odrno = shinban.odrno
    -- and temp40.juchuymd = shinban.juchuymd
    -- and temp40.jhinban = shinban.jhinban
    
