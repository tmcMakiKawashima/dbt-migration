{{ config(materialized='table') }}

with stg_dvnp0700 as (
    select
        rtrim(ORDRKEY,' 　')::VARCHAR(11) as ORDRKEY,  -- 英数字
        rtrim(TANSKKEY,' 　')::VARCHAR(11) as TANSKKEY,  -- 英数字
        rtrim(SHINBAN,' 　')::VARCHAR(20) as SHINBAN,  -- 英数字
        rtrim(SZHINBAN,' 　')::VARCHAR(20) as SZHINBAN,  -- 英数字
        rtrim(KAKNOUKBN,' 　')::VARCHAR(1) as KAKNOUKBN,  -- 英数字
        rtrim(BOYUSNFLG,' 　')::VARCHAR(1) as BOYUSNFLG,  -- 英数字
        rtrim(BOYUSNFTRKTIME,' 　')::VARCHAR(12) as BOYUSNFTRKTIME,  -- 英数字
        rtrim(KNKYUDO1,' 　')::VARCHAR(1) as KNKYUDO1,  -- 英数字
        rtrim(BOSKSTIMEJUN,' 　')::VARCHAR(12) as BOSKSTIMEJUN,  -- 英数字
        rtrim(KNKYUDO2,' 　')::VARCHAR(2) as KNKYUDO2,  -- 英数字
        rtrim(YUSNRNBN,' 　')::VARCHAR(6) as YUSNRNBN,  -- 英数字
        rtrim(MARTFLG,' 　')::VARCHAR(1) as MARTFLG,  -- 英数字
        rtrim(PTOPFLG,' 　')::VARCHAR(1) as PTOPFLG,  -- 英数字
        rtrim(YUSNPTRN,' 　')::VARCHAR(1) as YUSNPTRN,  -- 英数字
        rtrim(BOSELFLG,' 　')::VARCHAR(1) as BOSELFLG,  -- 英数字
        to_decimal(IFF(rtrim(SKSIJSU) = '',0,rtrim(SKSIJSU)))::DECIMAL(6) as SKSIJSU,  -- 数量／金額／数値
        rtrim(SKSIJITIME,' 　')::VARCHAR(12) as SKSIJITIME,  -- 英数字
        rtrim(TNSKSJSU,' 　')::VARCHAR(6) as TNSKSJSU,  -- 英数字
        rtrim(HZIKSJSU,' 　')::VARCHAR(6) as HZIKSJSU,  -- 英数字
        rtrim(NONYUYTISU,' 　')::VARCHAR(6) as NONYUYTISU,  -- 英数字
        to_decimal(IFF(rtrim(BOSU) = '',0,rtrim(BOSU)))::DECIMAL(6) as BOSU,  -- 数量／金額／数値
        to_decimal(IFF(rtrim(BORUISUU) = '',0,rtrim(BORUISUU)))::DECIMAL(6) as BORUISUU,  -- 数量／金額／数値
        rtrim(BOSKSTIME,' 　')::VARCHAR(12) as BOSKSTIME,  -- 英数字
        rtrim(BOKTIME,' 　')::VARCHAR(12) as BOKTIME,  -- 英数字
        rtrim(GNBKPFLG,' 　')::VARCHAR(1) as GNBKPFLG,  -- 英数字
        rtrim(PENDID,' 　')::VARCHAR(2) as PENDID,  -- 英数字
        rtrim(PENSU,' 　')::VARCHAR(6) as PENSU,  -- 英数字
        rtrim(PENTIME,' 　')::VARCHAR(12) as PENTIME,  -- 英数字
        rtrim(PEKTIME,' 　')::VARCHAR(12) as PEKTIME,  -- 英数字
        to_decimal(IFF(rtrim(CANSU) = '',0,rtrim(CANSU)))::DECIMAL(6) as CANSU,  -- 数量／金額／数値
        rtrim(CANTIME,' 　')::VARCHAR(12) as CANTIME,  -- 英数字
        to_decimal(IFF(rtrim(PLBSURYO) = '',0,rtrim(PLBSURYO)))::DECIMAL(6) as PLBSURYO,  -- 数量／金額／数値
        rtrim(PLBTIME,' 　')::VARCHAR(12) as PLBTIME,  -- 英数字
        rtrim(CASENO,' 　')::VARCHAR(8) as CASENO,  -- 英数字
        rtrim(CASECD2,' 　')::VARCHAR(2) as CASECD2,  -- 英数字
        to_decimal(IFF(rtrim(SKZUMSU) = '',0,rtrim(SKZUMSU)))::DECIMAL(6) as SKZUMSU,  -- 数量／金額／数値
        rtrim(SKZUMYMD,' 　')::VARCHAR(8) as SKZUMYMD,  -- 英数字
        rtrim(SKZTIME,' 　')::VARCHAR(12) as SKZTIME,  -- 英数字
        rtrim(SKZFLG,' 　')::VARCHAR(1) as SKZFLG,  -- 英数字
        rtrim(CANZMFLG,' 　')::VARCHAR(1) as CANZMFLG,  -- 英数字
        rtrim(BUNKATUKBN,' 　')::VARCHAR(1) as BUNKATUKBN,  -- 英数字
        rtrim(MTUSERID,' 　')::VARCHAR(16) as MTUSERID,  -- 英数字
        rtrim(MTTIME,' 　')::VARCHAR(26) as MTTIME,  -- 英数字
        rtrim(JUCHUYMD,' 　')::VARCHAR(8) as JUCHUYMD,  -- 英数字
        rtrim(DUMMY,' 　')::VARCHAR(9) as DUMMY,  -- 英数字
        LDTS, -- B層のLDTS
        RANK() over (partition by ORDRKEY, TANSKKEY, JUCHUYMD order by MTTIME desc, LDTS desc) aggkey
    from {{ ref('substr_dvnp0700') }}
)
select * from stg_dvnp0700
where aggkey = 1