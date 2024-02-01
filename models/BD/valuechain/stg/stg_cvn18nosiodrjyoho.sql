{{ config(materialized='ephemeral') }}

with stg_cvn18nosiodrjyoho as (
    select
        rtrim(ordrkey, ' 　')::varchar(11) as ordrkey, -- 英数字
        rtrim(dlrcd, ' 　')::varchar(7) as dlrcd, -- 英数字
        rtrim(syubetsu, ' 　')::varchar(2) as syubetsu, -- 英数字
        rtrim(odrno, ' 　')::varchar(8) as odrno, -- 英数字
        rtrim(juchuymd, ' 　')::varchar(8) as juchuymd, -- 英数字
        rtrim(juchutime, ' 　')::varchar(17) as juchutime, -- 英数字
        rtrim(jhinban, ' 　')::varchar(20) as jhinban, -- 英数字
        rtrim(nosikbn, ' 　')::varchar(1) as nosikbn, -- 英数字
        rtrim(skibohenkokahi, ' 　')::varchar(1) as skibohenkokahi, -- 英数字
        rtrim(cancelkahi, ' 　')::varchar(1) as cancelkahi, -- 英数字
        rtrim(hnskiboymd, ' 　')::varchar(8) as hnskiboymd, -- 英数字
        rtrim(hhenkoymd, ' 　')::varchar(12) as hhenkoymd, -- 英数字
        rtrim(hoskiboymd, ' 　')::varchar(8) as hoskiboymd, -- 英数字
        rtrim(hohenkoymd, ' 　')::varchar(12) as hohenkoymd, -- 英数字
        rtrim(hsskiboymd, ' 　')::varchar(8) as hsskiboymd, -- 英数字
        to_decimal(iff(rtrim(skibohenkokaisu) = '', 0, rtrim(skibohenkokaisu)))::decimal(6) as skibohenkokaisu, -- 数量／金額／数値
        to_decimal(iff(rtrim(kariyoyakubosu) = '', 0, rtrim(kariyoyakubosu)))::decimal(6) as kariyoyakubosu, -- 数量／金額／数値
        rtrim(nonyuhinhikiymd, ' 　')::varchar(8) as nonyuhinhikiymd, -- 英数字
        rtrim(nktoytime, ' 　')::varchar(12) as nktoytime, -- 英数字
        rtrim(hnhonyoyakuymd, ' 　')::varchar(8) as hnhonyoyakuymd, -- 英数字
        rtrim(hohonyoyakuymd, ' 　')::varchar(8) as hohonyoyakuymd, -- 英数字
        rtrim(hshonyoyakuymd, ' 　')::varchar(8) as hshonyoyakuymd, -- 英数字
        rtrim(hnbosyytime, ' 　')::varchar(12) as hnbosyytime, -- 英数字
        rtrim(hobosyytime, ' 　')::varchar(12) as hobosyytime, -- 英数字
        rtrim(hsbosyytime, ' 　')::varchar(12) as hsbosyytime, -- 英数字
        rtrim(hnnksyytime, ' 　')::varchar(12) as hnnksyytime, -- 英数字
        rtrim(honksyytime, ' 　')::varchar(12) as honksyytime, -- 英数字
        rtrim(hsnksyytime, ' 　')::varchar(12) as hsnksyytime, -- 英数字
        to_decimal(iff(rtrim(allnosicansu) = '', 0, rtrim(allnosicansu)))::decimal(6) as allnosicansu, -- 数量／金額／数値
        to_decimal(iff(rtrim(hnnosicansu) = '', 0, rtrim(hnnosicansu)))::decimal(6) as hnnosicansu, -- 数量／金額／数値
        rtrim(hnnosicantime, ' 　')::varchar(12) as hnnosicantime, -- 英数字
        to_decimal(iff(rtrim(honosicansu) = '', 0, rtrim(honosicansu)))::decimal(6) as honosicansu, -- 数量／金額／数値
        rtrim(honosicantime, ' 　')::varchar(12) as honosicantime, -- 英数字
        to_decimal(iff(rtrim(hsnosicansu) = '', 0, rtrim(hsnosicansu)))::decimal(6) as hsnosicansu, -- 数量／金額／数値
        rtrim(hsnosicantime, ' 　')::varchar(12) as hsnosicantime, -- 英数字
        to_decimal(iff(rtrim(nosicankaisu) = '', 0, rtrim(nosicankaisu)))::decimal(6) as nosicankaisu, -- 数量／金額／数値
        to_decimal(iff(rtrim(htymatisu) = '', 0, rtrim(htymatisu)))::decimal(6) as htymatisu, -- 数量／金額／数値
        rtrim(hdyoteiymd, ' 　')::varchar(8) as hdyoteiymd, -- 英数字
        rtrim(iphonyoyakuymd, ' 　')::varchar(8) as iphonyoyakuymd, -- 英数字
        rtrim(mtuserid, ' 　')::varchar(16) as mtuserid, -- 英数字
        iff(try_to_timestamp_ntz(mttime,'yyyy-mm-dd-hh24.mi.ss.ff9') is null -- ブランクの場合nullになる対応でデフォルト値を設定
            , '0001-01-01 00:00:00.000'
            , try_to_timestamp_ntz(mttime,'yyyy-mm-dd-hh24.mi.ss.ff9')) mttime,
        ldts -- B層のLDTS
    from {{ ref('substr_cvn18nosiodrjyoho') }}
)
select * from stg_cvn18nosiodrjyoho
