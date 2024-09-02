{{ config(materialized='incremental', snowflake_warehouse='DBT_WH') }}

with stg_dvnp4330 as (
    select
        rtrim(MNTKBN,' 　')::VARCHAR(1) as MNTKBN,  --英数字
        rtrim(DATAKBN4,' 　')::VARCHAR(4) as DATAKBN4,  --英数字
        rtrim(SIIRECD,' 　')::VARCHAR(4) as SIIRECD,  --英数字
        rtrim(EGSCD1,' 　')::VARCHAR(1) as EGSCD1,  --英数字
        rtrim(JUSINNO,' 　')::VARCHAR(6) as JUSINNO,  --英数字
        rtrim(RENBAN2,' 　')::VARCHAR(2) as RENBAN2,  --英数字
        rtrim(DLRCD,' 　')::VARCHAR(7) as DLRCD,  --英数字
        rtrim(ORDESYBT,' 　')::VARCHAR(2) as ORDESYBT,  --英数字
        rtrim(YUSOKBN,' 　')::VARCHAR(1) as YUSOKBN,  --英数字
        rtrim(JUCHUYMD,' 　')::VARCHAR(8) as JUCHUYMD,  --英数字
        rtrim(ORDENO,' 　')::VARCHAR(5) as ORDENO,  --英数字
        rtrim(SHINBAN,' 　')::VARCHAR(20) as SHINBAN,  --英数字
        to_decimal(IFF(rtrim(SYUKKASU) = '',0,rtrim(SYUKKASU)))::DECIMAL(6) as SYUKKASU,  --数量/金額/数値
        rtrim(SYUKKAYMD,' 　')::VARCHAR(8) as SYUKKAYMD,  --英数字
        rtrim(KAITOUKBN,' 　')::VARCHAR(1)  as KAITOUKBN,  --英数字
        rtrim(DAITITYP,' 　')::VARCHAR(2) as DAITITYP,  --英数字
        rtrim(SIRISSUENO,' 　')::VARCHAR(6) as SIRISSUENO,  --英数字
        rtrim(NOUBAN,' 　')::VARCHAR(6) as NOUBAN,  --英数字
        rtrim(SYKNO,' 　')::VARCHAR(5) as SYKNO,  --英数字
        rtrim(GKKBNG,' 　')::VARCHAR(1)  as GKKBNG,  --英数字
        rtrim(GKUBNKKYMD,' 　')::VARCHAR(8) as GKUBNKKYMD,  --英数字
        rtrim(GKKBNN,' 　')::VARCHAR(1) as GKKBNN,  --英数字
        rtrim(JUCHUKAITOCD,' 　')::VARCHAR(2) as JUCHUKAITOCD,  --英数字
        rtrim(SIRREJECTCD,' 　')::VARCHAR(1) as SIRREJECTCD,  --英数字
        rtrim(SIMKMEIK,' 　')::VARCHAR(20) as SIMKMEIK,  --英数字
        rtrim(JSKDATAKBN,' 　')::VARCHAR(1)  as JSKDATAKBN,  --英数字
        rtrim(SUTEIKBN,' 　')::VARCHAR(1)  as SUTEIKBN,  --英数字
        rtrim(JHINBAN,' 　')::VARCHAR(20) as JHINBAN,  --英数字
        to_decimal(IFF(rtrim(JUCHU5) = '',0,rtrim(JUCHU5)))::DECIMAL(5) as JUCHU5,  --数量/金額/数値
        rtrim(BOCD,' 　')::VARCHAR(1)  as BOCD,  --英数字
        rtrim(RIMAK1,' 　')::VARCHAR(10) as RIMAK1,  --英数字
        rtrim(BNRKYSCD,' 　')::VARCHAR(1)  as BNRKYSCD,  --英数字
        rtrim(RIMAK2,' 　')::VARCHAR(1)  as RIMAK2,  --英数字
        rtrim(TKYTNKBN,' 　')::VARCHAR(1)  as TKYTNKBN,  --英数字
        to_decimal(IFF(rtrim(TANKA8)= '',0,rtrim(TANKA8)))::DECIMAL(8) as TANKA8,  --数量/金額/数値
        to_decimal(IFF(rtrim(SYKZMKINF) = '',0,rtrim(SYKZMKINF)))::DECIMAL(10) as SYKZMKINF,  --数量/金額/数値
        to_decimal(IFF(rtrim(HAISOUSYOKAKEF) = '',0,rtrim(HAISOUSYOKAKEF)))::DECIMAL(8) as HAISOUSYOKAKEF,  --数量/金額/数値
        to_decimal(IFF(rtrim(KKHTESURYOF) = '',0,rtrim(KKHTESURYOF)))::DECIMAL(8) as KKHTESURYOF,  --数量/金額/数値
        rtrim(SYOHINCD,' 　')::VARCHAR(2) as SYOHINCD,  --英数字
        rtrim(HINMKCD,' 　')::VARCHAR(4) as HINMKCD,  --英数字
        rtrim(SYKKAITOCD,' 　')::VARCHAR(1)  as SYKKAITOCD,  --英数字
        rtrim(HANKAMITEIHSICD,' 　')::VARCHAR(1)  as HANKAMITEIHSICD,  --英数字
        rtrim(TKSKBN,' 　')::VARCHAR(1)  as TKSKBN,  --英数字
        rtrim(HANKAKETTEIYMD,' 　')::VARCHAR(8) as HANKAKETTEIYMD,  --英数字
        rtrim(JSKSYSEIYMD,' 　')::VARCHAR(8) as JSKSYSEIYMD,  --英数字
        to_decimal(IFF(rtrim(TKBETTAN) = '',0,rtrim(TKBETTAN)))::DECIMAL(8) as TKBETTAN,  --数量/金額/数値
        to_decimal(IFF(rtrim(WARIRITU) = '',0,rtrim(WARIRITU)))::DECIMAL(4) as WARIRITU,  --数量/金額/数値
        rtrim(IRAIDTKANRINO,' 　')::VARCHAR(6) as IRAIDTKANRINO,  --英数字
        rtrim(FILLER,' 　')::VARCHAR(24) as FILLER,  --英数字
        LDTS
    from {{ ref('substr_dvnp4330') }}
)
select * from stg_dvnp4330

{% if is_incremental() %}
    where LDTS > (select max(LDTS) from {{this}})
{% endif %}