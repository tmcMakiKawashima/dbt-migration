with stg_dvnp4520 as (
    select
        rtrim(DATAKBN4,' 　')::VARCHAR(4) as DATAKBN4,  -- 英数字
        rtrim(JUSINNO,' 　')::VARCHAR(6) as JUSINNO,  -- 英数字
        rtrim(RENBAN2,' 　')::VARCHAR(2) as RENBAN2,  -- 英数字
        rtrim(DLRCD,' 　')::VARCHAR(7) as DLRCD,  -- 英数字
        rtrim(ORDESYBT,' 　')::VARCHAR(2) as ORDESYBT,  -- 英数字
        rtrim(YUSOKBN,' 　')::VARCHAR(1) as YUSOKBN,  -- 英数字
        rtrim(ORDENO,' 　')::VARCHAR(5) as ORDENO,  -- 英数字
        rtrim(JHINBAN,' 　')::VARCHAR(20) as JHINBAN,  -- 英数字
        to_decimal(IFF(rtrim(JUCHU5) = '',0,rtrim(JUCHU5)))::DECIMAL(5) as JUCHU5,  -- 数量／金額／数値
        rtrim(BOCD,' 　')::VARCHAR(1) as BOCD,  -- 英数字
        rtrim(RIMAK1,' 　')::VARCHAR(10) as RIMAK1,  -- 英数字
        rtrim(RIMAK2,' 　')::VARCHAR(1) as RIMAK2,  -- 英数字
        rtrim(BNRKYSCD,' 　')::VARCHAR(1) as BNRKYSCD,  -- 英数字
        rtrim(TYSSYKSITEIYMD,' 　')::VARCHAR(8) as TYSSYKSITEIYMD,  -- 英数字
        rtrim(BEKONCD,' 　')::VARCHAR(1) as BEKONCD,  -- 英数字
        rtrim(KYOSEICD,' 　')::VARCHAR(1) as KYOSEICD,  -- 英数字
        to_decimal(IFF(rtrim(TKBETTAN) = '',0,rtrim(TKBETTAN)))::DECIMAL(8) as TKBETTAN,  -- 数量／金額／数値
        to_decimal(IFF(rtrim(WARIRITU) = '',0,rtrim(WARIRITU)))::DECIMAL(4) as WARIRITU,  -- 数量／金額／数値
        rtrim(SIMKMEIJP,' 　')::VARCHAR(3) as SIMKMEIJP,  -- 英数字
        rtrim(SIMKMEIK,' 　')::VARCHAR(20) as SIMKMEIK,  -- 英数字
        rtrim(SIIRECD,' 　')::VARCHAR(4) as SIIRECD,  -- 英数字
        rtrim(SHINBAN,' 　')::VARCHAR(20) as SHINBAN,  -- 英数字
        rtrim(DAITITYP,' 　')::VARCHAR(2) as DAITITYP,  -- 英数字
        to_decimal(IFF(rtrim(SYUKASU) = '',0,rtrim(SYUKASU)))::DECIMAL(5) as SYUKASU,  -- 数量／金額／数値
        rtrim(TKSKBN,' 　')::VARCHAR(1) as TKSKBN,  -- 英数字
        rtrim(TYOSEIKYMD,' 　')::VARCHAR(8) as TYOSEIKYMD,  -- 英数字
        rtrim(TYOSEIYMD,' 　')::VARCHAR(8) as TYOSEIYMD,  -- 英数字
        rtrim(HNOKIKTYMD,' 　')::VARCHAR(8) as HNOKIKTYMD,  -- 英数字
        rtrim(HNOKKRYMD,' 　')::VARCHAR(8) as HNOKKRYMD,  -- 英数字
        rtrim(HENKAIYMD,' 　')::VARCHAR(8) as HENKAIYMD,  -- 英数字
        rtrim(HENKARYMD,' 　')::VARCHAR(8) as HENKARYMD,  -- 英数字
        to_decimal(IFF(rtrim(BOSU5) = '',0,rtrim(BOSU5)))::DECIMAL(5) as BOSU5,  -- 数量／金額／数値
        rtrim(BORENYMD,' 　')::VARCHAR(8) as BORENYMD,  -- 英数字
        to_decimal(IFF(rtrim(CANCELSU) = '',0,rtrim(CANCELSU)))::DECIMAL(5) as CANCELSU,  -- 数量／金額／数値
        rtrim(CANRRYMD,' 　')::VARCHAR(8) as CANRRYMD,  -- 英数字
        rtrim(JUCHUYMD,' 　')::VARCHAR(8) as JUCHUYMD,  -- 英数字
        rtrim(KAITOUKBN,' 　')::VARCHAR(1) as KAITOUKBN,  -- 英数字
        rtrim(SYORIYMD,' 　')::VARCHAR(8) as SYORIYMD,  -- 英数字
        to_decimal(IFF(rtrim(MISYUSU) = '',0,rtrim(MISYUSU)))::DECIMAL(5) as MISYUSU,  -- 数量／金額／数値
        rtrim(TKSSKTHIKANFLG,' 　')::VARCHAR(1) as TKSSKTHIKANFLG,  -- 英数字
        rtrim(TOKUSOKUYMD,' 　')::VARCHAR(8) as TOKUSOKUYMD,  -- 英数字
        rtrim(ISSUENO,' 　')::VARCHAR(6) as ISSUENO,  -- 英数字
        rtrim(SYOHINCD,' 　')::VARCHAR(2) as SYOHINCD,  -- 英数字
        rtrim(HINMKCD,' 　')::VARCHAR(4) as HINMKCD,  -- 英数字
        rtrim(GKKBN,' 　')::VARCHAR(1) as GKKBN,  -- 英数字
        rtrim(ENDKI,' 　')::VARCHAR(6) as ENDKI,  -- 英数字
        LDTS,  --B層のLDTS
        RANK() over (partition by JUSINNO, RENBAN2, SHINBAN, JUCHUYMD order by LDTS desc) aggkey
    from {{ ref('substr_dvnp4520') }}
)
select * from stg_dvnp4520
where aggkey = 1