{{ config(snowflake_warehouse='DBT_WH') }}

with stg_dvnp0680 as (
    select
        rtrim(ordrkey,' 　')::varchar(11) as ordrkey,  -- 英数字
        rtrim(kokagkbn,' 　')::varchar(1) as kokagkbn,  -- 英数字
        rtrim(datakbn4,' 　')::varchar(4) as datakbn4,  -- 英数字
        rtrim(dlrcd,' 　')::varchar(7) as dlrcd,  -- 英数字
        rtrim(yusokbn,' 　')::varchar(1) as yusokbn,  -- 英数字
        rtrim(odrno,' 　')::varchar(8) as odrno,  -- 英数字
        rtrim(juchuymd,' 　')::varchar(8) as juchuymd,  -- 英数字
        rtrim(itemno,' 　')::varchar(4) as itemno,  -- 英数字
        rtrim(jhinban,' 　')::varchar(20) as jhinban,  -- 英数字
        rtrim(syubetsu,' 　')::varchar(2) as syubetsu,  -- 英数字
        rtrim(ordrtype,' 　')::varchar(1) as ordrtype,  -- 英数字
        rtrim(ordtsyri,' 　')::varchar(1) as ordtsyri,  -- 英数字
        rtrim(knkyudo1,' 　')::varchar(1) as knkyudo1,  -- 英数字
        rtrim(odrzok,' 　')::varchar(1) as odrzok,  -- 英数字
        rtrim(yumukbn,' 　')::varchar(1) as yumukbn,  -- 英数字
        rtrim(hyoftnbs,' 　')::varchar(1) as hyoftnbs,  -- 英数字
        rtrim(kyoseicd,' 　')::varchar(1) as kyoseicd,  -- 英数字
        rtrim(hanbaicd,' 　')::varchar(1) as hanbaicd,  -- 英数字
        rtrim(bocd,' 　')::varchar(1) as bocd,  -- 英数字
        rtrim(yusoutcd,' 　')::varchar(1) as yusoutcd,  -- 英数字
        rtrim(spdiscount,' 　')::varchar(4) as spdiscount,  -- 英数字
        rtrim(tuikakbn,' 　')::varchar(1) as tuikakbn,  -- 英数字
        rtrim(kkksrkbn,' 　')::varchar(1) as kkksrkbn,  -- 英数字
        rtrim(sagyokgnymd,' 　')::varchar(8) as sagyokgnymd,  -- 英数字
        rtrim(zuizikbn,' 　')::varchar(1) as zuizikbn,  -- 英数字
        rtrim(zuizirtu,' 　')::varchar(3) as zuizirtu,  -- 英数字
        rtrim(betmkcd,' 　')::varchar(4) as betmkcd,  -- 英数字
        rtrim(jyusyymd,' 　')::varchar(8) as jyusyymd,  -- 英数字
        to_decimal(iff(rtrim(juchusu) = '',0,rtrim(juchusu)))::decimal(6) as juchusu,  -- 数量／金額／数値
        to_decimal(iff(rtrim(projusuu6) = '',0,rtrim(projusuu6)))::decimal(6) as projusuu6,  -- 数量／金額／数値
        rtrim(tarifcd,' 　')::varchar(3) as tarifcd,  -- 英数字
        rtrim(toktanka9,' 　')::varchar(9) as toktanka9,  -- 英数字
        rtrim(tansjymd,' 　')::varchar(8) as tansjymd,  -- 英数字
        rtrim(rimak1,' 　')::varchar(10) as rimak1,  -- 英数字
        rtrim(rimak2,' 　')::varchar(1) as rimak2,  -- 英数字
        rtrim(bnrkyscd,' 　')::varchar(1) as bnrkyscd,  -- 英数字
        rtrim(bekoncd,' 　')::varchar(1) as bekoncd,  -- 英数字
        rtrim(simkmeik,' 　')::varchar(20) as simkmeik,  -- 英数字
        rtrim(simkmeijp,' 　')::varchar(3) as simkmeijp,  -- 英数字
        rtrim(yustgtcd,' 　')::varchar(8) as yustgtcd,  -- 英数字
        rtrim(ordrcycl,' 　')::varchar(1) as ordrcycl,  -- 英数字
        rtrim(sdlrcd,' 　')::varchar(7) as sdlrcd,  -- 英数字
        rtrim(pshukakbn,' 　')::varchar(1) as pshukakbn,  -- 英数字
        rtrim(douknhukakbn,' 　')::varchar(1) as douknhukakbn,  -- 英数字
        rtrim(sytyubanflg,' 　')::varchar(1) as sytyubanflg,  -- 英数字
        rtrim(tandkban,' 　')::varchar(1) as tandkban,  -- 英数字
        rtrim(knpktcd,' 　')::varchar(1) as knpktcd,  -- 英数字
        rtrim(hanstsakcd,' 　')::varchar(3) as hanstsakcd,  -- 英数字
        rtrim(etctes,' 　')::varchar(3) as etctes,  -- 英数字
        rtrim(kessai,' 　')::varchar(2) as kessai,  -- 英数字
        rtrim(tatnkbn,' 　')::varchar(1) as tatnkbn,  -- 英数字
        rtrim(tndkinv,' 　')::varchar(1) as tndkinv,  -- 英数字
        rtrim(tarifdkn,' 　')::varchar(1) as tarifdkn,  -- 英数字
        rtrim(pfcd,' 　')::varchar(2) as pfcd,  -- 英数字
        rtrim(mtuserid,' 　')::varchar(16) as mtuserid,  -- 英数字
        try_to_timestamp_ntz(mttime, 'yyyy-mm-dd-hh24.mi.ss.ff9') as mttime, -- timestamp型
        rtrim(filler,' 　')::varchar(45) as filler,  -- 英数字
        ldts, -- B層のLDTS
        rank() over (partition by ordrkey, juchuymd order by mttime desc, ldts desc) aggkey
    from {{ ref('substr_dvnp0680') }}
)
select * from stg_dvnp0680
where aggkey = 1