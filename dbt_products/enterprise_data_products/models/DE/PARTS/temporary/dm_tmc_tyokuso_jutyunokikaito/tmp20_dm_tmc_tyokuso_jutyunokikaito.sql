{{ config(snowflake_warehouse='DBT_WH') }}

with temp15 as (
    select
        dlrcd,  --仕向先cd
        ordesybt,  --オーダー種別
        yusokbn,  --輸送cd
        ordeno,  --注文no
        jhinban,  --受注品番
        juchuymd,  --受注日
        shinban,  --出荷品番
        max(nyukoymd) nyukoymd,  --入庫日
        sum(syukkasu) syukkasu,  --出荷数
        max(syukkaymd) syukkaymd,  --出荷日
        max(jsksyseiymd) jsksyseiymd --実績修正日      
    from {{ref('tmp15_dm_tmc_tyokuso_jutyunokikaito')}}
    where jusinno <> ''
    and renban2 <> ''
    group by all
),
tyokutehai as (
    select
        dlrcd,  --仕向先cd
        iff(yusokbn is null, '', yusokbn) yusokbn,  --輸送cd
        ordeno,  --注文no
        juchuymd,  --受注日
        jhinban,  --受注品番
        ordesybt,  --オーダー種別
        sum(bosu5) bosu5,  --b_o数_直送
        max(borenymd) borenymd,  --b_o連絡日
        max(henkaiymd) henkaiymd,  --変更後回答日
        max(hnokiktymd) hnokiktymd,  --本納期回答日
        siirecd,  --仕入先cd
        sum(juchu5) juchu5,  --受注数_直送
        max(rimak1) rimak1,  --リマーク1
        max(rimak2) rimak2,  --リマーク2
        max(ldts) ldts -- snapshot作成用
    from {{ref('stg_dvnp4520')}}  --直送出荷手配
    where jusinno <> '' and renban2 <> ''
    group by all
)
select temp15.* exclude(dlrcd, yusokbn, ordeno, juchuymd, jhinban, ordesybt), tyokutehai.*
from tyokutehai
left outer join temp15
on tyokutehai.dlrcd = temp15.dlrcd --仕向先cd
and tyokutehai.ordesybt = temp15.ordesybt  --オーダー種別
and tyokutehai.yusokbn = temp15.yusokbn  --輸送cd
and tyokutehai.ordeno = temp15.ordeno  --注文no
and tyokutehai.juchuymd = temp15.juchuymd  --受注日
and tyokutehai.jhinban = temp15.jhinban  --受注品番