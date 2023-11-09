with nyusyukko as (
    select * from {{ref('nyusyukko_x_shimuke')}}
),
syukkaippan as (
    select
        dlrcd, -- 仕向先CD
        ordesybt, -- オーダー種別
        yusokbn, -- 輸送CD
        ordeno, -- 注文NO
        jhinban, -- 受注品番
        juchuymd, -- 受注日
        tkskbn, -- 一般直送区分
        shinban, -- 出荷品番
        caseno6 denno, -- ケースNO
        sum(syksu6) syukkasu, -- 出庫数_符号有
        max(syukkaymd) syukkaymd -- 出荷日
    from {{ref('stg_dvnp5770')}} -- 国内出荷実績一般
    group by all
)
select
     nyusyukko.*
    ,syukkaippan.dlrcd -- 仕向先CD
    ,syukkaippan.ordesybt -- オーダー種別
    ,syukkaippan.yusokbn -- 輸送CD
    ,syukkaippan.ordeno -- 注文NO
    ,syukkaippan.jhinban -- 受注品番
    ,syukkaippan.juchuymd -- 受注日
    ,syukkaippan.syukkasu -- 出庫数_符号有　出荷数
    ,syukkaippan.syukkaymd -- 出荷日
    ,syukkaippan.denno -- ケースNO
    ,syukkaippan.shinban -- 出荷品番
from syukkaippan
left outer join nyusyukko
on syukkaippan.dlrcd = 
   nyusyukko.kyouhan_nyuko || iff(nyusyukko.sishacd is null, '', nyusyukko.sishacd) -- 仕向先CD/共販店コード＋支社コード
and syukkaippan.ordeno = nyusyukko.chumon_no_nyuko -- 注文NO/right(リマーク2,5)
and syukkaippan.shinban = nyusyukko.hinban_nyuko -- 出荷品番/品番
and syukkaippan.syukkaymd = nyusyukko.jdate_nyuko -- 出荷日/受注日
and syukkaippan.denno = nyusyukko.dennoj_nyuko -- ケースNO/伝票№ 自拠点(イシュ№）