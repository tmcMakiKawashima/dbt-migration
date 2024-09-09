{{ config(snowflake_warehouse='DBT_WH') }}

with tyokuso as (
    select
        dlrcd, -- 仕向先CD
        ordesybt, -- オーダー種別
        iff(yusokbn is null, '', yusokbn) yusokbn, -- 輸送CD
        ordeno, -- オーダーNO
        jhinban, -- 受注品番
        juchuymd, -- 受注日
        tkskbn, -- 一般直送区分
        shinban, -- 出荷品番
        sirissueno, -- 仕入先ISSUE_NO
        siirecd, -- 仕入先CD
        sum(syukkasu) as syukkasu, -- 出荷数（符号有）
        max(syukkaymd) as syukkaymd, -- 出荷日
        min(jusinno) as jusinno, -- 受信NO
        min(renban2) as renban2, -- 連番（直送）
        sum(juchu5) as juchu5, -- 受注数（直送）
        max(rimak1) as rimak1, -- リマークⅠ
        max(rimak2) as rimak2, -- リマークⅡ
        max(jsksyseiymd) as jsksyseiymd, -- 実績修正日
        max(ldts) ldts --union結合用
    from {{ref('stg_dvnp4330')}} -- 国内出荷実績直送
    group by
        dlrcd, -- 仕向先CD
        ordesybt, -- オーダー種別
        yusokbn, -- 輸送CD
        ordeno, -- オーダーNO
        jhinban, -- 受注品番
        juchuymd, -- 受注日
        tkskbn, -- 一般直送区分
        shinban, -- 出荷品番
        sirissueno, -- 仕入先ISSUE_NO
        siirecd -- 仕入先CD
),
shimuke as (
    select * from (
        select *,
            row_number() over (
                partition by kyouhan,sishacd 
                order by kyoten asc
            ) rownum
        from {{ref('stg_tbsmksk')}} -- 仕向先テーブル
    )
    where rownum = 1
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
    -- 先頭1レコード抽出条件
    and rownum = 1
    --
)
select
    tyokuso.* exclude(tkskbn),
    shimuke.kyoten, -- 拠点コード
    noki.nyukkten -- 入庫拠点
from tyokuso
left outer join shimuke
on
    case
        when length(tyokuso.dlrcd) >= 7 -- 仕向先コードが7桁以上の場合
        then substr(tyokuso.dlrcd, 1, 5) = shimuke.kyouhan
            and right(tyokuso.dlrcd, 2) = shimuke.sishacd
        else substr(tyokuso.dlrcd, 1, 5) = shimuke.kyouhan -- それ以外の場合
            and shimuke.sishacd = ''
    end
left outer join shimuke_noki noki
on
    case
        when length(tyokuso.dlrcd) >= 7
        then substr(tyokuso.dlrcd, 1, 5) = noki.kyouhan
            and right(tyokuso.dlrcd, 2) = noki.nokismkskcd
        else substr(tyokuso.dlrcd, 1, 5) = noki.kyouhan
            and noki.nokismkskcd = ''
    end
and try_to_date(tyokuso.juchuymd, 'yyyyMMdd') >= to_date(noki.dbt_valid_from)
and try_to_date(tyokuso.juchuymd, 'yyyyMMdd') < iff(noki.dbt_valid_to is null, '9999-12-31', to_date(noki.dbt_valid_to))