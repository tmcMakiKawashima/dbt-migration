{{ config(materialized='table') }}

with stg_tbdaiml as (
    select
        rtrim(KYOUHAN, ' 　')::VARCHAR(5) as KYOUHAN, -- 英数字
        IFF(rtrim(USERCD) = '', '', LPAD(rtrim(USERCD), length(USERCD), '0'))::VARCHAR(5) as USERCD, -- コード／区分
        rtrim(KAISYA, ' 　')::VARCHAR(2) as KAISYA, -- 英数字
        rtrim(TCHUMON, ' 　')::VARCHAR(14) as TCHUMON, -- 英数字
        rtrim(HINBAN, ' 　')::VARCHAR(20) as HINBAN, -- 英数字
        rtrim(MEKAKB, ' 　')::VARCHAR(1) as MEKAKB, -- 英数字
        rtrim(FRMKB, ' 　')::VARCHAR(3) as FRMKB, -- 英数字
        rtrim(FRMNO, ' 　')::VARCHAR(7) as FRMNO, -- 英数字
        rtrim(HANKATA, ' 　')::VARCHAR(20) as HANKATA, -- 英数字
        rtrim(TORITOKB, ' 　')::VARCHAR(1) as TORITOKB, -- 英数字
        rtrim(JYOTAI, ' 　')::VARCHAR(1) as JYOTAI, -- 英数字
        IFF(rtrim(HIKYOTEN) = '', '', LPAD(rtrim(HIKYOTEN), length(HIKYOTEN), '0'))::VARCHAR(2) as HIKYOTEN, -- コード／区分
        rtrim("JUTYUSU-S", ' 　')::VARCHAR(1) as "JUTYUSU-S", -- 英数字
        to_decimal(IFF(rtrim(JUTYUSU) = '', 0, rtrim(JUTYUSU)))::DECIMAL(5) as JUTYUSU, -- 数量／金額／数値
        rtrim(FCODE, ' 　')::VARCHAR(1) as FCODE, -- 英数字
        rtrim(TUIKAFLG, ' 　')::VARCHAR(1) as TUIKAFLG, -- 英数字
        rtrim(DELFLG, ' 　')::VARCHAR(1) as DELFLG, -- 英数字
        rtrim(SURYOUMU, ' 　')::VARCHAR(1) as SURYOUMU, -- 英数字
        IFF(rtrim(TYAKKO) = '', '', LPAD(rtrim(TYAKKO), length(TYAKKO), '0'))::VARCHAR(8) as TYAKKO, -- 日付
        IFF(rtrim(TYAKKOT) = '', '', LPAD(rtrim(TYAKKOT), length(TYAKKOT), '0'))::VARCHAR(4) as TYAKKOT, -- 時間
        rtrim(TYAKKOJ, ' 　')::VARCHAR(4) as TYAKKOJ, -- 英数字
        IFF(rtrim(NYUKA) = '', '', LPAD(rtrim(NYUKA), length(NYUKA), '0'))::VARCHAR(8) as NYUKA, -- 日付
        IFF(rtrim(NYUKAT) = '', '', LPAD(rtrim(NYUKAT), length(NYUKAT), '0'))::VARCHAR(4) as NYUKAT, -- 時間
        rtrim(NYUKAKB, ' 　')::VARCHAR(1) as NYUKAKB, -- 英数字
        rtrim(RIJEERC, ' 　')::VARCHAR(2) as RIJEERC, -- 英数字
        rtrim(RIJEERM, ' 　')::VARCHAR(6) as RIJEERM, -- 英数字
        IFF(rtrim(HIKIATE1) = '', '', LPAD(rtrim(HIKIATE1), length(HIKIATE1), '0'))::VARCHAR(8) as HIKIATE1, -- 日付
        rtrim("RIZASU1-S", ' 　')::VARCHAR(1) as "RIZASU1-S", -- 英数字
        to_decimal(IFF(rtrim(RIZASU1) = '', 0, rtrim(RIZASU1)))::DECIMAL(5) as RIZASU1, -- 数量／金額／数値
        rtrim("SEISISU1-S", ' 　')::VARCHAR(1) as "SEISISU1-S", -- 英数字
        to_decimal(IFF(rtrim(SEISISU1) = '', 0, rtrim(SEISISU1)))::DECIMAL(5) as SEISISU1, -- 数量／金額／数値
        rtrim("MISYUKA1-S", ' 　')::VARCHAR(1) as "MISYUKA1-S", -- 英数字
        to_decimal(IFF(rtrim(MISYUKA1) = '', 0, rtrim(MISYUKA1)))::DECIMAL(5) as MISYUKA1, -- 数量／金額／数値
        IFF(rtrim(HIKIATE2) = '', '', LPAD(rtrim(HIKIATE2), length(HIKIATE2), '0'))::VARCHAR(8) as HIKIATE2, -- 日付
        rtrim("RIZASU2-S", ' 　')::VARCHAR(1) as "RIZASU2-S", -- 英数字
        to_decimal(IFF(rtrim(RIZASU2) = '', 0, rtrim(RIZASU2)))::DECIMAL(5) as RIZASU2, -- 数量／金額／数値
        rtrim("SEISISU2-S", ' 　')::VARCHAR(1) as "SEISISU2-S", -- 英数字
        to_decimal(IFF(rtrim(SEISISU2) = '', 0, rtrim(SEISISU2)))::DECIMAL(5) as SEISISU2, -- 数量／金額／数値
        rtrim("MISYUKA2-S", ' 　')::VARCHAR(1) as "MISYUKA2-S", -- 英数字
        to_decimal(IFF(rtrim(MISYUKA2) = '', 0, rtrim(MISYUKA2)))::DECIMAL(5) as MISYUKA2, -- 数量／金額／数値
        IFF(rtrim(HIKIATE3) = '', '', LPAD(rtrim(HIKIATE3), length(HIKIATE3), '0'))::VARCHAR(8) as HIKIATE3, -- 日付
        rtrim("RIZASU3-S", ' 　')::VARCHAR(1) as "RIZASU3-S", -- 英数字
        to_decimal(IFF(rtrim(RIZASU3) = '', 0, rtrim(RIZASU3)))::DECIMAL(5) as RIZASU3, -- 数量／金額／数値
        rtrim("SEISISU3-S", ' 　')::VARCHAR(1) as "SEISISU3-S", -- 英数字
        to_decimal(IFF(rtrim(SEISISU3) = '', 0, rtrim(SEISISU3)))::DECIMAL(5) as SEISISU3, -- 数量／金額／数値
        rtrim("MISYUKA3-S", ' 　')::VARCHAR(1) as "MISYUKA3-S", -- 英数字
        to_decimal(IFF(rtrim(MISYUKA3) = '', 0, rtrim(MISYUKA3)))::DECIMAL(5) as MISYUKA3, -- 数量／金額／数値
        IFF(rtrim(HIKIATE4) = '', '', LPAD(rtrim(HIKIATE4), length(HIKIATE4), '0'))::VARCHAR(8) as HIKIATE4, -- 日付
        rtrim("RIZASU4-S", ' 　')::VARCHAR(1) as "RIZASU4-S", -- 英数字
        to_decimal(IFF(rtrim(RIZASU4) = '', 0, rtrim(RIZASU4)))::DECIMAL(5) as RIZASU4, -- 数量／金額／数値
        rtrim("SEISISU4-S", ' 　')::VARCHAR(1) as "SEISISU4-S", -- 英数字
        to_decimal(IFF(rtrim(SEISISU4) = '', 0, rtrim(SEISISU4)))::DECIMAL(5) as SEISISU4, -- 数量／金額／数値
        rtrim("MISYUKA4-S", ' 　')::VARCHAR(1) as "MISYUKA4-S", -- 英数字
        to_decimal(IFF(rtrim(MISYUKA4) = '', 0, rtrim(MISYUKA4)))::DECIMAL(5) as MISYUKA4, -- 数量／金額／数値
        IFF(rtrim(HIKIATE5) = '', '', LPAD(rtrim(HIKIATE5), length(HIKIATE5), '0'))::VARCHAR(8) as HIKIATE5, -- 日付
        rtrim("RIZASU5-S", ' 　')::VARCHAR(1) as "RIZASU5-S", -- 英数字
        to_decimal(IFF(rtrim(RIZASU5) = '', 0, rtrim(RIZASU5)))::DECIMAL(5) as RIZASU5, -- 数量／金額／数値
        rtrim("SEISISU5-S", ' 　')::VARCHAR(1) as "SEISISU5-S", -- 英数字
        to_decimal(IFF(rtrim(SEISISU5) = '', 0, rtrim(SEISISU5)))::DECIMAL(5) as SEISISU5, -- 数量／金額／数値
        rtrim("MISYUKA5-S", ' 　')::VARCHAR(1) as "MISYUKA5-S", -- 英数字
        to_decimal(IFF(rtrim(MISYUKA5) = '', 0, rtrim(MISYUKA5)))::DECIMAL(5) as MISYUKA5, -- 数量／金額／数値
        rtrim("HIKIKEI-S", ' 　')::VARCHAR(1) as "HIKIKEI-S", -- 英数字
        to_decimal(IFF(rtrim(HIKIKEI) = '', 0, rtrim(HIKIKEI)))::DECIMAL(5) as HIKIKEI, -- 数量／金額／数値
        rtrim(ZENHKFLG, ' 　')::VARCHAR(1) as ZENHKFLG, -- 英数字
        IFF(rtrim(ZENHIKDD) = '', '', LPAD(rtrim(ZENHIKDD), length(ZENHIKDD), '0'))::VARCHAR(8) as ZENHIKDD, -- 日付
        rtrim(HINBANKB, ' 　')::VARCHAR(1) as HINBANKB, -- 英数字
        rtrim(TANKAFLG, ' 　')::VARCHAR(1) as TANKAFLG, -- 英数字
        IFF(rtrim(GENKACD) = '', '', LPAD(rtrim(GENKACD), length(GENKACD), '0'))::VARCHAR(1) as GENKACD, -- コード／区分
        rtrim("PRICEKN-S", ' 　')::VARCHAR(1) as "PRICEKN-S", -- 英数字
        to_decimal(IFF(rtrim(PRICEKN) = '', 0, rtrim(PRICEKN)))::DECIMAL(7) as PRICEKN, -- 数量／金額／数値
        rtrim("NOHINBAK-S", ' 　')::VARCHAR(1) as "NOHINBAK-S", -- 英数字
        to_decimal(IFF(rtrim(NOHINBAK) = '', 0, rtrim(NOHINBAK)))::DECIMAL(7) as NOHINBAK, -- 数量／金額／数値
        rtrim("TEKIBAK-S", ' 　')::VARCHAR(1) as "TEKIBAK-S", -- 英数字
        to_decimal(IFF(rtrim(TEKIBAK) = '', 0, rtrim(TEKIBAK)))::DECIMAL(7) as TEKIBAK, -- 数量／金額／数値
        rtrim("PRICELP-S", ' 　')::VARCHAR(1) as "PRICELP-S", -- 英数字
        to_decimal(IFF(rtrim(PRICELP) = '', 0, rtrim(PRICELP)))::DECIMAL(7) as PRICELP, -- 数量／金額／数値
        rtrim(ZANTEIKK, ' 　')::VARCHAR(1) as ZANTEIKK, -- 英数字
        rtrim(KKCLS, ' 　')::VARCHAR(2) as KKCLS, -- 英数字
        IFF(rtrim(HINSIJI) = '', '', LPAD(rtrim(HINSIJI), length(HINSIJI), '0'))::VARCHAR(1) as HINSIJI, -- コード／区分
        IFF(rtrim(TANTEKI) = '', '', LPAD(rtrim(TANTEKI), length(TANTEKI), '0'))::VARCHAR(3) as TANTEKI, -- コード／区分
        IFF(rtrim(SSHINMOK) = '', '', LPAD(rtrim(SSHINMOK), length(SSHINMOK), '0'))::VARCHAR(2) as SSHINMOK, -- コード／区分
        rtrim(GAITOLES, ' 　')::VARCHAR(1) as GAITOLES, -- 英数字
        to_decimal(IFF(rtrim(PKANFLG) = '', 0, rtrim(PKANFLG)))::VARCHAR(1) as PKANFLG, -- フラグ
        rtrim(HATYUHIN, ' 　')::VARCHAR(20) as HATYUHIN, -- 英数字
        rtrim(HATYUMKB, ' 　')::VARCHAR(1) as HATYUMKB, -- 英数字
        rtrim(NYUKOHIN, ' 　')::VARCHAR(20) as NYUKOHIN, -- 英数字
        rtrim(NYUKOMKB, ' 　')::VARCHAR(1) as NYUKOMKB, -- 英数字
        rtrim(ITAKUFLG, ' 　')::VARCHAR(1) as ITAKUFLG, -- 英数字
        rtrim(ITAKUHAN, ' 　')::VARCHAR(5) as ITAKUHAN, -- 英数字
        IFF(rtrim(ITAKUUSR) = '', '', LPAD(rtrim(ITAKUUSR), length(ITAKUUSR), '0'))::VARCHAR(5) as ITAKUUSR, -- コード／区分
        rtrim("RIZAZKSU-S", ' 　')::VARCHAR(1) as "RIZAZKSU-S", -- 英数字
        to_decimal(IFF(rtrim(RIZAZKSU) = '', 0, rtrim(RIZAZKSU)))::DECIMAL(5) as RIZAZKSU, -- 数量／金額／数値
        rtrim(ZUMIFLG, ' 　')::VARCHAR(1) as ZUMIFLG, -- 英数字
        rtrim("HATYUSU-S", ' 　')::VARCHAR(1) as "HATYUSU-S", -- 英数字
        to_decimal(IFF(rtrim(HATYUSU) = '', 0, rtrim(HATYUSU)))::DECIMAL(5) as HATYUSU, -- 数量／金額／数値
        rtrim("KABUSOKU-S", ' 　')::VARCHAR(1) as "KABUSOKU-S", -- 英数字
        to_decimal(IFF(rtrim(KABUSOKU) = '', 0, rtrim(KABUSOKU)))::DECIMAL(5) as KABUSOKU, -- 数量／金額／数値
        rtrim("HATYUCAN-S", ' 　')::VARCHAR(1) as "HATYUCAN-S", -- 英数字
        to_decimal(IFF(rtrim(HATYUCAN) = '', 0, rtrim(HATYUCAN)))::DECIMAL(5) as HATYUCAN, -- 数量／金額／数値
        rtrim("ZUMKAKSU-S", ' 　')::VARCHAR(1) as "ZUMKAKSU-S", -- 英数字
        to_decimal(IFF(rtrim(ZUMKAKSU) = '', 0, rtrim(ZUMKAKSU)))::DECIMAL(5) as ZUMKAKSU, -- 数量／金額／数値
        rtrim("HAZAIKSU-S", ' 　')::VARCHAR(1) as "HAZAIKSU-S", -- 英数字
        to_decimal(IFF(rtrim(HAZAIKSU) = '', 0, rtrim(HAZAIKSU)))::DECIMAL(5) as HAZAIKSU, -- 数量／金額／数値
        rtrim(SYKAREA, ' 　')::VARCHAR(1) as SYKAREA, -- 英数字
        rtrim(SYKRKG, ' 　')::VARCHAR(1) as SYKRKG, -- 英数字
        rtrim(SYKROK, ' 　')::VARCHAR(8) as SYKROK, -- 英数字
        rtrim(SYKLBFLG, ' 　')::VARCHAR(1) as SYKLBFLG, -- 英数字
        rtrim(SIJIF, ' 　')::VARCHAR(1) as SIJIF, -- 英数字
        rtrim(DENNO1, ' 　')::VARCHAR(6) as DENNO1, -- 英数字
        rtrim(DENNO2, ' 　')::VARCHAR(6) as DENNO2, -- 英数字
        rtrim(DENNO3, ' 　')::VARCHAR(6) as DENNO3, -- 英数字
        rtrim(DENNO4, ' 　')::VARCHAR(6) as DENNO4, -- 英数字
        rtrim(DENNO5, ' 　')::VARCHAR(6) as DENNO5, -- 英数字
        rtrim("HIKIATSU-S", ' 　')::VARCHAR(1) as "HIKIATSU-S", -- 英数字
        to_decimal(IFF(rtrim(HIKIATSU) = '', 0, rtrim(HIKIATSU)))::DECIMAL(6) as HIKIATSU, -- 数量／金額／数値
        rtrim(KAKLBFLG, ' 　')::VARCHAR(1) as KAKLBFLG, -- 英数字
        rtrim(HZUMIFLG, ' 　')::VARCHAR(1) as HZUMIFLG, -- 英数字
        rtrim(RIMARKU1, ' 　')::VARCHAR(8) as RIMARKU1, -- 英数字
        rtrim(RIMARKU2, ' 　')::VARCHAR(10) as RIMARKU2, -- 英数字
        rtrim(HASSIN, ' 　')::VARCHAR(5) as HASSIN, -- 英数字
        rtrim(KAKAKUSKB, ' 　')::VARCHAR(1) as KAKAKUSKB, -- 英数字
        to_decimal(IFF(rtrim(DAIMEIREN) = '', 0, rtrim(DAIMEIREN)))::DECIMAL(8) as DAIMEIREN, -- 数量／金額／数値
        LDTS, -- B層のLDTS
        RANK() over (partition by KYOUHAN, HASSIN, USERCD, KAISYA, TCHUMON, HINBAN, MEKAKB, HIKIATE1 order by LDTS desc) aggkey
    from {{ ref('substr_tbdaiml') }}
)
select * from stg_tbdaiml
where aggkey = 1
