with temp20 as (
    select * from {{ ref('tmp20_dm_tmc_tyokuso_jutyunokikaito') }}
),
tmp10 as (
    select
        shinban, --出荷品番
        sum(nyukosu) nyukosu, --入庫数
        max(nyukoymd) nyukoymd, --入庫日
        sum(syukkasu) syukkasu, --出荷数
        max(syukkaymd) syukkaymd, --出荷日
        dlrcd, --仕向先cd
        yusokbn, --輸送cd
        ordeno, --注文no
        juchuymd, --受注日
        jhinban, --受注品番
        ordesybt, --オーダー種別
        '0', --b_o数_直送
        '', --b_o連絡日
        '', --変更後回答日
        '', --本納期回答日
        siirecd, --仕入先cd
        sum(juchu5) juchu5, --受注数（直送）
        max(rimak1) rimak1, --リマークⅰ
        max(rimak2) rimak2, --リマークⅱ
        ldts
    from {{ ref('tmp10_dm_tmc_tyokuso_jutyunokikaito') }}
    where jusinno = '' and renban2 = ''
    group by
        dlrcd, --仕向先cd
        ordesybt, --オーダー種別
        yusokbn, --輸送cd
        ordeno, --注文no
        jhinban, --受注品番
        juchuymd, --受注日
        shinban, --出荷品番
        siirecd, --仕入先cd
        ldts
)
select * from temp20
union
select * from tmp10