with temp30 as (
    select
        DLRCD,
        YUSOKBN,
        ODRNO,
        JUCHUYMD,
        JHINBAN,
        SYUBETSU,
        listagg(distinct(SHINBAN), ',') SHINBAN,
        sum(BOSU) BOSU,
        max(BOSKSTIME) BOSKSTIME,
        max(HNNOYTIME) HNNOYTIME,
        max(HNSYYTIME) HNSYYTIME,
        max(HNTOYTIME) HNTOYTIME,
        max(HSNOYTIME) HSNOYTIME,
        max(HSSYYTIME) HSSYYTIME,
        max(MARTFLG) MARTFLG,
        KAKUNOUKBN,
        SIIRECD
    from {{ref('tmp30_DM_TMC_IPPAN_JUTYUNOKIKAITO')}}
    group by DLRCD, YUSOKBN, ODRNO, JUCHUYMD, JHINBAN, SYUBETSU, KAKUNOUKBN, SIIRECD
),
temp40 as (
    select
        sum(NYUKOSU) NYUKOSU,
        max(NYUKOYMD) NYUKOYMD,
        DLRCD,
        ORDESYBT,
        YUSOKBN,
        ORDENO,
        JHINBAN,
        JUCHUYMD,
        sum(SYUKKASU) SYUKKASU,
        max(SYUKKAYMD) SYUKKAYMD
    from {{ref('tmp40_DM_TMC_IPPAN_JUTYUNOKIKAITO')}}
    group by DLRCD, ORDESYBT, YUSOKBN, ORDENO, JHINBAN, JUCHUYMD
)
select temp30.*, temp40.NYUKOSU, temp40.NYUKOYMD,temp40.SYUKKASU, temp40.SYUKKAYMD
from temp30
left outer join temp40
on temp30.DLRCD = temp40.DLRCD
and temp30.SYUBETSU = temp40.ORDESYBT
and temp30.YUSOKBN = temp40.YUSOKBN
and temp30.ODRNO = temp40.ORDENO
and temp30.JUCHUYMD = temp40.JUCHUYMD
and temp30.JHINBAN = temp40.JHINBAN
