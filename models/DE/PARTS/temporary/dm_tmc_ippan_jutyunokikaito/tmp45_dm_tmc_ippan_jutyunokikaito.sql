-- データ結合４
with syukkaippan as (
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
),
shimuke as (
    select * from (
        select *,
               row_number() over (
                    partition by kyouhan, sishacd
                    order by kyoten asc
                ) rownum
        from {{ref('stg_tbsmksk')}} -- 仕向先テーブル
    )
    -- 先頭１レコード抽出条件
    where rownum = 1
    --
),
shimuke_noki as (
    select * from (
        select *,
               row_number() over (
                    partition by kyouhan, nyukkten, makercd, dbt_valid_from
                    order by ktenkbn asc, ptnno desc) rownum 
        from {{ref('scd_tbsmksk_noki')}}
    )
    where deletedate = '00000000'
    -- 先頭１レコード抽出条件
    and rownum = 1
    --
)
select 
     syukkaippan.dlrcd -- 仕向先CD
    ,syukkaippan.ordesybt -- オーダー種別
    ,syukkaippan.yusokbn -- 輸送CD
    ,syukkaippan.ordeno -- 注文NO
    ,syukkaippan.jhinban -- 受注品番
    ,syukkaippan.juchuymd -- 受注日
    ,syukkaippan.syukkasu -- 出庫数_符号有　出荷数
    ,syukkaippan.syukkaymd -- 出荷日
    ,syukkaippan.denno -- ケースNO
    ,syukkaippan.shinban -- 出荷品番
    ,shimuke.kyoten -- 拠点コード
    ,noki.nyukkten -- 入庫拠点
from syukkaippan
left outer join shimuke
    on case when length(syukkaippan.dlrcd) >= 7 -- 仕向先コードが7桁以上の場合
        then
            substr(syukkaippan.dlrcd, 1, 5) = shimuke.kyouhan 
        and right(syukkaippan.dlrcd, 2) = shimuke.sishacd 
        else                            -- それ以外の場合
            substr(syukkaippan.dlrcd, 1, 5) = shimuke.kyouhan 
        and shimuke.sishacd = '' 
    end 
left outer join shimuke_noki noki 
    on case when length(syukkaippan.dlrcd) >= 7 -- 仕向先コードが7桁以上の場合
        then 
            substr(syukkaippan.dlrcd, 1, 5) = noki.kyouhan 
        and right(syukkaippan.dlrcd, 2) = noki.nokismkskcd 
        else                            -- それ以外の場合
            substr(syukkaippan.dlrcd, 1, 5) = noki.kyouhan 
        and noki.nokismkskcd= '' 
    end
-- dbt_valid_from <= 受注日 <dbt_valid_to
and try_to_date(syukkaippan.juchuymd, 'yyyyMMdd') >= to_date(noki.dbt_valid_from)
and try_to_date(syukkaippan.juchuymd, 'yyyyMMdd') < 
    iff(noki.dbt_valid_to is null, '9999-12-31', to_date(noki.dbt_valid_to))