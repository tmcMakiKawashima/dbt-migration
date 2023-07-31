with temp10 as (
    select
        DLRCD,  --仕向先CD
        ORDESYBT,  --オーダー種別
        YUSOKBN,  --輸送CD
        JUCHUYMD,  --受注日
        ORDENO,  --注文No
        max(NYUKOYMD) NYUKOYMD,  --入庫日
        sum(NYUKOSU) NYUKOSU,  --入庫数
        JHINBAN,  --受注品番
        listagg(distinct(SHINBAN), ',') SHINBAN,  --出荷品番
        sum(SYUKKASU) SYUKKASU,  --出荷数
        max(SYUKKAYMD) SYUKKAYMD  --出荷日      
    from {{ref('tmp10_dm_tmc_tyokuso_jutyunokikaito')}}
    group by 
            DLRCD,  --仕向先CD
            ORDESYBT, --オーダー種別
            YUSOKBN, --輸送CD
            ORDENO, --注文No
            JHINBAN, --受注品番
            JUCHUYMD  --受注日
),
tyokutehai as (
    select
        DLRCD tehai_DLRCD,  --仕向先CD
        IFF(YUSOKBN is null, '', YUSOKBN) tehai_YUSOKBN,  --輸送CD
        ORDENO tehai_ORDENO,  --注文No
        JUCHUYMD tehai_JUCHUYMD,  --受注日
        JHINBAN tehai_JHINBAN,  --受注品番
        ORDESYBT tehai_ORDESYBT,  --オーダー種別
        sum(BOSU5) BOSU5,  --B_O数_直送
        max(BORENYMD) BORENYMD,  --B_O連絡日
        max(HENKAIYMD) HENKAIYMD,  --変更後回答日
        max(HNOKIKTYMD) HNOKIKTYMD,  --本納期回答日
        SIIRECD,  --仕入先CD
        sum(JUCHU5) JUCHU5,  --受注数_直送
        max(RIMAK1) RIMAK1,  --リマーク1
        max(RIMAK2) RIMAK2  --リマーク2
    from {{ref('stg_dvnp4520')}}  --直送出荷手配
    group by
        DLRCD,  --仕向先CD
        YUSOKBN,  --輸送CD
        ORDENO,  --注文NO
        JUCHUYMD,  --受注日
        JHINBAN,  --受注品番
        ORDESYBT,  --オーダー種別
        SIIRECD  --仕入先CD
)
select temp10.*, tyokutehai.*
from tyokutehai
left outer join temp10
on tyokutehai.tehai_DLRCD = temp10.DLRCD --仕向先CD
and tyokutehai.tehai_ORDESYBT = temp10.ORDESYBT  --オーダー種別
and tyokutehai.tehai_YUSOKBN = temp10.YUSOKBN  --輸送CD
and tyokutehai.tehai_ORDENO = temp10.ORDENO  --注文No
and tyokutehai.tehai_JUCHUYMD = temp10.JUCHUYMD  --受注日
and tyokutehai.tehai_JHINBAN = temp10.JHINBAN  --受注品番