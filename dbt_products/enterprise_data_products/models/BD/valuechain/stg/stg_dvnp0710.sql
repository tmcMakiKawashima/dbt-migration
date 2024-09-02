{{ config(snowflake_warehouse='DBT_WH') }}

with stg_dvnp0710 as (
    select
        rtrim(mntkbn,' 　')::varchar(1) as mntkbn,  -- 英数字
        rtrim(ordrkey,' 　')::varchar(11) as ordrkey,  -- 英数字
        rtrim(jurrsymd,' 　')::varchar(8) as jurrsymd,  -- 英数字
        rtrim(tanskkey,' 　')::varchar(11) as tanskkey,  -- 英数字
        rtrim(shinban,' 　')::varchar(20) as shinban,  -- 英数字
        rtrim(dlrcd,' 　')::varchar(7) as dlrcd,  -- 英数字
        rtrim(odrno,' 　')::varchar(8) as odrno,  -- 英数字
        rtrim(itemno,' 　')::varchar(4) as itemno,  -- 英数字
        rtrim(kokagkbn,' 　')::varchar(1) as kokagkbn,  -- 英数字
        rtrim(yusokbn,' 　')::varchar(1) as yusokbn,  -- 英数字
        rtrim(syubetsu,' 　')::varchar(2) as syubetsu,  -- 英数字
        rtrim(ordrtype,' 　')::varchar(1) as ordrtype,  -- 英数字
        rtrim(ordtsyri,' 　')::varchar(1) as ordtsyri,  -- 英数字
        rtrim(knkyudo1,' 　')::varchar(1) as knkyudo1,  -- 英数字
        rtrim(odrzok,' 　')::varchar(1) as odrzok,  -- 英数字
        to_decimal(iff(rtrim(bosu) = '',0,rtrim(bosu)))::decimal(6) as bosu,  -- 数量／金額／数値
        rtrim(juchuymd,' 　')::varchar(8) as juchuymd,  -- 英数字
        to_decimal(iff(rtrim(juchusu) = '',0,rtrim(juchusu)))::decimal(6) as juchusu,  -- 数量／金額／数値
        to_decimal(iff(rtrim(syyhenct) = '',0,rtrim(syyhenct)))::decimal(3) as syyhenct,  -- 数量／金額／数値
        to_decimal(iff(rtrim(etdhenct) = '',0,rtrim(etdhenct)))::decimal(3) as etdhenct,  -- 数量／金額／数値
        rtrim(mkaitocd,' 　')::varchar(1) as mkaitocd,  -- 英数字
        rtrim(hnkkbn,' 　')::varchar(1) as hnkkbn,  -- 英数字
        rtrim(hnnoytime,' 　')::varchar(12) as hnnoytime,  -- 英数字
        rtrim(hntaytime,' 　')::varchar(12) as hntaytime,  -- 英数字
        rtrim(hnsyytime,' 　')::varchar(12) as hnsyytime,  -- 英数字
        rtrim(hntoytime,' 　')::varchar(12) as hntoytime,  -- 英数字
        rtrim(hnktoymd,' 　')::varchar(8) as hnktoymd,  -- 英数字
        rtrim(enkkbn,' 　')::varchar(1) as enkkbn,  -- 英数字
        rtrim(enfytymd,' 　')::varchar(8) as enfytymd,  -- 英数字
        rtrim(enktoymd,' 　')::varchar(8) as enktoymd,  -- 英数字
        rtrim(hokkbn,' 　')::varchar(1) as hokkbn,  -- 英数字
        rtrim(honoytime,' 　')::varchar(12) as honoytime,  -- 英数字
        rtrim(hotaytime,' 　')::varchar(12) as hotaytime,  -- 英数字
        rtrim(hosyytime,' 　')::varchar(12) as hosyytime,  -- 英数字
        rtrim(hotoytime,' 　')::varchar(12) as hotoytime,  -- 英数字
        rtrim(hoktoymd,' 　')::varchar(8) as hoktoymd,  -- 英数字
        rtrim(eokkbn,' 　')::varchar(1) as eokkbn,  -- 英数字
        rtrim(eofytymd,' 　')::varchar(8) as eofytymd,  -- 英数字
        rtrim(eoktoymd,' 　')::varchar(8) as eoktoymd,  -- 英数字
        rtrim(hskkbn,' 　')::varchar(1) as hskkbn,  -- 英数字
        rtrim(hsnoytime,' 　')::varchar(12) as hsnoytime,  -- 英数字
        rtrim(hstaytime,' 　')::varchar(12) as hstaytime,  -- 英数字
        rtrim(hssyytime,' 　')::varchar(12) as hssyytime,  -- 英数字
        rtrim(hstoytime,' 　')::varchar(12) as hstoytime,  -- 英数字
        rtrim(hsktoymd,' 　')::varchar(8) as hsktoymd,  -- 英数字
        rtrim(eskkbn,' 　')::varchar(1) as eskkbn,  -- 英数字
        rtrim(esfytymd,' 　')::varchar(8) as esfytymd,  -- 英数字
        rtrim(esktoymd,' 　')::varchar(8) as esktoymd,  -- 英数字
        rtrim(ptopflg,' 　')::varchar(1) as ptopflg,  -- 英数字
        rtrim(martflg,' 　')::varchar(1) as martflg,  -- 英数字
        rtrim(skjuni,' 　')::varchar(6) as skjuni,  -- 英数字
        rtrim(kaknoukbn,' 　')::varchar(1) as kaknoukbn,  -- 英数字
        rtrim(ipsyytmie,' 　')::varchar(12) as ipsyytmie,  -- 英数字
        rtrim(ipfytymd,' 　')::varchar(8) as ipfytymd,  -- 英数字
        rtrim(mtuserid,' 　')::varchar(16) as mtuserid,  -- 英数字
        try_to_timestamp_ntz(mttime, 'yyyy-mm-dd-hh24.mi.ss.ff9') as mttime, --timestamp型
        rtrim(filler,' 　')::varchar(12) as filler,  -- 英数字
        ldts, -- B層のLDTS
        rank() over (partition by ordrkey, jurrsymd, tanskkey order by mttime desc, ldts desc) aggkey
    from {{ ref('substr_dvnp0710') }}
)
select * from stg_dvnp0710
where aggkey = 1