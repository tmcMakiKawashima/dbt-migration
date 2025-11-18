{{
    config(
        materialized='incremental',
        incremental_strategy = 'append'
    )
}}

with stg_mitsumori_ordersyorikekka_atop as (
    select
        iff(rtrim(dataid4, ' 　') = '', null, rtrim(dataid4, ' 　'))::varchar(4) as dataid4,
        iff(rtrim(ordmtmrzok, ' 　') = '', null, rtrim(ordmtmrzok, ' 　'))::varchar(1) as ordmtmrzok,
        iff(rtrim(datazok, ' 　') = '', null, rtrim(datazok, ' 　'))::varchar(1) as datazok,
        iff(rtrim(dlrcd, ' 　') = '', null, rtrim(dlrcd, ' 　'))::varchar(7) as dlrcd,
        iff(rtrim(juchuymd, ' 　') ='', null, try_to_date(juchuymd, 'yyyymmdd'))::date as juchuymd,
        iff(rtrim(odrno, ' 　') = '', null, rtrim(odrno, ' 　'))::varchar(8) as odrno,
        iff(rtrim(itemno, ' 　') = '', null, rtrim(itemno, ' 　'))::varchar(4) as itemno,
        iff(rtrim(jurrsymd, ' 　') ='', null, try_to_date(jurrsymd, 'yyyymmdd'))::date as jurrsymd,
        iff(rtrim(portcd, ' 　') = '', null, rtrim(portcd, ' 　'))::varchar(1) as portcd,
        iff(rtrim(yusokbn, ' 　') = '', null, rtrim(yusokbn, ' 　'))::varchar(1) as yusokbn,
        iff(rtrim(ordrtype, ' 　') = '', null, rtrim(ordrtype, ' 　'))::varchar(1) as ordrtype,
        iff(rtrim(ordtsyri, ' 　') = '', null, rtrim(ordtsyri, ' 　'))::varchar(1) as ordtsyri,
        iff(rtrim(knkyudo, ' 　') = '', null, rtrim(knkyudo, ' 　'))::varchar(1) as knkyudo,
        iff(rtrim(odrzok, ' 　') = '', null, rtrim(odrzok, ' 　'))::varchar(1) as odrzok,
        iff(rtrim(yumukbn, ' 　') = '', null, rtrim(yumukbn, ' 　'))::varchar(1) as yumukbn,
        iff(rtrim(hyoftnbs, ' 　') = '', null, rtrim(hyoftnbs, ' 　'))::varchar(1) as hyoftnbs,
        iff(rtrim(kyoseicd, ' 　') = '', null, rtrim(kyoseicd, ' 　'))::varchar(1) as kyoseicd,
        iff(rtrim(hanbaicd, ' 　') = '', null, rtrim(hanbaicd, ' 　'))::varchar(1) as hanbaicd,
        iff(rtrim(bocd, ' 　') = '', null, rtrim(bocd, ' 　'))::varchar(1) as bocd,
        iff(rtrim(extehacd, ' 　') = '', null, rtrim(extehacd, ' 　'))::varchar(1) as extehacd,
        iff(rtrim(spdiscount, ' 　') = '', null, rtrim(spdiscount, ' 　'))::varchar(4) as spdiscount,
        iff(rtrim(tuikakbn, ' 　') = '', null, rtrim(tuikakbn, ' 　'))::varchar(1) as tuikakbn,
        iff(rtrim(kkksrkbn, ' 　') = '', null, rtrim(kkksrkbn, ' 　'))::varchar(1) as kkksrkbn,
        iff(rtrim(sagyokgnymd, ' 　') ='', null, try_to_date(sagyokgnymd, 'yyyymmdd'))::date as sagyokgnymd,
        iff(rtrim(zuizikbn, ' 　') = '', null, rtrim(zuizikbn, ' 　'))::varchar(1) as zuizikbn,
        iff(rtrim(zuizirtu, ' 　') = '', null, rtrim(zuizirtu, ' 　'))::varchar(3) as zuizirtu,
        iff(rtrim(betmkcd, ' 　') = '', null, rtrim(betmkcd, ' 　'))::varchar(4) as betmkcd,
        iff(rtrim(jhinban, ' 　') = '', null, rtrim(jhinban, ' 　'))::varchar(20) as jhinban,
        iff(rtrim(juchusu, ' 　') = '', null, try_to_decimal(juchusu))::number(6,0) as juchusu,
        iff(rtrim(tarifcd, ' 　') = '', null, rtrim(tarifcd, ' 　'))::varchar(3) as tarifcd,
        iff(rtrim(zonecd, ' 　') = '', null, rtrim(zonecd, ' 　'))::varchar(2) as zonecd,
        iff(rtrim(distcom, ' 　') = '', null, rtrim(distcom, ' 　'))::varchar(8) as distcom,
        iff(rtrim(tansjymd, ' 　') ='', null, try_to_date(tansjymd, 'yyyymmdd'))::date as tansjymd,
        iff(rtrim(dlrmei, ' 　') = '', null, rtrim(dlrmei, ' 　'))::varchar(20) as dlrmei,
        iff(rtrim(pshukakbn, ' 　') = '', null, rtrim(pshukakbn, ' 　'))::varchar(1) as pshukakbn,
        iff(rtrim(douknhukakbn, ' 　') = '', null, rtrim(douknhukakbn, ' 　'))::varchar(1) as douknhukakbn,
        iff(rtrim(sytyubanflg, ' 　') = '', null, rtrim(sytyubanflg, ' 　'))::varchar(1) as sytyubanflg,
        iff(rtrim(tandkban, ' 　') = '', null, rtrim(tandkban, ' 　'))::varchar(1) as tandkban,
        iff(rtrim(knpktcd, ' 　') = '', null, rtrim(knpktcd, ' 　'))::varchar(1) as knpktcd,
        iff(rtrim(hanstsakcd, ' 　') = '', null, rtrim(hanstsakcd, ' 　'))::varchar(3) as hanstsakcd,
        iff(rtrim(snttsryokey, ' 　') = '', null, rtrim(snttsryokey, ' 　'))::varchar(3) as snttsryokey,
        iff(rtrim(kessai, ' 　') = '', null, rtrim(kessai, ' 　'))::varchar(2) as kessai,
        iff(rtrim(tatnkbn, ' 　') = '', null, rtrim(tatnkbn, ' 　'))::varchar(1) as tatnkbn,
        iff(rtrim(tndkinv, ' 　') = '', null, rtrim(tndkinv, ' 　'))::varchar(1) as tndkinv,
        iff(rtrim(tarifdkn, ' 　') = '', null, rtrim(tarifdkn, ' 　'))::varchar(1) as tarifdkn,
        iff(rtrim(syukkakyotenkbn, ' 　') = '', null, rtrim(syukkakyotenkbn, ' 　'))::varchar(1) as syukkakyotenkbn,
        iff(rtrim(shinban, ' 　') = '', null, rtrim(shinban, ' 　'))::varchar(20) as shinban,
        iff(rtrim(daitityp, ' 　') = '', null, rtrim(daitityp, ' 　'))::varchar(2) as daitityp,
        iff(rtrim(hinmeien, ' 　') = '', null, rtrim(hinmeien, ' 　'))::varchar(20) as hinmeien,
        iff(rtrim(tkytnkbn, ' 　') = '', null, rtrim(tkytnkbn, ' 　'))::varchar(1) as tkytnkbn,
        iff(rtrim(tkytnkinvkgi1, ' 　') = '', null, iff(try_to_decimal(tkytnkinvkgi1) is null, null, to_decimal(tkytnkinvkgi1)/power(10,2)))::number(11,2) as tkytnkinvkgi1,
        iff(rtrim(siteitnk11syo, ' 　') = '', null, iff(try_to_decimal(siteitnk11syo) is null, null, to_decimal(siteitnk11syo)/power(10,2)))::number(11,2) as siteitnk11syo,
        iff(rtrim(tukacd, ' 　') = '', null, rtrim(tukacd, ' 　'))::varchar(1) as tukacd,
        iff(rtrim(tokeibricd, ' 　') = '', null, rtrim(tokeibricd, ' 　'))::varchar(3) as tokeibricd,
        iff(rtrim(situryog8, ' 　') = '', null, iff(try_to_decimal(situryog8) is null, null, to_decimal(situryog8)/power(10,1)))::number(8,1) as situryog8,
        iff(rtrim(yoseki3, ' 　') = '', null, iff(try_to_decimal(yoseki3) is null, null, to_decimal(yoseki3)/power(10,1)))::number(10,1) as yoseki3,
        iff(rtrim(syusisu6, ' 　') = '', null, try_to_decimal(syusisu6))::number(6,0) as syusisu6,
        iff(rtrim(cansijsu, ' 　') = '', null, try_to_decimal(cansijsu))::number(6,0) as cansijsu,
        iff(rtrim(hinmkcd, ' 　') = '', null, rtrim(hinmkcd, ' 　'))::varchar(4) as hinmkcd,
        iff(rtrim(bohcd, ' 　') = '', null, rtrim(bohcd, ' 　'))::varchar(1) as bohcd,
        iff(rtrim(racd, ' 　') = '', null, rtrim(racd, ' 　'))::varchar(2) as racd,
        iff(rtrim(rejectcd, ' 　') = '', null, rtrim(rejectcd, ' 　'))::varchar(1) as rejectcd,
        iff(rtrim(propenid, ' 　') = '', null, rtrim(propenid, ' 　'))::varchar(2) as propenid,
        iff(rtrim(ordpenid, ' 　') = '', null, rtrim(ordpenid, ' 　'))::varchar(2) as ordpenid,
        iff(rtrim(tantokbn, ' 　') = '', null, rtrim(tantokbn, ' 　'))::varchar(1) as tantokbn,
        iff(rtrim(kaiseisyahinumu, ' 　') = '', null, rtrim(kaiseisyahinumu, ' 　'))::varchar(1) as kaiseisyahinumu,
        iff(rtrim(kaiseisyahinkbn, ' 　') = '', null, rtrim(kaiseisyahinkbn, ' 　'))::varchar(1) as kaiseisyahinkbn,
        iff(rtrim(siyusnsyasyucd, ' 　') = '', null, rtrim(siyusnsyasyucd, ' 　'))::varchar(4) as siyusnsyasyucd,
        iff(rtrim(syasyukbn, ' 　') = '', null, rtrim(syasyukbn, ' 　'))::varchar(1) as syasyukbn,
        iff(rtrim(siyusnkyokucd, ' 　') = '', null, rtrim(siyusnkyokucd, ' 　'))::varchar(7) as siyusnkyokucd,
        iff(rtrim(sksjkyokucd, ' 　') = '', null, rtrim(sksjkyokucd, ' 　'))::varchar(7) as sksjkyokucd,
        iff(rtrim(kaiseisyaracd, ' 　') = '', null, rtrim(kaiseisyaracd, ' 　'))::varchar(2) as kaiseisyaracd,
        ldts::timestamp_ntz(9) as ldts,
        iff(rtrim(juchuymd, ' 　') = '', 0, iff(try_to_date(juchuymd) is null, 1, 0)) as juchuymd_flg,
        iff(rtrim(jurrsymd, ' 　') = '', 0, iff(try_to_date(jurrsymd) is null, 1, 0)) as jurrsymd_flg,
        iff(rtrim(sagyokgnymd, ' 　') = '', 0, iff(try_to_date(sagyokgnymd) is null, 1, 0)) as sagyokgnymd_flg,
        iff(rtrim(tansjymd, ' 　') = '', 0, iff(try_to_date(tansjymd) is null, 1, 0)) as tansjymd_flg,
        iff(rtrim(juchusu, ' 　') = '', 0, iff(try_to_decimal(juchusu) is null, 1, 0)) as juchusu_flg,
        iff(rtrim(tkytnkinvkgi1, ' 　') = '', 0, iff(try_to_decimal(tkytnkinvkgi1) is null, 1, 0)) as tkytnkinvkgi1_flg,
        iff(rtrim(siteitnk11syo, ' 　') = '', 0, iff(try_to_decimal(siteitnk11syo) is null, 1, 0)) as siteitnk11syo_flg,
        iff(rtrim(situryog8, ' 　') = '', 0, iff(try_to_decimal(situryog8) is null, 1, 0)) as situryog8_flg,
        iff(rtrim(yoseki3, ' 　') = '', 0, iff(try_to_decimal(yoseki3) is null, 1, 0)) as yoseki3_flg,
        iff(rtrim(syusisu6, ' 　') = '', 0, iff(try_to_decimal(syusisu6) is null, 1, 0)) as syusisu6_flg,
        iff(rtrim(cansijsu, ' 　') = '', 0, iff(try_to_decimal(cansijsu) is null, 1, 0)) as cansijsu_flg
    from {{ref('substr_ktrla01vzz0kvp00q5')}}
    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{this}})
    {% endif %}
)
select * exclude(juchuymd_flg, jurrsymd_flg, sagyokgnymd_flg, tansjymd_flg, juchusu_flg, tkytnkinvkgi1_flg, siteitnk11syo_flg, situryog8_flg, yoseki3_flg, syusisu6_flg, cansijsu_flg) from stg_mitsumori_ordersyorikekka_atop
where dataid4 is not null
and juchuymd_flg = '0'
and jurrsymd_flg = '0'
and sagyokgnymd_flg = '0'
and tansjymd_flg = '0'
and juchusu_flg = '0'
and tkytnkinvkgi1_flg = '0'
and siteitnk11syo_flg = '0'
and situryog8_flg = '0'
and yoseki3_flg = '0'
and syusisu6_flg = '0'
and cansijsu_flg = '0'