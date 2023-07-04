{{ config(materialized='table') }}

with stg_dvnp0710 as (
    select
        IFF(rtrim(MNTKBN) = '','',(LPAD(to_char(rtrim(MNTKBN)),length(MNTKBN),'0')))::VARCHAR(1) as MNTKBN,  -- コード/区分
        rtrim(ORDRKEY)::VARCHAR(11) as ORDRKEY,  -- 英数字
        to_date(IFF(rtrim(JURRSYMD) = '','19700101',rtrim(JURRSYMD)), 'YYYYMMDD')::DATE as JURRSYMD,  -- 日付
        rtrim(TANSKKEY)::VARCHAR(11) as TANSKKEY,  -- 英数字
        rtrim(SHINBAN)::VARCHAR(20) as SHINBAN,  -- 英数字
        IFF(rtrim(DLRCD) = '','',(LPAD(to_char(rtrim(DLRCD)),length(DLRCD),'0')))::VARCHAR(7) as DLRCD,  -- コード/区分
        rtrim(ODRNO)::VARCHAR(8) as ODRNO,  -- 英数字
        rtrim(ITEMNO)::VARCHAR(4) as ITEMNO,  -- 英数字
        IFF(rtrim(KOKAGKBN) = '','',(LPAD(to_char(rtrim(KOKAGKBN)),length(KOKAGKBN),'0')))::VARCHAR(1) as KOKAGKBN,  -- コード/区分
        IFF(rtrim(YUSOKBN) = '','',(LPAD(to_char(rtrim(YUSOKBN)),length(YUSOKBN),'0')))::VARCHAR(1) as YUSOKBN,  -- コード/区分
        rtrim(SYUBETSU)::VARCHAR(2) as SYUBETSU,  -- 英数字
        rtrim(ORDRTYPE)::VARCHAR(1) as ORDRTYPE,  -- 英数字
        rtrim(ORDTSYRI)::VARCHAR(1) as ORDTSYRI,  -- 英数字
        rtrim(KNKYUDO1)::VARCHAR(1) as KNKYUDO1,  -- 英数字
        rtrim(ODRZOK)::VARCHAR(1) as ODRZOK,  -- 英数字
        to_decimal(IFF(rtrim(BOSU) = '',0,rtrim(BOSU)))::DECIMAL(6) as BOSU,  -- 数量／金額／数値
        to_date(IFF(rtrim(JUCHUYMD) = '','19700101',rtrim(JUCHUYMD)), 'YYYYMMDD')::DATE as JUCHUYMD,  -- 日付
        to_decimal(IFF(rtrim(JUCHUSU) = '',0,rtrim(JUCHUSU)))::DECIMAL(6) as JUCHUSU,  -- 数量／金額／数値
        to_decimal(IFF(rtrim(SYYHENCT) = '',0,rtrim(SYYHENCT)))::DECIMAL(3) as SYYHENCT,  -- 数量／金額／数値
        to_decimal(IFF(rtrim(ETDHENCT) = '',0,rtrim(ETDHENCT)))::DECIMAL(3) as ETDHENCT,  -- 数量／金額／数値
        IFF(rtrim(MKAITOCD) = '','',(LPAD(to_char(rtrim(MKAITOCD)),length(MKAITOCD),'0')))::VARCHAR(1) as MKAITOCD,  -- コード/区分
        IFF(rtrim(HNKKBN) = '','',(LPAD(to_char(rtrim(HNKKBN)),length(HNKKBN),'0')))::VARCHAR(1) as HNKKBN,  -- コード/区分
        to_timestamp(IFF(rtrim(HNNOYTIME) = '', '197001010000', rtrim(HNNOYTIME)), 'YYYYMMDDHHMI')::DATETIME as HNNOYTIME,  -- 時間
        to_timestamp(IFF(rtrim(HNTAYTIME) = '', '197001010000', rtrim(HNTAYTIME)), 'YYYYMMDDHHMI')::DATETIME as HNTAYTIME,  -- 時間
        to_timestamp(IFF(rtrim(HNSYYTIME) = '', '197001010000', rtrim(HNSYYTIME)), 'YYYYMMDDHHMI')::DATETIME as HNSYYTIME,  -- 時間
        to_timestamp(IFF(rtrim(HNTOYTIME) = '', '197001010000', rtrim(HNTOYTIME)), 'YYYYMMDDHHMI')::DATETIME as HNTOYTIME,  -- 時間
        to_date(IFF(rtrim(HNKTOYMD) = '','19700101',rtrim(HNKTOYMD)), 'YYYYMMDD')::DATE as HNKTOYMD,  -- 日付
        IFF(rtrim(ENKKBN) = '','',(LPAD(to_char(rtrim(ENKKBN)),length(ENKKBN),'0')))::VARCHAR(1) as ENKKBN,  -- コード/区分
        to_date(IFF(rtrim(ENFYTYMD) = '','19700101',rtrim(ENFYTYMD)), 'YYYYMMDD')::DATE as ENFYTYMD,  -- 日付
        to_date(IFF(rtrim(ENKTOYMD) = '','19700101',rtrim(ENKTOYMD)), 'YYYYMMDD')::DATE as ENKTOYMD,  -- 日付
        IFF(rtrim(HOKKBN) = '','',(LPAD(to_char(rtrim(HOKKBN)),length(HOKKBN),'0')))::VARCHAR(1) as HOKKBN,  -- コード/区分
        to_timestamp(IFF(rtrim(HONOYTIME) = '', '197001010000', rtrim(HONOYTIME)), 'YYYYMMDDHHMI')::DATETIME as HONOYTIME,  -- 時間
        to_timestamp(IFF(rtrim(HOTAYTIME) = '', '197001010000', rtrim(HOTAYTIME)), 'YYYYMMDDHHMI')::DATETIME as HOTAYTIME,  -- 時間
        to_timestamp(IFF(rtrim(HOSYYTIME) = '', '197001010000', rtrim(HOSYYTIME)), 'YYYYMMDDHHMI')::DATETIME as HOSYYTIME,  -- 時間
        to_timestamp(IFF(rtrim(HOTOYTIME) = '', '197001010000', rtrim(HOTOYTIME)), 'YYYYMMDDHHMI')::DATETIME as HOTOYTIME,  -- 時間
        to_date(IFF(rtrim(HOKTOYMD) = '','19700101',rtrim(HOKTOYMD)), 'YYYYMMDD')::DATE as HOKTOYMD,  -- 日付
        IFF(rtrim(EOKKBN) = '','',(LPAD(to_char(rtrim(EOKKBN)),length(EOKKBN),'0')))::VARCHAR(1) as EOKKBN,  -- コード/区分
        to_date(IFF(rtrim(EOFYTYMD) = '','19700101',rtrim(EOFYTYMD)), 'YYYYMMDD')::DATE as EOFYTYMD,  -- 日付
        to_date(IFF(rtrim(EOKTOYMD) = '','19700101',rtrim(EOKTOYMD)), 'YYYYMMDD')::DATE as EOKTOYMD,  -- 日付
        IFF(rtrim(HSKKBN) = '','',(LPAD(to_char(rtrim(HSKKBN)),length(HSKKBN),'0')))::VARCHAR(1) as HSKKBN,  -- コード/区分
        to_timestamp(IFF(rtrim(HSNOYTIME) = '', '197001010000', rtrim(HSNOYTIME)), 'YYYYMMDDHHMI')::DATETIME as HSNOYTIME,  -- 時間
        to_timestamp(IFF(rtrim(HSTAYTIME) = '', '197001010000', rtrim(HSTAYTIME)), 'YYYYMMDDHHMI')::DATETIME as HSTAYTIME,  -- 時間
        to_timestamp(IFF(rtrim(HSSYYTIME) = '', '197001010000', rtrim(HSSYYTIME)), 'YYYYMMDDHHMI')::DATETIME as HSSYYTIME,  -- 時間
        to_timestamp(IFF(rtrim(HSTOYTIME) = '', '197001010000', rtrim(HSTOYTIME)), 'YYYYMMDDHHMI')::DATETIME as HSTOYTIME,  -- 時間
        to_date(IFF(rtrim(HSKTOYMD) = '','19700101',rtrim(HSKTOYMD)), 'YYYYMMDD')::DATE as HSKTOYMD,  -- 日付
        IFF(rtrim(ESKKBN) = '','',(LPAD(to_char(rtrim(ESKKBN)),length(ESKKBN),'0')))::VARCHAR(1) as ESKKBN,  -- コード/区分
        to_date(IFF(rtrim(ESFYTYMD) = '','19700101',rtrim(ESFYTYMD)), 'YYYYMMDD')::DATE as ESFYTYMD,  -- 日付
        to_date(IFF(rtrim(ESKTOYMD) = '','19700101',rtrim(ESKTOYMD)), 'YYYYMMDD')::DATE as ESKTOYMD,  -- 日付
        to_decimal(IFF(rtrim(PTOPFLG) = '',0,rtrim(PTOPFLG)))::BOOLEAN as PTOPFLG,  -- フラグ
        to_decimal(IFF(rtrim(MARTFLG) = '',0,rtrim(MARTFLG)))::BOOLEAN as MARTFLG,  -- フラグ
        to_decimal(IFF(rtrim(SKJUNI) = '',0,rtrim(SKJUNI)))::DECIMAL(6) as SKJUNI,  -- 数量／金額／数値
        IFF(rtrim(KAKNOUKBN) = '','',(LPAD(to_char(rtrim(KAKNOUKBN)),length(KAKNOUKBN),'0')))::VARCHAR(1) as KAKNOUKBN,  -- コード/区分
        to_timestamp(IFF(rtrim(IPSYYTMIE) = '', '197001010000', rtrim(IPSYYTMIE)), 'YYYYMMDDHHMI')::DATETIME as IPSYYTMIE,  -- 時間
        to_date(IFF(rtrim(IPFYTYMD) = '','19700101',rtrim(IPFYTYMD)), 'YYYYMMDD')::DATE as IPFYTYMD,  -- 日付
        rtrim(MTUSERID)::VARCHAR(16) as MTUSERID,  -- 英数字
        to_timestamp(IFF(rtrim(MTTIMEX) = '', '1970-01-01-00.00.00.00', rtrim(MTTIMEX)), 'YYYY-MM-DD-HH.MI.SS.FF9')::DATETIME as MTTIMEX,  -- MTTIMEX
        rtrim(FILLER)::VARCHAR(12) as FILLER,  -- 英数字
        LDTS,
        RANK() over (partition by ORDRKEY, JURRSYMD, TANSKKEY order by MTTIMEX, LDTS desc) aggkey
    from {{ ref('substr_dvnp0710') }}
)
select * from stg_dvnp0710
where aggkey = 1

        