with
    tmp60 as (
        select
            DLRCD M_DLRCD,
            YUSOKBN M_YUSOKBN,
            ODRNO M_ORDENO,
            JUCHUYMD M_JUCHUYMD,
            JHINBAN M_JHINBAN,
            SYUBETSU M_SYUBETSU,
            SHINBAN M_SHINBAN,
            BOSU M_BOSU,
            BOSKSTIME M_BOSKSTIME,
            hnnoytime M_HNNOYTIME,
            hnsyytime M_HNSYYTIME,
            hntoytime M_HNTOYTIME,
            hsnoytime M_HSNOYTIME,
            hssyytime M_HSSYYTIME,
            MARTFLG M_MARTFLG,
            SYUKKAYMD M_SYUKKAYMD,
            SYUKKASU M_SYUKKASU,
            NYUKOYMD,
            NYUKOSU,
            KAKNOUKBN M_KAKNOUKBN,
            THIBUSYOCD M_THIBUSYOCD,
            THITATOCD M_THITATOCD,
            TEHAIKBN M_TEHAIKBN
        from {{ ref("tmp60_DM_TMC_IPPAN_JUTYUNOKIKAITO") }})
select * from tmp60
