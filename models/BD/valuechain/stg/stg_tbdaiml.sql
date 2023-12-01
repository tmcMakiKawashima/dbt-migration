with stg_tbdaiml as (
    select
        rtrim(kyouhan, ' 　')::varchar(5) as kyouhan, -- 英数字
        iff(rtrim(usercd) = '', '', lpad(rtrim(usercd), length(usercd), '0'))::varchar(5) as usercd, -- コード／区分
        rtrim(kaisya, ' 　')::varchar(2) as kaisya, -- 英数字
        rtrim(tchumon, ' 　')::varchar(14) as tchumon, -- 英数字
        rtrim(hinban, ' 　')::varchar(20) as hinban, -- 英数字
        rtrim(mekakb, ' 　')::varchar(1) as mekakb, -- 英数字
        rtrim(frmkb, ' 　')::varchar(3) as frmkb, -- 英数字
        rtrim(frmno, ' 　')::varchar(7) as frmno, -- 英数字
        rtrim(hankata, ' 　')::varchar(20) as hankata, -- 英数字
        rtrim(toritokb, ' 　')::varchar(1) as toritokb, -- 英数字
        rtrim(jyotai, ' 　')::varchar(1) as jyotai, -- 英数字
        iff(rtrim(hikyoten) = '', '', lpad(rtrim(hikyoten), length(hikyoten), '0'))::varchar(2) as hikyoten, -- コード／区分
        rtrim("JUTYUSU-S", ' 　')::varchar(1) as "JUTYUSU-S", -- 英数字
        to_decimal(iff(rtrim(jutyusu) = '', 0, rtrim(jutyusu)))::decimal(5) as jutyusu, -- 数量／金額／数値
        rtrim(fcode, ' 　')::varchar(1) as fcode, -- 英数字
        rtrim(tuikaflg, ' 　')::varchar(1) as tuikaflg, -- 英数字
        rtrim(delflg, ' 　')::varchar(1) as delflg, -- 英数字
        rtrim(suryoumu, ' 　')::varchar(1) as suryoumu, -- 英数字
        iff(rtrim(tyakko) = '', '', lpad(rtrim(tyakko), length(tyakko), '0'))::varchar(8) as tyakko, -- 日付
        iff(rtrim(tyakkot) = '', '', lpad(rtrim(tyakkot), length(tyakkot), '0'))::varchar(4) as tyakkot, -- 時間
        rtrim(tyakkoj, ' 　')::varchar(4) as tyakkoj, -- 英数字
        iff(rtrim(nyuka) = '', '', lpad(rtrim(nyuka), length(nyuka), '0'))::varchar(8) as nyuka, -- 日付
        iff(rtrim(nyukat) = '', '', lpad(rtrim(nyukat), length(nyukat), '0'))::varchar(4) as nyukat, -- 時間
        rtrim(nyukakb, ' 　')::varchar(1) as nyukakb, -- 英数字
        rtrim(rijeerc, ' 　')::varchar(2) as rijeerc, -- 英数字
        rtrim(rijeerm, ' 　')::varchar(6) as rijeerm, -- 英数字
        iff(rtrim(hikiate1) = '', '', lpad(rtrim(hikiate1), length(hikiate1), '0'))::varchar(8) as hikiate1, -- 日付
        rtrim("RIZASU1-S", ' 　')::varchar(1) as "RIZASU1-S", -- 英数字
        to_decimal(iff(rtrim(rizasu1) = '', 0, rtrim(rizasu1)))::decimal(5) as rizasu1, -- 数量／金額／数値
        rtrim("SEISISU1-S", ' 　')::varchar(1) as "SEISISU1-S", -- 英数字
        to_decimal(iff(rtrim(seisisu1) = '', 0, rtrim(seisisu1)))::decimal(5) as seisisu1, -- 数量／金額／数値
        rtrim("MISYUKA1-S", ' 　')::varchar(1) as "MISYUKA1-S", -- 英数字
        to_decimal(iff(rtrim(misyuka1) = '', 0, rtrim(misyuka1)))::decimal(5) as misyuka1, -- 数量／金額／数値
        iff(rtrim(hikiate2) = '', '', lpad(rtrim(hikiate2), length(hikiate2), '0'))::varchar(8) as hikiate2, -- 日付
        rtrim("RIZASU2-S", ' 　')::varchar(1) as "RIZASU2-S", -- 英数字
        to_decimal(iff(rtrim(rizasu2) = '', 0, rtrim(rizasu2)))::decimal(5) as rizasu2, -- 数量／金額／数値
        rtrim("SEISISU2-S", ' 　')::varchar(1) as "SEISISU2-S", -- 英数字
        to_decimal(iff(rtrim(seisisu2) = '', 0, rtrim(seisisu2)))::decimal(5) as seisisu2, -- 数量／金額／数値
        rtrim("MISYUKA2-S", ' 　')::varchar(1) as "MISYUKA2-S", -- 英数字
        to_decimal(iff(rtrim(misyuka2) = '', 0, rtrim(misyuka2)))::decimal(5) as misyuka2, -- 数量／金額／数値
        iff(rtrim(hikiate3) = '', '', lpad(rtrim(hikiate3), length(hikiate3), '0'))::varchar(8) as hikiate3, -- 日付
        rtrim("RIZASU3-S", ' 　')::varchar(1) as "RIZASU3-S", -- 英数字
        to_decimal(iff(rtrim(rizasu3) = '', 0, rtrim(rizasu3)))::decimal(5) as rizasu3, -- 数量／金額／数値
        rtrim("SEISISU3-S", ' 　')::varchar(1) as "SEISISU3-S", -- 英数字
        to_decimal(iff(rtrim(seisisu3) = '', 0, rtrim(seisisu3)))::decimal(5) as seisisu3, -- 数量／金額／数値
        rtrim("MISYUKA3-S", ' 　')::varchar(1) as "MISYUKA3-S", -- 英数字
        to_decimal(iff(rtrim(misyuka3) = '', 0, rtrim(misyuka3)))::decimal(5) as misyuka3, -- 数量／金額／数値
        iff(rtrim(hikiate4) = '', '', lpad(rtrim(hikiate4), length(hikiate4), '0'))::varchar(8) as hikiate4, -- 日付
        rtrim("RIZASU4-S", ' 　')::varchar(1) as "RIZASU4-S", -- 英数字
        to_decimal(iff(rtrim(rizasu4) = '', 0, rtrim(rizasu4)))::decimal(5) as rizasu4, -- 数量／金額／数値
        rtrim("SEISISU4-S", ' 　')::varchar(1) as "SEISISU4-S", -- 英数字
        to_decimal(iff(rtrim(seisisu4) = '', 0, rtrim(seisisu4)))::decimal(5) as seisisu4, -- 数量／金額／数値
        rtrim("MISYUKA4-S", ' 　')::varchar(1) as "MISYUKA4-S", -- 英数字
        to_decimal(iff(rtrim(misyuka4) = '', 0, rtrim(misyuka4)))::decimal(5) as misyuka4, -- 数量／金額／数値
        iff(rtrim(hikiate5) = '', '', lpad(rtrim(hikiate5), length(hikiate5), '0'))::varchar(8) as hikiate5, -- 日付
        rtrim("RIZASU5-S", ' 　')::varchar(1) as "RIZASU5-S", -- 英数字
        to_decimal(iff(rtrim(rizasu5) = '', 0, rtrim(rizasu5)))::decimal(5) as rizasu5, -- 数量／金額／数値
        rtrim("SEISISU5-S", ' 　')::varchar(1) as "SEISISU5-S", -- 英数字
        to_decimal(iff(rtrim(seisisu5) = '', 0, rtrim(seisisu5)))::decimal(5) as seisisu5, -- 数量／金額／数値
        rtrim("MISYUKA5-S", ' 　')::varchar(1) as "MISYUKA5-S", -- 英数字
        to_decimal(iff(rtrim(misyuka5) = '', 0, rtrim(misyuka5)))::decimal(5) as misyuka5, -- 数量／金額／数値
        rtrim("HIKIKEI-S", ' 　')::varchar(1) as "HIKIKEI-S", -- 英数字
        to_decimal(iff(rtrim(hikikei) = '', 0, rtrim(hikikei)))::decimal(5) as hikikei, -- 数量／金額／数値
        rtrim(zenhkflg, ' 　')::varchar(1) as zenhkflg, -- 英数字
        iff(rtrim(zenhikdd) = '', '', lpad(rtrim(zenhikdd), length(zenhikdd), '0'))::varchar(8) as zenhikdd, -- 日付
        rtrim(hinbankb, ' 　')::varchar(1) as hinbankb, -- 英数字
        rtrim(tankaflg, ' 　')::varchar(1) as tankaflg, -- 英数字
        iff(rtrim(genkacd) = '', '', lpad(rtrim(genkacd), length(genkacd), '0'))::varchar(1) as genkacd, -- コード／区分
        rtrim("PRICEKN-S", ' 　')::varchar(1) as "PRICEKN-S", -- 英数字
        to_decimal(iff(rtrim(pricekn) = '', 0, rtrim(pricekn)))::decimal(7) as pricekn, -- 数量／金額／数値
        rtrim("NOHINBAK-S", ' 　')::varchar(1) as "NOHINBAK-S", -- 英数字
        to_decimal(iff(rtrim(nohinbak) = '', 0, rtrim(nohinbak)))::decimal(7) as nohinbak, -- 数量／金額／数値
        rtrim("TEKIBAK-S", ' 　')::varchar(1) as "TEKIBAK-S", -- 英数字
        to_decimal(iff(rtrim(tekibak) = '', 0, rtrim(tekibak)))::decimal(7) as tekibak, -- 数量／金額／数値
        rtrim("PRICELP-S", ' 　')::varchar(1) as "PRICELP-S", -- 英数字
        to_decimal(iff(rtrim(pricelp) = '', 0, rtrim(pricelp)))::decimal(7) as pricelp, -- 数量／金額／数値
        rtrim(zanteikk, ' 　')::varchar(1) as zanteikk, -- 英数字
        rtrim(kkcls, ' 　')::varchar(2) as kkcls, -- 英数字
        iff(rtrim(hinsiji) = '', '', lpad(rtrim(hinsiji), length(hinsiji), '0'))::varchar(1) as hinsiji, -- コード／区分
        iff(rtrim(tanteki) = '', '', lpad(rtrim(tanteki), length(tanteki), '0'))::varchar(3) as tanteki, -- コード／区分
        iff(rtrim(sshinmok) = '', '', lpad(rtrim(sshinmok), length(sshinmok), '0'))::varchar(2) as sshinmok, -- コード／区分
        rtrim(gaitoles, ' 　')::varchar(1) as gaitoles, -- 英数字
        iff(rtrim(pkanflg) = '', '', lpad(rtrim(pkanflg), length(pkanflg), '0'))::varchar(1) as pkanflg, -- フラグ
        rtrim(hatyuhin, ' 　')::varchar(20) as hatyuhin, -- 英数字
        rtrim(hatyumkb, ' 　')::varchar(1) as hatyumkb, -- 英数字
        rtrim(nyukohin, ' 　')::varchar(20) as nyukohin, -- 英数字
        rtrim(nyukomkb, ' 　')::varchar(1) as nyukomkb, -- 英数字
        rtrim(itakuflg, ' 　')::varchar(1) as itakuflg, -- 英数字
        rtrim(itakuhan, ' 　')::varchar(5) as itakuhan, -- 英数字
        iff(rtrim(itakuusr) = '', '', lpad(rtrim(itakuusr), length(itakuusr), '0'))::varchar(5) as itakuusr, -- コード／区分
        rtrim("RIZAZKSU-S", ' 　')::varchar(1) as "RIZAZKSU-S", -- 英数字
        to_decimal(iff(rtrim(rizazksu) = '', 0, rtrim(rizazksu)))::decimal(5) as rizazksu, -- 数量／金額／数値
        rtrim(zumiflg, ' 　')::varchar(1) as zumiflg, -- 英数字
        rtrim("HATYUSU-S", ' 　')::varchar(1) as "HATYUSU-S", -- 英数字
        to_decimal(iff(rtrim(hatyusu) = '', 0, rtrim(hatyusu)))::decimal(5) as hatyusu, -- 数量／金額／数値
        rtrim("KABUSOKU-S", ' 　')::varchar(1) as "KABUSOKU-S", -- 英数字
        to_decimal(iff(rtrim(kabusoku) = '', 0, rtrim(kabusoku)))::decimal(5) as kabusoku, -- 数量／金額／数値
        rtrim("HATYUCAN-S", ' 　')::varchar(1) as "HATYUCAN-S", -- 英数字
        to_decimal(iff(rtrim(hatyucan) = '', 0, rtrim(hatyucan)))::decimal(5) as hatyucan, -- 数量／金額／数値
        rtrim("ZUMKAKSU-S", ' 　')::varchar(1) as "ZUMKAKSU-S", -- 英数字
        to_decimal(iff(rtrim(zumkaksu) = '', 0, rtrim(zumkaksu)))::decimal(5) as zumkaksu, -- 数量／金額／数値
        rtrim("HAZAIKSU-S", ' 　')::varchar(1) as "HAZAIKSU-S", -- 英数字
        to_decimal(iff(rtrim(hazaiksu) = '', 0, rtrim(hazaiksu)))::decimal(5) as hazaiksu, -- 数量／金額／数値
        rtrim(sykarea, ' 　')::varchar(1) as sykarea, -- 英数字
        rtrim(sykrkg, ' 　')::varchar(1) as sykrkg, -- 英数字
        rtrim(sykrok, ' 　')::varchar(8) as sykrok, -- 英数字
        rtrim(syklbflg, ' 　')::varchar(1) as syklbflg, -- 英数字
        rtrim(sijif, ' 　')::varchar(1) as sijif, -- 英数字
        rtrim(denno1, ' 　')::varchar(6) as denno1, -- 英数字
        rtrim(denno2, ' 　')::varchar(6) as denno2, -- 英数字
        rtrim(denno3, ' 　')::varchar(6) as denno3, -- 英数字
        rtrim(denno4, ' 　')::varchar(6) as denno4, -- 英数字
        rtrim(denno5, ' 　')::varchar(6) as denno5, -- 英数字
        rtrim("HIKIATSU-S", ' 　')::varchar(1) as "HIKIATSU-S", -- 英数字
        to_decimal(iff(rtrim(hikiatsu) = '', 0, rtrim(hikiatsu)))::decimal(6) as hikiatsu, -- 数量／金額／数値
        rtrim(kaklbflg, ' 　')::varchar(1) as kaklbflg, -- 英数字
        rtrim(hzumiflg, ' 　')::varchar(1) as hzumiflg, -- 英数字
        rtrim(rimarku1, ' 　')::varchar(8) as rimarku1, -- 英数字
        rtrim(rimarku2, ' 　')::varchar(10) as rimarku2, -- 英数字
        rtrim(hassin, ' 　')::varchar(5) as hassin, -- 英数字
        rtrim(kakakuskb, ' 　')::varchar(1) as kakakuskb, -- 英数字
        to_decimal(iff(rtrim(daimeiren) = '', 0, rtrim(daimeiren)))::decimal(8) as daimeiren, -- 数量／金額／数値
        iff(rtrim(jznjusin) = '', '', lpad(rtrim(jznjusin), length(jznjusin), '0'))::varchar(8) as jznjusin, -- 日付
        ldts, -- B層のLDTS
        rank() over (partition by kyouhan, hassin, usercd, kaisya, tchumon, hinban, mekakb, jznjusin order by ldts desc) aggkey
    from {{ ref('substr_tbdaiml') }}
)
select * from stg_tbdaiml
where aggkey = 1
