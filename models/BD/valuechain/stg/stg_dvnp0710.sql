with stg_dvnp0710 as (
    select
        rtrim(MNTKBN,' 　')::VARCHAR(1) as MNTKBN,  -- 英数字
        rtrim(ORDRKEY,' 　')::VARCHAR(11) as ORDRKEY,  -- 英数字
        rtrim(JURRSYMD,' 　')::VARCHAR(8) as JURRSYMD,  -- 英数字
        rtrim(TANSKKEY,' 　')::VARCHAR(11) as TANSKKEY,  -- 英数字
        rtrim(SHINBAN,' 　')::VARCHAR(20) as SHINBAN,  -- 英数字
        rtrim(DLRCD,' 　')::VARCHAR(7) as DLRCD,  -- 英数字
        rtrim(ODRNO,' 　')::VARCHAR(8) as ODRNO,  -- 英数字
        rtrim(ITEMNO,' 　')::VARCHAR(4) as ITEMNO,  -- 英数字
        rtrim(KOKAGKBN,' 　')::VARCHAR(1) as KOKAGKBN,  -- 英数字
        rtrim(YUSOKBN,' 　')::VARCHAR(1) as YUSOKBN,  -- 英数字
        rtrim(SYUBETSU,' 　')::VARCHAR(2) as SYUBETSU,  -- 英数字
        rtrim(ORDRTYPE,' 　')::VARCHAR(1) as ORDRTYPE,  -- 英数字
        rtrim(ORDTSYRI,' 　')::VARCHAR(1) as ORDTSYRI,  -- 英数字
        rtrim(KNKYUDO1,' 　')::VARCHAR(1) as KNKYUDO1,  -- 英数字
        rtrim(ODRZOK,' 　')::VARCHAR(1) as ODRZOK,  -- 英数字
        to_decimal(IFF(rtrim(BOSU) = '',0,rtrim(BOSU)))::DECIMAL(6) as BOSU,  -- 数量／金額／数値
        rtrim(JUCHUYMD,' 　')::VARCHAR(8) as JUCHUYMD,  -- 英数字
        to_decimal(IFF(rtrim(JUCHUSU) = '',0,rtrim(JUCHUSU)))::DECIMAL(6) as JUCHUSU,  -- 数量／金額／数値
        to_decimal(IFF(rtrim(SYYHENCT) = '',0,rtrim(SYYHENCT)))::DECIMAL(3) as SYYHENCT,  -- 数量／金額／数値
        to_decimal(IFF(rtrim(ETDHENCT) = '',0,rtrim(ETDHENCT)))::DECIMAL(3) as ETDHENCT,  -- 数量／金額／数値
        rtrim(MKAITOCD,' 　')::VARCHAR(1) as MKAITOCD,  -- 英数字
        rtrim(HNKKBN,' 　')::VARCHAR(1) as HNKKBN,  -- 英数字
        rtrim(HNNOYTIME,' 　')::VARCHAR(12) as HNNOYTIME,  -- 英数字
        rtrim(HNTAYTIME,' 　')::VARCHAR(12) as HNTAYTIME,  -- 英数字
        rtrim(HNSYYTIME,' 　')::VARCHAR(12) as HNSYYTIME,  -- 英数字
        rtrim(HNTOYTIME,' 　')::VARCHAR(12) as HNTOYTIME,  -- 英数字
        rtrim(HNKTOYMD,' 　')::VARCHAR(8) as HNKTOYMD,  -- 英数字
        rtrim(ENKKBN,' 　')::VARCHAR(1) as ENKKBN,  -- 英数字
        rtrim(ENFYTYMD,' 　')::VARCHAR(8) as ENFYTYMD,  -- 英数字
        rtrim(ENKTOYMD,' 　')::VARCHAR(8) as ENKTOYMD,  -- 英数字
        rtrim(HOKKBN,' 　')::VARCHAR(1) as HOKKBN,  -- 英数字
        rtrim(HONOYTIME,' 　')::VARCHAR(12) as HONOYTIME,  -- 英数字
        rtrim(HOTAYTIME,' 　')::VARCHAR(12) as HOTAYTIME,  -- 英数字
        rtrim(HOSYYTIME,' 　')::VARCHAR(12) as HOSYYTIME,  -- 英数字
        rtrim(HOTOYTIME,' 　')::VARCHAR(12) as HOTOYTIME,  -- 英数字
        rtrim(HOKTOYMD,' 　')::VARCHAR(8) as HOKTOYMD,  -- 英数字
        rtrim(EOKKBN,' 　')::VARCHAR(1) as EOKKBN,  -- 英数字
        rtrim(EOFYTYMD,' 　')::VARCHAR(8) as EOFYTYMD,  -- 英数字
        rtrim(EOKTOYMD,' 　')::VARCHAR(8) as EOKTOYMD,  -- 英数字
        rtrim(HSKKBN,' 　')::VARCHAR(1) as HSKKBN,  -- 英数字
        rtrim(HSNOYTIME,' 　')::VARCHAR(12) as HSNOYTIME,  -- 英数字
        rtrim(HSTAYTIME,' 　')::VARCHAR(12) as HSTAYTIME,  -- 英数字
        rtrim(HSSYYTIME,' 　')::VARCHAR(12) as HSSYYTIME,  -- 英数字
        rtrim(HSTOYTIME,' 　')::VARCHAR(12) as HSTOYTIME,  -- 英数字
        rtrim(HSKTOYMD,' 　')::VARCHAR(8) as HSKTOYMD,  -- 英数字
        rtrim(ESKKBN,' 　')::VARCHAR(1) as ESKKBN,  -- 英数字
        rtrim(ESFYTYMD,' 　')::VARCHAR(8) as ESFYTYMD,  -- 英数字
        rtrim(ESKTOYMD,' 　')::VARCHAR(8) as ESKTOYMD,  -- 英数字
        rtrim(PTOPFLG,' 　')::VARCHAR(1) as PTOPFLG,  -- 英数字
        rtrim(MARTFLG,' 　')::VARCHAR(1) as MARTFLG,  -- 英数字
        rtrim(SKJUNI,' 　')::VARCHAR(6) as SKJUNI,  -- 英数字
        rtrim(KAKNOUKBN,' 　')::VARCHAR(1) as KAKNOUKBN,  -- 英数字
        rtrim(IPSYYTMIE,' 　')::VARCHAR(12) as IPSYYTMIE,  -- 英数字
        rtrim(IPFYTYMD,' 　')::VARCHAR(8) as IPFYTYMD,  -- 英数字
        rtrim(MTUSERID,' 　')::VARCHAR(16) as MTUSERID,  -- 英数字
        rtrim(MTTIME,' 　')::VARCHAR(26) as MTTIME,  -- 英数字
        rtrim(FILLER,' 　')::VARCHAR(12) as FILLER,  -- 英数字
        LDTS, -- B層のLDTS
        RANK() over (partition by ORDRKEY, JURRSYMD, TANSKKEY order by MTTIME desc, LDTS desc) aggkey
    from {{ ref('substr_dvnp0710') }}
)
select * from stg_dvnp0710
where aggkey = 1