{{ config(materialized="table") }}
with
    temp20_tehai as (
        select
            dlrcd,
            yusokbn,
            odrno,
            juchuymd,
            jhinban,
            syubetsu,
            shinban tehai_shinban,
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
            rank() over (
                partition by dlrcd, yusokbn, odrno, juchuymd, jhinban, syubetsu
                order by daitityp desc, shinban asc, ldts desc
            ) aggkey,
            row_number() over (
                partition by dlrcd, yusokbn, odrno, juchuymd, jhinban, syubetsu
                order by daitityp, shinban
            ) rownum
        from {{ ref("tmp20_dm_tmc_ippan_jutyunokikaito") }}
    )
select *
from temp20_tehai
where aggkey = 1 and rownum = 1
order by dlrcd, yusokbn, odrno, juchuymd, jhinban, syubetsu
