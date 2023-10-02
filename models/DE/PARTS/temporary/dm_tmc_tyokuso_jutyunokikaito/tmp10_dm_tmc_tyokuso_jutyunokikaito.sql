with nyusyukko as (
select
    KYOUHAN_NYUKO, -- 共販店コード
    HINBAN_NYUKO,  -- 品番
    DENNOJ_NYUKO,  -- 伝票No 自拠点（イシュNo）
    NYUKOSU,   -- 入庫数
    NYUKOYMD,  -- 入庫日
    JDATE_NYUKO,  -- 受注日
    CHUMON_NO_NYUKO,  -- リマーク2
    SHIMUKESAKI_NYUKO  -- 共販店コード＋支社コード
from {{ref('nyusyukko_x_shimuke')}}
),
tyokuso as (
    select
        DLRCD,  -- 仕向先CD
        ORDESYBT,  -- オーダー種別
        IFF(YUSOKBN is null, '', YUSOKBN) YUSOKBN,  -- 輸送CD
        JHINBAN,  -- 受注品番
        JUCHUYMD,  -- 受注日
        ORDENO,  -- 注文NO
        TKSKBN,  -- 一般直送区分
        SHINBAN,  -- 出荷品番
        sum(SYUKKASU) SYUKKASU,  -- 出荷数（符号有）
        max(SYUKKAYMD) SYUKKAYMD,  -- 出荷日
        SIRISSUENO -- 仕入先ISSUE_NO
    from {{ref('stg_dvnp4330')}}  --国内出荷実績直送
    group by 
        DLRCD,  --仕向先CD
        ORDESYBT,  --オーダー種別
        YUSOKBN,  --輸送CD
        JHINBAN,  --受注品番
        JUCHUYMD,  --受注日
        ORDENO,  --注文No
        TKSKBN,  --一般直送区分
        SHINBAN,  --出荷品番
        SIRISSUENO  --仕入先ISSUE_NO
)
select nyusyukko.* exclude SHIMUKESAKI_NYUKO, tyokuso.* exclude (TKSKBN)
from tyokuso
left outer join nyusyukko
on  tyokuso.DLRCD = nyusyukko.SHIMUKESAKI_NYUKO  --仕向先CD/共販店コード＋支社コード
and tyokuso.ORDENO = nyusyukko.CHUMON_NO_NYUKO  --注文No/RIGHT(リマーク2,5)
and tyokuso.SHINBAN = nyusyukko.HINBAN_NYUKO  --出荷品番/品番
and tyokuso.SYUKKAYMD = nyusyukko.JDATE_NYUKO  --出荷日/受注日
and tyokuso.SIRISSUENO = nyusyukko.DENNOJ_NYUKO  --仕入先ISSUE_NO/伝票No 自拠点（イシュNo）