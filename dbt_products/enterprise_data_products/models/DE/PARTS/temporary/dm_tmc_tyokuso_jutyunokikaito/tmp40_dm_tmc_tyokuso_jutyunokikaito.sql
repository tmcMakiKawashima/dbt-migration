{{ config(snowflake_warehouse='DBT_WH') }}

with temp30 as (
    select * from {{ ref('tmp30_dm_tmc_tyokuso_jutyunokikaito') }}
),
syukkabin_1 as (
    select
        dlrcd, --仕向先cd
        syubetsu, --オーダー種別
        yusokbn, --輸送区分
        max(keikanissu) keikanissu --経過日数
    from {{ ref('stg_cvn35dsyukabin') }}
    group by all
),
syukkabin_2 as (
    select
        dlrcd, --仕向先cd
        yusokbn, --輸送区分
        max(keikanissu) keikanissu --経過日数
    from {{ ref('stg_cvn35dsyukabin') }}
    group by all
)
select
    temp30.*,
    case
        when
            (temp30.siirecd in ('4033', '2281'))
            and trim(syukkabin_1.keikanissu) is not null --仕入先cdが'4033'か'2281'かつ出荷便tbl1.［経過日数］がnullでない
        then 
            syukkabin_1.keikanissu --出荷便tbl1.［経過日数］を「経過日数」として取得
        when
            (temp30.siirecd in ('4033', '2281'))
            and trim(syukkabin_1.keikanissu) is null
            and trim(syukkabin_2.keikanissu) is not null --仕入先cdが'4033'か'2281'かつ出荷便tbl1.[経過日数]がnullかつ出荷便tbl2.[経過日数]がnullでない
        then
            syukkabin_2.keikanissu --出荷便tbl2.[経過日数]を「経過日数」として取得
        when
            (temp30.siirecd not in ('4033', '2281'))
            and substr(temp30.dlrcd, 1, 5) = '85121' --[仕向先cd]の先頭5桁が'85121'の場合
        then
            '2' --固定値'2'を「経過日数」として取得
        when
            (temp30.siirecd not in ('4033', '2281'))
            and substr(temp30.dlrcd, 1, 5) = '85911' --[仕向先cd]の先頭5桁が'85911'の場合
        then
            '8' --固定値'8'を「経過日数」として取得
        else --上記「仕向先cd」以外
            '1' --固定値'1'を「経過日数」として取得
    end keikanissu
    from temp30
    left outer join 
        syukkabin_1 
        on temp30.dlrcd = syukkabin_1.dlrcd
        and temp30.ordesybt = syukkabin_1.syubetsu
        and iff(temp30.yusokbn = '1', '1', '*') = syukkabin_1.yusokbn
    left outer join
        syukkabin_2
        on 
        temp30.dlrcd = syukkabin_2.dlrcd
        and iff(temp30.yusokbn = '1', '1', '*') = syukkabin_2.yusokbn