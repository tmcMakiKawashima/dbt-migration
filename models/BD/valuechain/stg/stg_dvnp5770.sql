{{ config(materialized='incremental') }}

with stg_dvnp5770 as (
    select
        rtrim(MNTKBN,' 　')::VARCHAR(1) as MNTKBN,  --英数字
        rtrim(DATAKBN4,' 　')::VARCHAR(4) as DATAKBN4,  --英数字
        trim(DLRCD,' 　')::VARCHAR(7) as DLRCD,  --英数字
        rtrim(ORDESYBT,' 　')::VARCHAR(2) as ORDESYBT,  -- 英数字
        rtrim(YUSOKBN,' 　')::VARCHAR(1) as YUSOKBN,  --英数字
        rtrim(ORDENO,' 　')::VARCHAR(5) as ORDENO,  -- 英数字
        rtrim(JHINBAN,' 　')::VARCHAR(20) as JHINBAN,  -- 英数字
        to_decimal(IFF(rtrim(JUCHU5) = '',0,rtrim(JUCHU5)))::DECIMAL(5) as JUCHU5,  -- 数量／金額／数値
        rtrim(BOCD,' 　')::VARCHAR(1) as BOCD,  --英数字
        rtrim(RIMAK1,' 　')::VARCHAR(10) as RIMAK1,  -- 英数字
        rtrim(RIMAK2,' 　')::VARCHAR(1) as RIMAK2,  -- 英数字
        rtrim(BNRKYSCD,' 　')::VARCHAR(1) as BNRKYSCD,  --英数字
        rtrim(SYKSITEIYMD,' 　')::VARCHAR(8) as SYKSITEIYMD,  --英数字
        rtrim(BEKONCD,' 　')::VARCHAR(1) as BEKONCD,  --英数字
        rtrim(KYOSEICD,' 　')::VARCHAR(1) as KYOSEICD,  --英数字
        to_decimal(IFF(rtrim(TKBETTAN) = '',0,rtrim(TKBETTAN)))::DECIMAL(8) as TKBETTAN,  -- 数量／金額／数値
        rtrim(WARIRITU,' 　')::VARCHAR(4) as WARIRITU,  --英数字
        rtrim(JUCHUKAITOCD,' 　')::VARCHAR(2) as JUCHUKAITOCD,   --英数字
        rtrim(SYORIYMD,' 　')::VARCHAR(8) as SYORIYMD,  --英数字
        rtrim(JUCHUYMD,' 　')::VARCHAR(8) as JUCHUYMD,  --英数字
        rtrim(SIMKMEIJP6,' 　')::VARCHAR(3) as SIMKMEIJP6,  -- 英数字
        rtrim(SIMKMEIK,' 　')::VARCHAR(20) as SIMKMEIK,  -- 英数字
        rtrim(GYOSYACD,' 　')::VARCHAR(2) as GYOSYACD,  --英数字
        rtrim(TKSKBN,' 　')::VARCHAR(1) as TKSKBN,  --英数字
        rtrim(SYKKANOKBN,' 　')::VARCHAR(1) as SYKKANOKBN,  --英数字
        rtrim(KYOTNKBN,' 　')::VARCHAR(1) as KYOTNKBN,  --英数字
        rtrim(SHINBAN,' 　')::VARCHAR(20) as SHINBAN,  -- 英数字
        rtrim(DAITITYP,' 　')::VARCHAR(2) as DAITITYP,  -- 英数字
        to_decimal(IFF(rtrim(PROJUSUU) = '',0,rtrim(PROJUSUU)))::DECIMAL(5) as PROJUSUU,  -- 数量／金額／数値
        rtrim(BOSELFLG,' 　')::VARCHAR(1) as BOSELFLG,  --英数字
        rtrim(KKNOKGCD,' 　')::VARCHAR(2) as KKNOKGCD,  --英数字
        rtrim(KOSOKBN,' 　')::VARCHAR(1) as KOSOKBN,  --英数字
        rtrim(PICLOKE,' 　')::VARCHAR(10) as PICLOKE,  -- 英数字
        rtrim(RESVLOKE,' 　')::VARCHAR(10) as RESVLOKE,  -- 英数字
        rtrim(BUNSUU7,' 　')::VARCHAR(7) as BUNSUU7,  --英数字
        to_decimal(IFF(rtrim(SYKSU6) = '',0,rtrim(SYKSU6)))::DECIMAL(6) as SYKSU6,  -- 数量／金額／数値
        rtrim(CASECD,' 　')::VARCHAR(2) as CASECD,  --英数字
        rtrim(TOKSGODRGRPNO,' 　')::VARCHAR(1) as TOKSGODRGRPNO,  -- 英数字
        rtrim(SYKIKICD,' 　')::VARCHAR(2) as SYKIKICD,  --英数字
        rtrim(ZOON,' 　')::VARCHAR(3) as ZOON,  -- 英数字
        rtrim(PCPSYUYAKKBN,' 　')::VARCHAR(1) as PCPSYUYAKKBN,  --英数字
        rtrim(LBLSYUTUBASYO,' 　')::VARCHAR(2) as LBLSYUTUBASYO,  -- 英数字
        rtrim(TANDKSYUKKOKBN,' 　')::VARCHAR(1) as TANDKSYUKKOKBN,  --英数字
        to_decimal(IFF(rtrim(YOSEKI10) = '',0,rtrim(YOSEKI10)))::DECIMAL(10) as YOSEKI10,  -- 数量／金額／数値
        to_decimal(IFF(rtrim(SEJYRO) = '',0,rtrim(SEJYRO)))::DECIMAL(5) as SEJYRO,  -- 数量／金額／数値
        rtrim(NRYKIJUNGENTANI,' 　')::VARCHAR(1) as NRYKIJUNGENTANI,  --英数字
        rtrim(NRYKIJUNTI,' 　')::VARCHAR(5) as NRYKIJUNTI,  --英数字
        rtrim(PENFLG,' 　')::VARCHAR(1) as PENFLG,  --英数字
        rtrim(CYCLRENBAN,' 　')::VARCHAR(8) as CYCLRENBAN,  -- 英数字
        rtrim(SZYORYO4,' 　')::VARCHAR(4) as SZYORYO4,  --英数字
        rtrim(CASEW,' 　')::VARCHAR(3) as CASEW,  --英数字
        rtrim(HASUCOREKBN,' 　')::VARCHAR(1) as HASUCOREKBN,  --英数字
        rtrim(KYOSEIKBN,' 　')::VARCHAR(1) as KYOSEIKBN,  --英数字
        rtrim(PTOPFLG,' 　')::VARCHAR(1) as PTOPFLG,  --英数字
        rtrim(BINNO,' 　')::VARCHAR(3) as BINNO,  -- 英数字
        rtrim(YUSOKBN2,' 　')::VARCHAR(1) as YUSOKBN2,  --英数字
        rtrim(BINPTN,' 　')::VARCHAR(2) as BINPTN,  -- 英数字
        rtrim(ITEMPIECEKBN,' 　')::VARCHAR(1) as ITEMPIECEKBN,  --英数字
        rtrim(CORESKSMINTI,' 　')::VARCHAR(5) as CORESKSMINTI,  --英数字
        rtrim(CORESKSMAXTI,' 　')::VARCHAR(5) as CORESKSMAXTI,  --英数字
        rtrim(BUTURYUNO8,' 　')::VARCHAR(8) as BUTURYUNO8,  -- 英数字
        rtrim(SYKNO,' 　')::VARCHAR(5) as SYKNO,  -- 英数字
        rtrim(SIIRECD,' 　')::VARCHAR(4) as SIIRECD,  --英数字
        rtrim(KAKNOUSUKBN,' 　')::VARCHAR(1) as KAKNOUSUKBN,  --英数字
        rtrim(SYUKKODOMEFLG,' 　')::VARCHAR(1) as SYUKKODOMEFLG,  --英数字
        rtrim(SNTKKBN,' 　')::VARCHAR(1) as SNTKKBN,  --英数字
        rtrim(SJYUNI3,' 　')::VARCHAR(3) as SJYUNI3,  --英数字
        rtrim(FILLER,' 　')::VARCHAR(38) as FILLER,  -- 英数字
        rtrim(CASENO6,' 　')::VARCHAR(6) as CASENO6,  -- 英数字
        to_decimal(IFF(rtrim(KJNHANKA) = '',0,rtrim(KJNHANKA)))::DECIMAL(8) as KJNHANKA,  -- 数量／金額／数値
        rtrim(SYOHINCD,' 　')::VARCHAR(2) as SYOHINCD,  --英数字
        rtrim(HINMKCD,' 　')::VARCHAR(4) as HINMKCD,  --英数字
        rtrim(TKYTNKBN,' 　')::VARCHAR(1) as TKYTNKBN,  --英数字
        to_decimal(IFF(rtrim(SYKZMKINF) = '',0,rtrim(SYKZMKINF)))::DECIMAL(10) as SYKZMKINF,  -- 数量／金額／数値
        to_decimal(IFF(rtrim(HAISOUSYOKAKEF) = '',0,rtrim(HAISOUSYOKAKEF)))::DECIMAL(8) as HAISOUSYOKAKEF,  -- 数量／金額／数値
        to_decimal(IFF(rtrim(KKHTESURYOF) = '',0,rtrim(KKHTESURYOF)))::DECIMAL(8) as KKHTESURYOF,  -- 数量／金額／数値
        rtrim(SYKKAITOCD,' 　')::VARCHAR(1) as SYKKAITOCD,  --英数字
        rtrim(SUTEIKBN,' 　')::VARCHAR(1) as SUTEIKBN,  --英数字
        rtrim(JSKDATAKBN,' 　')::VARCHAR(1) as JSKDATAKBN,  --英数字
        rtrim(JSKSYSEIYMD,' 　')::VARCHAR(8) as JSKSYSEIYMD,  --英数字
        rtrim(HANKAKETTEIYMD,' 　')::VARCHAR(8) as HANKAKETTEIYMD,  --英数字
        rtrim(HANKAMITEIHSICD,' 　')::VARCHAR(1) as HANKAMITEIHSICD,  --英数字
        rtrim(SYUKKAYMD,' 　')::VARCHAR(8) as SYUKKAYMD,  --英数字
        rtrim(PTOPNNKYOTEN,' 　')::VARCHAR(1) as PTOPNNKYOTEN,  -- 英数字
        rtrim(DATAID3,' 　')::VARCHAR(3) as DATAID3,  -- 英数字
        rtrim(CPUTIMEHMS,' 　')::VARCHAR(6) as CPUTIMEHMS,  --英数字
        rtrim(IKO15JIFLG,' 　')::VARCHAR(1) as IKO15JIFLG,  --英数字
        rtrim(ERMSG15,' 　')::VARCHAR(15) as ERMSG15,  -- 英数字
        rtrim(ATESKCD,' 　')::VARCHAR(5) as ATESKCD,  --英数字
        rtrim(FILLER2,' 　')::VARCHAR(49) as FILLER2,  -- 英数字
        LDTS 
    from {{ ref('substr_dvnp5770') }}
)
select * from stg_dvnp5770

{% if is_incremental() %}

  where LDTS > (select max(LDTS) from {{this}})

{% endif %}