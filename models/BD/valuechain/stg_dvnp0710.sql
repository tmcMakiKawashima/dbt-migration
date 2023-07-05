{{ config(materialized='table') }}

with stg_dvnp0710 as (
    select
        IFF(rtrim(MNTKBN) = '','',LPAD(rtrim(MNTKBN),length(MNTKBN),'0'))::VARCHAR(1) as MNTKBN,  -- コード/区分
        rtrim(ORDRKEY,' 　')::VARCHAR(11) as ORDRKEY,  -- 英数字
        IFF(rtrim(JURRSYMD) = '','',LPAD(rtrim(JURRSYMD),length(JURRSYMD),'0'))::VARCHAR(8) as JURRSYMD,  -- 日付
        rtrim(TANSKKEY,' 　')::VARCHAR(11) as TANSKKEY,  -- 英数字
        rtrim(SHINBAN,' 　')::VARCHAR(20) as SHINBAN,  -- 英数字
        IFF(rtrim(DLRCD) = '','',LPAD(rtrim(DLRCD),length(DLRCD),'0'))::VARCHAR(7) as DLRCD,  -- コード/区分
        rtrim(ODRNO,' 　')::VARCHAR(8) as ODRNO,  -- 英数字
        rtrim(ITEMNO,' 　')::VARCHAR(4) as ITEMNO,  -- 英数字
        IFF(rtrim(KOKAGKBN) = '','',LPAD(rtrim(KOKAGKBN),length(KOKAGKBN),'0'))::VARCHAR(1) as KOKAGKBN,  -- コード/区分
        IFF(rtrim(YUSOKBN) = '','',LPAD(rtrim(YUSOKBN),length(YUSOKBN),'0'))::VARCHAR(1) as YUSOKBN,  -- コード/区分
        rtrim(SYUBETSU,' 　')::VARCHAR(2) as SYUBETSU,  -- 英数字
        rtrim(ORDRTYPE,' 　')::VARCHAR(1) as ORDRTYPE,  -- 英数字
        rtrim(ORDTSYRI,' 　')::VARCHAR(1) as ORDTSYRI,  -- 英数字
        rtrim(KNKYUDO1,' 　')::VARCHAR(1) as KNKYUDO1,  -- 英数字
        rtrim(ODRZOK,' 　')::VARCHAR(1) as ODRZOK,  -- 英数字
        to_decimal(IFF(rtrim(BOSU) = '',0,rtrim(BOSU)))::DECIMAL(6) as BOSU,  -- 数量／金額／数値
        IFF(rtrim(JUCHUYMD) = '','',LPAD(rtrim(JUCHUYMD),length(JUCHUYMD),'0'))::VARCHAR(8) as JUCHUYMD,  -- 日付
        to_decimal(IFF(rtrim(JUCHUSU) = '',0,rtrim(JUCHUSU)))::DECIMAL(6) as JUCHUSU,  -- 数量／金額／数値
        to_decimal(IFF(rtrim(SYYHENCT) = '',0,rtrim(SYYHENCT)))::DECIMAL(3) as SYYHENCT,  -- 数量／金額／数値
        to_decimal(IFF(rtrim(ETDHENCT) = '',0,rtrim(ETDHENCT)))::DECIMAL(3) as ETDHENCT,  -- 数量／金額／数値
        IFF(rtrim(MKAITOCD) = '','',LPAD(rtrim(MKAITOCD),length(MKAITOCD),'0'))::VARCHAR(1) as MKAITOCD,  -- コード/区分
        IFF(rtrim(HNKKBN) = '','',LPAD(rtrim(HNKKBN),length(HNKKBN),'0'))::VARCHAR(1) as HNKKBN,  -- コード/区分
        IFF(rtrim(HNNOYTIME) = '','',LPAD(rtrim(HNNOYTIME),length(HNNOYTIME),'0'))::VARCHAR(12) as HNNOYTIME,  -- 時間
        IFF(rtrim(HNTAYTIME) = '','',LPAD(rtrim(HNTAYTIME),length(HNTAYTIME),'0'))::VARCHAR(12) as HNTAYTIME,  -- 時間
        IFF(rtrim(HNSYYTIME) = '','',LPAD(rtrim(HNSYYTIME),length(HNSYYTIME),'0'))::VARCHAR(12) as HNSYYTIME,  -- 時間
        IFF(rtrim(HNTOYTIME) = '','',LPAD(rtrim(HNTOYTIME),length(HNTOYTIME),'0'))::VARCHAR(12) as HNTOYTIME,  -- 時間
        IFF(rtrim(HNKTOYMD) = '','',LPAD(rtrim(HNKTOYMD),length(HNKTOYMD),'0'))::VARCHAR(8) as HNKTOYMD,  -- 日付
        IFF(rtrim(ENKKBN) = '','',LPAD(rtrim(ENKKBN),length(ENKKBN),'0'))::VARCHAR(1) as ENKKBN,  -- コード/区分
        IFF(rtrim(ENFYTYMD) = '','',LPAD(rtrim(ENFYTYMD),length(ENFYTYMD),'0'))::VARCHAR(8) as ENFYTYMD,  -- 日付
        IFF(rtrim(ENKTOYMD) = '','',LPAD(rtrim(ENKTOYMD),length(ENKTOYMD),'0'))::VARCHAR(8) as ENKTOYMD,  -- 日付
        IFF(rtrim(HOKKBN) = '','',LPAD(rtrim(HOKKBN),length(HOKKBN),'0'))::VARCHAR(1) as HOKKBN,  -- コード/区分
        IFF(rtrim(HONOYTIME) = '','',LPAD(rtrim(HONOYTIME),length(HONOYTIME),'0'))::VARCHAR(12) as HONOYTIME,  -- 時間
        IFF(rtrim(HOTAYTIME) = '','',LPAD(rtrim(HOTAYTIME),length(HOTAYTIME),'0'))::VARCHAR(12) as HOTAYTIME,  -- 時間
        IFF(rtrim(HOSYYTIME) = '','',LPAD(rtrim(HOSYYTIME),length(HOSYYTIME),'0'))::VARCHAR(12) as HOSYYTIME,  -- 時間
        IFF(rtrim(HOTOYTIME) = '','',LPAD(rtrim(HOTOYTIME),length(HOTOYTIME),'0'))::VARCHAR(12) as HOTOYTIME,  -- 時間
        IFF(rtrim(HOKTOYMD) = '','',LPAD(rtrim(HOKTOYMD),length(HOKTOYMD),'0'))::VARCHAR(8) as HOKTOYMD,  -- 日付
        IFF(rtrim(EOKKBN) = '','',LPAD(rtrim(EOKKBN),length(EOKKBN),'0'))::VARCHAR(1) as EOKKBN,  -- コード/区分
        IFF(rtrim(EOFYTYMD) = '','',LPAD(rtrim(EOFYTYMD),length(EOFYTYMD),'0'))::VARCHAR(8) as EOFYTYMD,  -- 日付
        IFF(rtrim(EOKTOYMD) = '','',LPAD(rtrim(EOKTOYMD),length(EOKTOYMD),'0'))::VARCHAR(8) as EOKTOYMD,  -- 日付
        IFF(rtrim(HSKKBN) = '','',LPAD(rtrim(HSKKBN),length(HSKKBN),'0'))::VARCHAR(1) as HSKKBN,  -- コード/区分
        IFF(rtrim(HSNOYTIME) = '','',LPAD(rtrim(HSNOYTIME),length(HSNOYTIME),'0'))::VARCHAR(12) as HSNOYTIME,  -- 時間
        IFF(rtrim(HSTAYTIME) = '','',LPAD(rtrim(HSTAYTIME),length(HSTAYTIME),'0'))::VARCHAR(12) as HSTAYTIME,  -- 時間
        IFF(rtrim(HSSYYTIME) = '','',LPAD(rtrim(HSSYYTIME),length(HSSYYTIME),'0'))::VARCHAR(12) as HSSYYTIME,  -- 時間
        IFF(rtrim(HSTOYTIME) = '','',LPAD(rtrim(HSTOYTIME),length(HSTOYTIME),'0'))::VARCHAR(12) as HSTOYTIME,  -- 時間
        IFF(rtrim(HSKTOYMD) = '','',LPAD(rtrim(HSKTOYMD),length(HSKTOYMD),'0'))::VARCHAR(8) as HSKTOYMD,  -- 日付
        IFF(rtrim(ESKKBN) = '','',LPAD(rtrim(ESKKBN),length(ESKKBN),'0'))::VARCHAR(1) as ESKKBN,  -- コード/区分
        IFF(rtrim(ESFYTYMD) = '','',LPAD(rtrim(ESFYTYMD),length(ESFYTYMD),'0'))::VARCHAR(8) as ESFYTYMD,  -- 日付
        IFF(rtrim(ESKTOYMD) = '','',LPAD(rtrim(ESKTOYMD),length(ESKTOYMD),'0'))::VARCHAR(8) as ESKTOYMD,  -- 日付
        to_decimal(IFF(rtrim(PTOPFLG) = '',0,rtrim(PTOPFLG)))::VARCHAR(1) as PTOPFLG,  -- フラグ
        to_decimal(IFF(rtrim(MARTFLG) = '',0,rtrim(MARTFLG)))::VARCHAR(1) as MARTFLG,  -- フラグ
        rtrim(SKJUNI,' 　')::VARCHAR(6) as SKJUNI,  -- 英数字
        IFF(rtrim(KAKNOUKBN) = '','',LPAD(rtrim(KAKNOUKBN),length(KAKNOUKBN),'0'))::VARCHAR(1) as KAKNOUKBN,  -- コード/区分
        IFF(rtrim(IPSYYTMIE) = '','',LPAD(rtrim(IPSYYTMIE),length(IPSYYTMIE),'0'))::VARCHAR(12) as IPSYYTMIE,  -- 時間
        IFF(rtrim(IPFYTYMD) = '','',LPAD(rtrim(IPFYTYMD),length(IPFYTYMD),'0'))::VARCHAR(8) as IPFYTYMD,  -- 日付
        rtrim(MTUSERID,' 　')::VARCHAR(16) as MTUSERID,  -- 英数字
        IFF(rtrim(MTTIMEX) = '','',LPAD(rtrim(MTTIMEX),length(MTTIMEX),'0'))::VARCHAR(26) as MTTIMEX,  -- MTTIMEX
        rtrim(FILLER,' 　')::VARCHAR(12) as FILLER,  -- 英数字
        LDTS,
        RANK() over (partition by ORDRKEY, JURRSYMD, TANSKKEY order by MTTIMEX, LDTS desc) aggkey
    from {{ ref('substr_dvnp0710') }}
)
select * from stg_dvnp0710
where aggkey = 1

        