with stg_dvnp0700 as (
    select
        rtrim(ordrkey,' 　')::varchar(11) as ordrkey,  -- 英数字
        rtrim(tanskkey,' 　')::varchar(11) as tanskkey,  -- 英数字
        rtrim(shinban,' 　')::varchar(20) as shinban,  -- 英数字
        rtrim(szhinban,' 　')::varchar(20) as szhinban,  -- 英数字
        rtrim(kaknoukbn,' 　')::varchar(1) as kaknoukbn,  -- 英数字
        rtrim(boyusnflg,' 　')::varchar(1) as boyusnflg,  -- 英数字
        rtrim(boyusnftrktime,' 　')::varchar(12) as boyusnftrktime,  -- 英数字
        rtrim(knkyudo1,' 　')::varchar(1) as knkyudo1,  -- 英数字
        rtrim(boskstimejun,' 　')::varchar(12) as boskstimejun,  -- 英数字
        rtrim(knkyudo2,' 　')::varchar(2) as knkyudo2,  -- 英数字
        rtrim(yusnrnbn,' 　')::varchar(6) as yusnrnbn,  -- 英数字
        rtrim(martflg,' 　')::varchar(1) as martflg,  -- 英数字
        rtrim(ptopflg,' 　')::varchar(1) as ptopflg,  -- 英数字
        rtrim(yusnptrn,' 　')::varchar(1) as yusnptrn,  -- 英数字
        rtrim(boselflg,' 　')::varchar(1) as boselflg,  -- 英数字
        to_decimal(iff(rtrim(sksijsu) = '',0,rtrim(sksijsu)))::decimal(6) as sksijsu,  -- 数量／金額／数値
        rtrim(sksijitime,' 　')::varchar(12) as sksijitime,  -- 英数字
        rtrim(tnsksjsu,' 　')::varchar(6) as tnsksjsu,  -- 英数字
        rtrim(hziksjsu,' 　')::varchar(6) as hziksjsu,  -- 英数字
        rtrim(nonyuytisu,' 　')::varchar(6) as nonyuytisu,  -- 英数字
        to_decimal(iff(rtrim(bosu) = '',0,rtrim(bosu)))::decimal(6) as bosu,  -- 数量／金額／数値
        to_decimal(iff(rtrim(boruisuu) = '',0,rtrim(boruisuu)))::decimal(6) as boruisuu,  -- 数量／金額／数値
        rtrim(boskstime,' 　')::varchar(12) as boskstime,  -- 英数字
        rtrim(boktime,' 　')::varchar(12) as boktime,  -- 英数字
        rtrim(gnbkpflg,' 　')::varchar(1) as gnbkpflg,  -- 英数字
        rtrim(pendid,' 　')::varchar(2) as pendid,  -- 英数字
        rtrim(pensu,' 　')::varchar(6) as pensu,  -- 英数字
        rtrim(pentime,' 　')::varchar(12) as pentime,  -- 英数字
        rtrim(pektime,' 　')::varchar(12) as pektime,  -- 英数字
        to_decimal(iff(rtrim(cansu) = '',0,rtrim(cansu)))::decimal(6) as cansu,  -- 数量／金額／数値
        rtrim(cantime,' 　')::varchar(12) as cantime,  -- 英数字
        to_decimal(iff(rtrim(plbsuryo) = '',0,rtrim(plbsuryo)))::decimal(6) as plbsuryo,  -- 数量／金額／数値
        rtrim(plbtime,' 　')::varchar(12) as plbtime,  -- 英数字
        rtrim(caseno,' 　')::varchar(8) as caseno,  -- 英数字
        rtrim(casecd2,' 　')::varchar(2) as casecd2,  -- 英数字
        to_decimal(iff(rtrim(skzumsu) = '',0,rtrim(skzumsu)))::decimal(6) as skzumsu,  -- 数量／金額／数値
        rtrim(skzumymd,' 　')::varchar(8) as skzumymd,  -- 英数字
        rtrim(skztime,' 　')::varchar(12) as skztime,  -- 英数字
        rtrim(skzflg,' 　')::varchar(1) as skzflg,  -- 英数字
        rtrim(canzmflg,' 　')::varchar(1) as canzmflg,  -- 英数字
        rtrim(bunkatukbn,' 　')::varchar(1) as bunkatukbn,  -- 英数字
        rtrim(mtuserid,' 　')::varchar(16) as mtuserid,  -- 英数字
        try_to_timestamp_ntz(mttime, 'yyyy-mm-dd-hh24.mi.ss.ff9') as mttime, -- timestamp型
        rtrim(juchuymd,' 　')::varchar(8) as juchuymd,  -- 英数字
        rtrim(dummy,' 　')::varchar(9) as dummy,  -- 英数字
        ldts, -- B層のLDTS
        rank() over (partition by ordrkey, tanskkey, juchuymd order by mttime desc, ldts desc) aggkey
    from {{ ref('substr_dvnp0700') }}
)
select * from stg_dvnp0700
where aggkey = 1