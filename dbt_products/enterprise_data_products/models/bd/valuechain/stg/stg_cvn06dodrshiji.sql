{{ config(snowflake_warehouse='DBT_WH') }}

with stg_cvn06dodrshiji as (
    select
        rtrim(ordrkey,' 　')::varchar(11) as ordrkey,  -- 英数字
        rtrim(tanskkey,' 　')::varchar(11) as tanskkey,  -- 英数字
        rtrim(jurrsymd,' 　')::varchar(8) as jurrsymd,  -- 英数字
        rtrim(shinban,' 　')::varchar(20) as shinban,  -- 英数字
        rtrim(kaknoukbn,' 　')::varchar(1) as kaknoukbn,  -- 英数字
        rtrim(nonukyokbn,' 　')::varchar(1) as nonukyokbn,  -- 英数字
        rtrim(og,' 　')::varchar(2) as og,  -- 英数字
        rtrim(dokonid,' 　')::varchar(19) as dokonid,  -- 英数字
        rtrim(sagyonis,' 　')::varchar(2) as sagyonis,  -- 英数字
        to_decimal(iff(rtrim(tyosinis) = '',0,rtrim(tyosinis)))::decimal(2) as tyosinis,  -- 数量／金額／数値
        to_decimal(iff(rtrim(zsanis) = '',0,rtrim(zsanis)))::decimal(2) as zsanis,  -- 数量／金額／数値
        rtrim(haiknno,' 　')::varchar(4) as haiknno,  -- 英数字
        rtrim(daitityp,' 　')::varchar(2) as daitityp,  -- 英数字
        rtrim(skhkyotn,' 　')::varchar(10) as skhkyotn,  -- 英数字
        rtrim(zantikbn,' 　')::varchar(1) as zantikbn,  -- 英数字
        rtrim(syukancd,' 　')::varchar(1) as syukancd,  -- 英数字
        rtrim(yusyutgnt,' 　')::varchar(8) as yusyutgnt,  -- 英数字
        rtrim(racd,' 　')::varchar(2) as racd,  -- 英数字
        rtrim(shinmei,' 　')::varchar(20) as shinmei,  -- 英数字
        rtrim(tkyymd,' 　')::varchar(8) as tkyymd,  -- 英数字
        rtrim(tkytnkbn,' 　')::varchar(1) as tkytnkbn,  -- 英数字
        to_decimal(iff(rtrim(tkytanen) = '',0,rtrim(tkytanen)))::decimal(9) as tkytanen,  -- 数量／金額／数値
        to_decimal(iff(rtrim(tkytnkinvkgi1) = '',0,rtrim(tkytnkinvkgi1)))::decimal(11) as tkytnkinvkgi1,  -- 数量／金額／数値
        rtrim(invhktka,' 　')::varchar(1) as invhktka,  -- 英数字
        to_decimal(iff(rtrim(dnkai) = '',0,rtrim(dnkai)))::decimal(9) as dnkai,  -- 数量／金額／数値
        rtrim(kknhncd,' 　')::varchar(1) as kknhncd,  -- 英数字
        to_decimal(iff(rtrim(syryokti) = '',0,rtrim(syryokti)))::decimal(3) as syryokti,  -- 数量／金額／数値
        rtrim(kikenclass,' 　')::varchar(3) as kikenclass,  -- 英数字
        rtrim(unno,' 　')::varchar(4) as unno,  -- 英数字
        to_decimal(iff(rtrim(situryog8) = '',0,rtrim(situryog8)))::decimal(8) as situryog8,  -- 数量／金額／数値
        to_decimal(iff(rtrim(yoseki3) = '',0,rtrim(yoseki3)))::decimal(10) as yoseki3,  -- 数量／金額／数値
        to_decimal(iff(rtrim(yosekss) = '',0,rtrim(yosekss)))::decimal(2) as yosekss,  -- 数量／金額／数値
        to_decimal(iff(rtrim(sznagaslm) = '',0,rtrim(sznagaslm)))::decimal(4) as sznagaslm,  -- 数量／金額／数値
        to_decimal(iff(rtrim(szhabawm) = '',0,rtrim(szhabawm)))::decimal(4) as szhabawm,  -- 数量／金額／数値
        to_decimal(iff(rtrim(sztakashm) = '',0,rtrim(sztakashm)))::decimal(4) as sztakashm,  -- 数量／金額／数値
        to_decimal(iff(rtrim(ssnjuryo) = '',0,rtrim(ssnjuryo)))::decimal(5) as ssnjuryo,  -- 数量／金額／数値
        rtrim(kknokgcd,' 　')::varchar(2) as kknokgcd,  -- 英数字
        to_decimal(iff(rtrim(kknokgsu) = '',0,rtrim(kknokgsu)))::decimal(7) as kknokgsu,  -- 数量／金額／数値
        rtrim(kosokbn,' 　')::varchar(1) as kosokbn,  -- 英数字
        rtrim(picloke,' 　')::varchar(10) as picloke,  -- 英数字
        rtrim(paretize,' 　')::varchar(2) as paretize,  -- 英数字
        rtrim(syuykgcd,' 　')::varchar(2) as syuykgcd,  -- 英数字
        to_decimal(iff(rtrim(syuykgsu) = '',0,rtrim(syuykgsu)))::decimal(5) as syuykgsu,  -- 数量／金額／数値
        rtrim(tikodrbk,' 　')::varchar(1) as tikodrbk,  -- 英数字
        rtrim(tiikicd2,' 　')::varchar(2) as tiikicd2,  -- 英数字
        to_decimal(iff(rtrim(hatrysks) = '',0,rtrim(hatrysks)))::decimal(6) as hatrysks,  -- 数量／金額／数値
        to_decimal(iff(rtrim(kjnnisu) = '',0,rtrim(kjnnisu)))::decimal(4) as kjnnisu,  -- 数量／金額／数値
        to_decimal(iff(rtrim(disthrt) = '',0,rtrim(disthrt)))::decimal(3) as disthrt,  -- 数量／金額／数値
        to_decimal(iff(rtrim(seaijckb) = '',0,rtrim(seaijckb)))::decimal(2) as seaijckb,  -- 数量／金額／数値
        to_decimal(iff(rtrim(tirybksu) = '',0,rtrim(tirybksu)))::decimal(6) as tirybksu,  -- 数量／金額／数値
        to_decimal(iff(rtrim(syusisu6) = '',0,rtrim(syusisu6)))::decimal(6) as syusisu6,  -- 数量／金額／数値
        to_decimal(iff(rtrim(odrbktsu) = '',0,rtrim(odrbktsu)))::decimal(2) as odrbktsu,  -- 数量／金額／数値
        rtrim(rrsuflg,' 　')::varchar(1) as rrsuflg,  -- 英数字
        rtrim(rrsumd,' 　')::varchar(4) as rrsumd,  -- 英数字
        to_decimal(iff(rtrim(sisyobkt) = '',0,rtrim(sisyobkt)))::decimal(7) as sisyobkt,  -- 数量／金額／数値
        rtrim(endsijymd,' 　')::varchar(8) as endsijymd,  -- 英数字
        rtrim(bnktnoki,' 　')::varchar(8) as bnktnoki,  -- 英数字
        to_decimal(iff(rtrim(syukssu) = '',0,rtrim(syukssu)))::decimal(6) as syukssu,  -- 数量／金額／数値
        to_decimal(iff(rtrim(nonyutni) = '',0,rtrim(nonyutni)))::decimal(5) as nonyutni,  -- 数量／金額／数値
        rtrim(casecd1,' 　')::varchar(2) as casecd1,  -- 英数字
        rtrim(sykbkkbn,' 　')::varchar(1) as sykbkkbn,  -- 英数字
        to_decimal(iff(rtrim(sykbksu) = '',0,rtrim(sykbksu)))::decimal(6) as sykbksu,  -- 数量／金額／数値
        to_decimal(iff(rtrim(sasusksu) = '',0,rtrim(sasusksu)))::decimal(6) as sasusksu,  -- 数量／金額／数値
        rtrim(barakkbn,' 　')::varchar(1) as barakkbn,  -- 英数字
        to_decimal(iff(rtrim(cansijsu) = '',0,rtrim(cansijsu)))::decimal(6) as cansijsu,  -- 数量／金額／数値
        rtrim(henkuymd,' 　')::varchar(8) as henkuymd,  -- 英数字
        rtrim(takaikbn,' 　')::varchar(1) as takaikbn,  -- 英数字
        rtrim(taiming,' 　')::varchar(2) as taiming,  -- 英数字
        rtrim(unyoukbn,' 　')::varchar(1) as unyoukbn,  -- 英数字
        rtrim(tikkokbn,' 　')::varchar(1) as tikkokbn,  -- 英数字
        rtrim(szhinban,' 　')::varchar(20) as szhinban,  -- 英数字
        rtrim(crsnzkbn,' 　')::varchar(1) as crsnzkbn,  -- 英数字
        rtrim(sstkrkbn,' 　')::varchar(1) as sstkrkbn,  -- 英数字
        rtrim(mopprkbn,' 　')::varchar(1) as mopprkbn,  -- 英数字
        rtrim(syorkkbn,' 　')::varchar(1) as syorkkbn,  -- 英数字
        rtrim(abkbn,' 　')::varchar(1) as abkbn,  -- 英数字
        rtrim(tensokbn,' 　')::varchar(1) as tensokbn,  -- 英数字
        rtrim(ysskkticd,' 　')::varchar(1) as ysskkticd,  -- 英数字
        rtrim(funazumi,' 　')::varchar(1) as funazumi,  -- 英数字
        rtrim(ordr,' 　')::varchar(1) as ordr,  -- 英数字
        rtrim(tomkmkbn,' 　')::varchar(1) as tomkmkbn,  -- 英数字
        rtrim(sykiki,' 　')::varchar(1) as sykiki,  -- 英数字
        rtrim(sykikicd,' 　')::varchar(2) as sykikicd,  -- 英数字
        rtrim(sksijbsy,' 　')::varchar(3) as sksijbsy,  -- 英数字
        rtrim(zoon,' 　')::varchar(3) as zoon,  -- 英数字
        rtrim(hasobno,' 　')::varchar(2) as hasobno,  -- 英数字
        rtrim(kynnkpcd,' 　')::varchar(3) as kynnkpcd,  -- 英数字
        rtrim(kynkkpcd,' 　')::varchar(3) as kynkkpcd,  -- 英数字
        rtrim(srtktkbn,' 　')::varchar(1) as srtktkbn,  -- 英数字
        rtrim(abctlgrp,' 　')::varchar(2) as abctlgrp,  -- 英数字
        rtrim(btntckbn,' 　')::varchar(1) as btntckbn,  -- 英数字
        rtrim(skdsykbn,' 　')::varchar(1) as skdsykbn,  -- 英数字
        rtrim(tokeibricd,' 　')::varchar(3) as tokeibricd,  -- 英数字
        rtrim(kyokacd,' 　')::varchar(1) as kyokacd,  -- 英数字
        rtrim(raisenscd,' 　')::varchar(1) as raisenscd,  -- 英数字
        rtrim(menzeicd,' 　')::varchar(1) as menzeicd,  -- 英数字
        rtrim(syohnkbn,' 　')::varchar(1) as syohnkbn,  -- 英数字
        rtrim(srsirskcd,' 　')::varchar(4) as srsirskcd,  -- 英数字
        rtrim(brsirskcd,' 　')::varchar(4) as brsirskcd,  -- 英数字
        rtrim(kozyocd,' 　')::varchar(1) as kozyocd,  -- 英数字
        rtrim(ukeirecd,' 　')::varchar(2) as ukeirecd,  -- 英数字
        rtrim(nyoteiymd,' 　')::varchar(8) as nyoteiymd,  -- 英数字
        rtrim(bohkymd,' 　')::varchar(8) as bohkymd,  -- 英数字
        rtrim(mtuserid,' 　')::varchar(16) as mtuserid,  -- 英数字
        try_to_timestamp_ntz(mttime,'yyyy-mm-dd-hh24.mi.ss.ff9') as mttime, --timestamp型
        rtrim(juchuymd,' 　')::varchar(8) as juchuymd,  -- 英数字
        ldts, -- b層のldts
        rank() over (
                partition by
                    ordrkey, tanskkey, juchuymd
                order by mttime desc, ldts desc
            ) aggkey
        from {{ ref('substr_cvn06dodrshiji') }}
    )
select *
from stg_cvn06dodrshiji
where aggkey = 1