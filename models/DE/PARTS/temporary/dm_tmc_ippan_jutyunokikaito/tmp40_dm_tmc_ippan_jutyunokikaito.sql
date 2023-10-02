with nyusyukko as (
    select * from {{ref('nyusyukko_x_shimuke')}}
),
syukkaippan as (
    select
        DLRCD, -- 仕向先CD
        ORDESYBT, -- オーダー種別
        YUSOKBN, -- 輸送CD
        ORDENO, -- 注文NO
        JHINBAN, -- 受注品番
        JUCHUYMD, -- 受注日
        SHINBAN, -- 出荷品番
        SUM(SYKSU6) SYUKKASU, -- 出庫数_符号有　出荷数
        MAX(SYUKKAYMD) SYUKKAYMD, -- 出荷日
        CASENO6 DENNO -- ケースNO
    from {{ref('stg_dvnp5770')}} -- 国内出荷実績一般
    group by
        DLRCD, -- 仕向先CD
        ORDESYBT, -- オーダー種別
        YUSOKBN, -- 輸送CD
        ORDENO, -- 注文NO
        JHINBAN, -- 受注品番
        JUCHUYMD, -- 受注日
        TKSKBN, -- 一般直送区分
        SHINBAN, -- 出荷品番
        CASENO6 -- ケースNO
)
select
     nyusyukko.*
    ,syukkaippan.DLRCD -- 仕向先CD
    ,syukkaippan.ORDESYBT -- オーダー種別
    ,syukkaippan.YUSOKBN -- 輸送CD
    ,syukkaippan.ORDENO -- 注文NO
    ,syukkaippan.JHINBAN -- 受注品番
    ,syukkaippan.JUCHUYMD -- 受注日
    ,syukkaippan.SYUKKASU -- 出庫数_符号有　出荷数
    ,syukkaippan.SYUKKAYMD -- 出荷日
    ,syukkaippan.CASENO6 -- ケースNO
from syukkaippan
left outer join nyusyukko
on syukkaippan.DLRCD = nyusyukko.SHIMUKESAKI_NYUKO -- 仕向先CD/共販店コード＋支社コード
and syukkaippan.ORDENO = nyusyukko.CHUMON_NO_NYUKO -- 注文No/Right(リマーク2,5)
and syukkaippan.SHINBAN = nyusyukko.HINBAN_NYUKO -- 出荷品番/品番
and syukkaippan.SYUKKAYMD = nyusyukko.JDATE_NYUKO -- 出荷日/受注日
and syukkaippan.DENNO = nyusyukko.DENNOJ_NYUKO -- ケースNo/伝票№ 自拠点(イシュ№）