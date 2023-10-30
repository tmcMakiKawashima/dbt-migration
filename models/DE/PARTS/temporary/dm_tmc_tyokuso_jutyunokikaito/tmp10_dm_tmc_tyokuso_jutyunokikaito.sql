with nyusyukko as (
select
    kyouhan_nyuko, -- 共販店コード
    hinban_nyuko,  -- 品番
    dennoj_nyuko,  -- 伝票no 自拠点（イシュno）
    nyukosu,   -- 入庫数
    nyukoymd,  -- 入庫日
    jdate_nyuko,  -- 受注日
    chumon_no_nyuko,  -- リマーク2
    shimukesaki_nyuko  -- 共販店コード＋支社コード
from {{ref('nyusyukko_x_shimuke')}}
),
tyokuso as (
    select
        dlrcd,  -- 仕向先cd
        ordesybt,  -- オーダー種別
        iff(yusokbn is null, '', yusokbn) yusokbn,  -- 輸送cd
        jhinban,  -- 受注品番
        juchuymd,  -- 受注日
        ordeno,  -- 注文no
        tkskbn,  -- 一般直送区分
        shinban,  -- 出荷品番
        sum(syukkasu) syukkasu,  -- 出荷数（符号有）
        max(syukkaymd) syukkaymd,  -- 出荷日
        min(jusinno) jusinno, --受信no
        min(renban2) renban2, --連番（直送）
        sum(juchu5) juchu5, --受注数（直送）
        max(rimak1) rimak1, --リマークⅰ
        max(rimak2) rimak2, --リマークⅱ
        siirecd, --仕入先cd
        sirissueno, -- 仕入先issue_no
        max(ldts) ldts --union結合用
    from {{ref('stg_dvnp4330')}}  --国内出荷実績直送
    group by 
        dlrcd,  --仕向先cd
        ordesybt,  --オーダー種別
        yusokbn,  --輸送cd
        jhinban,  --受注品番
        juchuymd,  --受注日
        ordeno,  --注文no
        tkskbn,  --一般直送区分
        shinban,  --出荷品番
        sirissueno,  --仕入先issue_no
        siirecd --仕入先cd
)
select nyusyukko.*, tyokuso.* exclude (tkskbn)
from tyokuso
left outer join nyusyukko
on  tyokuso.dlrcd = nyusyukko.shimukesaki_nyuko  --仕向先cd/共販店コード＋支社コード
and tyokuso.ordeno = nyusyukko.chumon_no_nyuko  --注文no/right(リマーク2,5)
and tyokuso.shinban = nyusyukko.hinban_nyuko  --出荷品番/品番
and tyokuso.syukkaymd = nyusyukko.jdate_nyuko  --出荷日/受注日
and tyokuso.sirissueno = nyusyukko.dennoj_nyuko  --仕入先issue_no/伝票no 自拠点（イシュno）