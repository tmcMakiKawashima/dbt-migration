{{ config(materialized='incremental') }}

with stg_tbnsyus as (
    select
        rtrim(KYOUHAN, ' 　')::VARCHAR(5) as KYOUHAN, -- 英数字
        IFF(rtrim(GDENK) = '', '', LPAD(rtrim(GDENK), length(GDENK), '0'))::VARCHAR(2) as GDENK, -- コード／区分
        IFF(rtrim(DSYUBETS) = '', '', LPAD(rtrim(DSYUBETS), length(DSYUBETS), '0'))::VARCHAR(1) as DSYUBETS, -- コード／区分
        IFF(rtrim(KMEISAI) = '', '', LPAD(rtrim(KMEISAI), length(KMEISAI), '0'))::VARCHAR(1) as KMEISAI, -- コード／区分
        IFF(rtrim(ORIGIN) = '', '', LPAD(rtrim(ORIGIN), length(ORIGIN), '0'))::VARCHAR(1) as ORIGIN, -- コード／区分
        IFF(rtrim(SMEISAI) = '', '', LPAD(rtrim(SMEISAI), length(SMEISAI), '0'))::VARCHAR(1) as SMEISAI, -- コード／区分
        rtrim(HINBAN, ' 　')::VARCHAR(20) as HINBAN, -- 英数字
        rtrim(MKBN, ' 　')::VARCHAR(1) as MKBN, -- 英数字
        rtrim(HINKBN, ' 　')::VARCHAR(1) as HINKBN, -- 英数字
        IFF(rtrim(BUNSAN) = '', '', LPAD(rtrim(BUNSAN), length(BUNSAN), '0'))::VARCHAR(1) as BUNSAN, -- コード／区分
        IFF(rtrim(USRCOD) = '', '', LPAD(rtrim(USRCOD), length(USRCOD), '0'))::VARCHAR(5) as USRCOD, -- コード／区分
        IFF(rtrim(GSY) = '', '', LPAD(rtrim(GSY), length(GSY), '0'))::VARCHAR(2) as GSY, -- コード／区分
        rtrim(UKCOD, ' 　')::VARCHAR(1) as UKCOD, -- 英数字
        IFF(rtrim(HANABAI) = '', '', LPAD(rtrim(HANABAI), length(HANABAI), '0'))::VARCHAR(5) as HANABAI, -- コード／区分
        IFF(rtrim(KTN) = '', '', LPAD(rtrim(KTN), length(KTN), '0'))::VARCHAR(2) as KTN, -- コード／区分
        IFF(rtrim(KA) = '', '', LPAD(rtrim(KA), length(KA), '0'))::VARCHAR(1) as KA, -- コード／区分
        IFF(rtrim(STF) = '', '', LPAD(rtrim(STF), length(STF), '0'))::VARCHAR(2) as STF, -- コード／区分
        IFF(rtrim(BUTUSYU) = '', '', LPAD(rtrim(BUTUSYU), length(BUTUSYU), '0'))::VARCHAR(2) as BUTUSYU, -- コード／区分
        IFF(rtrim(JUCHU) = '', '', LPAD(rtrim(JUCHU), length(JUCHU), '0'))::VARCHAR(2) as JUCHU, -- コード／区分
        IFF(rtrim(UKEKTEN) = '', '', LPAD(rtrim(UKEKTEN), length(UKEKTEN), '0'))::VARCHAR(2) as UKEKTEN, -- コード／区分
        IFF(rtrim(KYOTENJ) = '', '', LPAD(rtrim(KYOTENJ), length(KYOTENJ), '0'))::VARCHAR(2) as KYOTENJ, -- コード／区分
        IFF(rtrim(KYOTEN1) = '', '', LPAD(rtrim(KYOTEN1), length(KYOTEN1), '0'))::VARCHAR(2) as KYOTEN1, -- コード／区分
        IFF(rtrim(KYOTEN2) = '', '', LPAD(rtrim(KYOTEN2), length(KYOTEN2), '0'))::VARCHAR(2) as KYOTEN2, -- コード／区分
        IFF(rtrim(KYOTEN3) = '', '', LPAD(rtrim(KYOTEN3), length(KYOTEN3), '0'))::VARCHAR(2) as KYOTEN3, -- コード／区分
        IFF(rtrim(HAIJ) = '', '', LPAD(rtrim(HAIJ), length(HAIJ), '0'))::VARCHAR(2) as HAIJ, -- コード／区分
        IFF(rtrim(HAI1) = '', '', LPAD(rtrim(HAI1), length(HAI1), '0'))::VARCHAR(2) as HAI1, -- コード／区分
        IFF(rtrim(HAI2) = '', '', LPAD(rtrim(HAI2), length(HAI2), '0'))::VARCHAR(2) as HAI2, -- コード／区分
        IFF(rtrim(HAI3) = '', '', LPAD(rtrim(HAI3), length(HAI3), '0'))::VARCHAR(2) as HAI3, -- コード／区分
        rtrim("JYUCYUU-S", ' 　')::VARCHAR(1) as "JYUCYUU-S", -- 英数字
        to_decimal(IFF(rtrim(JYUCYUU) = '', 0, rtrim(JYUCYUU)))::DECIMAL(7) as JYUCYUU, -- 数量／金額／数値
        rtrim("SYUKAJ-S", ' 　')::VARCHAR(1) as "SYUKAJ-S", -- 英数字
        to_decimal(IFF(rtrim(SYUKAJ) = '', 0, rtrim(SYUKAJ)))::DECIMAL(7) as SYUKAJ, -- 数量／金額／数値
        rtrim("FOLLOW1-S", ' 　')::VARCHAR(1) as "FOLLOW1-S", -- 英数字
        to_decimal(IFF(rtrim(FOLLOW1) = '', 0, rtrim(FOLLOW1)))::DECIMAL(7) as FOLLOW1, -- 数量／金額／数値
        rtrim("FOLLOW2-S", ' 　')::VARCHAR(1) as "FOLLOW2-S", -- 英数字
        to_decimal(IFF(rtrim(FOLLOW2) = '', 0, rtrim(FOLLOW2)))::DECIMAL(7) as FOLLOW2, -- 数量／金額／数値
        rtrim("FOLLOW3-S", ' 　')::VARCHAR(1) as "FOLLOW3-S", -- 英数字
        to_decimal(IFF(rtrim(FOLLOW3) = '', 0, rtrim(FOLLOW3)))::DECIMAL(7) as FOLLOW3, -- 数量／金額／数値
        rtrim("FOLLOWM-S", ' 　')::VARCHAR(1) as "FOLLOWM-S", -- 英数字
        to_decimal(IFF(rtrim(FOLLOWM) = '', 0, rtrim(FOLLOWM)))::DECIMAL(7) as FOLLOWM, -- 数量／金額／数値
        rtrim("FOLLOWR-S", ' 　')::VARCHAR(1) as "FOLLOWR-S", -- 英数字
        to_decimal(IFF(rtrim(FOLLOWR) = '', 0, rtrim(FOLLOWR)))::DECIMAL(7) as FOLLOWR, -- 数量／金額／数値
        rtrim("FOLLOWK-S", ' 　')::VARCHAR(1) as "FOLLOWK-S", -- 英数字
        to_decimal(IFF(rtrim(FOLLOWK) = '', 0, rtrim(FOLLOWK)))::DECIMAL(7) as FOLLOWK, -- 数量／金額／数値
        rtrim("KAKNOU-S", ' 　')::VARCHAR(1) as "KAKNOU-S", -- 英数字
        to_decimal(IFF(rtrim(KAKNOU) = '', 0, rtrim(KAKNOU)))::DECIMAL(7) as KAKNOU, -- 数量／金額／数値
        rtrim(DENNOJ, ' 　')::VARCHAR(6) as DENNOJ, -- 英数字
        rtrim(DENNO1, ' 　')::VARCHAR(6) as DENNO1, -- 英数字
        rtrim(DENNO2, ' 　')::VARCHAR(6) as DENNO2, -- 英数字
        rtrim(DENNO3, ' 　')::VARCHAR(6) as DENNO3, -- 英数字
        rtrim("SDATE-Y", ' 　')::VARCHAR(4) as "SDATE-Y", -- 英数字
        rtrim("SDATE-M", ' 　')::VARCHAR(2) as "SDATE-M", -- 英数字
        rtrim("SDATE-D", ' 　')::VARCHAR(2) as "SDATE-D", -- 英数字
        rtrim("TIME-H", ' 　')::VARCHAR(2) as "TIME-H", -- 英数字
        rtrim("TIME-M", ' 　')::VARCHAR(2) as "TIME-M", -- 英数字
        rtrim("JDATE-Y", ' 　')::VARCHAR(4) as "JDATE-Y", -- 英数字
        rtrim("JDATE-M", ' 　')::VARCHAR(2) as "JDATE-M", -- 英数字
        rtrim("JDATE-D", ' 　')::VARCHAR(2) as "JDATE-D", -- 英数字
        IFF(rtrim(GENKACD) = '', '', LPAD(rtrim(GENKACD), length(GENKACD), '0'))::VARCHAR(1) as GENKACD, -- コード／区分
        rtrim("KN-S", ' 　')::VARCHAR(1) as "KN-S", -- 英数字
        to_decimal(IFF(rtrim(KN) = '', 0, rtrim(KN)))::DECIMAL(7) as KN, -- 数量／金額／数値
        rtrim("NBAIKA-S", ' 　')::VARCHAR(1) as "NBAIKA-S", -- 英数字
        to_decimal(IFF(rtrim(NBAIKA) = '', 0, rtrim(NBAIKA)))::DECIMAL(7) as NBAIKA, -- 数量／金額／数値
        rtrim("TBAIKA-S", ' 　')::VARCHAR(1) as "TBAIKA-S", -- 英数字
        to_decimal(IFF(rtrim(TBAIKA) = '', 0, rtrim(TBAIKA)))::DECIMAL(7) as TBAIKA, -- 数量／金額／数値
        rtrim("LP-S", ' 　')::VARCHAR(1) as "LP-S", -- 英数字
        to_decimal(IFF(rtrim(LP) = '', 0, rtrim(LP)))::DECIMAL(7) as LP, -- 数量／金額／数値
        rtrim(KCLAS, ' 　')::VARCHAR(2) as KCLAS, -- 英数字
        IFF(rtrim(TANTEKI) = '', '', LPAD(rtrim(TANTEKI), length(TANTEKI), '0'))::VARCHAR(3) as TANTEKI, -- コード／区分
        rtrim(LESS, ' 　')::VARCHAR(1) as LESS, -- 英数字
        rtrim(SHINCD, ' 　')::VARCHAR(2) as SHINCD, -- 英数字
        rtrim(HINMOK, ' 　')::VARCHAR(4) as HINMOK, -- 英数字
        IFF(rtrim(SSHINMOK) = '', '', LPAD(rtrim(SSHINMOK), length(SSHINMOK), '0'))::VARCHAR(2) as SSHINMOK, -- コード／区分
        rtrim(TOKCHO, ' 　')::VARCHAR(10) as TOKCHO, -- 英数字
        rtrim(TREECD, ' 　')::VARCHAR(7) as TREECD, -- 英数字
        to_decimal(IFF(rtrim("KANZAN-I") = '', 0, rtrim("KANZAN-I")))::DECIMAL(3) as "KANZAN-I", -- 数量／金額／数値
        rtrim("KANZAN-D", ' 　')::VARCHAR(1) as "KANZAN-D", -- 英数字
        to_decimal(IFF(rtrim("KANZAN-F") = '', 0, rtrim("KANZAN-F")))::DECIMAL(2) as "KANZAN-F", -- 数量／金額／数値
        rtrim(SYAKUKBN, ' 　')::VARCHAR(1) as SYAKUKBN, -- 英数字
        rtrim(HITATUNO, ' 　')::VARCHAR(4) as HITATUNO, -- 英数字
        IFF(rtrim(PKANFLG) = '', '', LPAD(rtrim(PKANFLG), length(PKANFLG), '0'))::VARCHAR(1) as PKANFLG, -- フラグ
        rtrim(SGROUP1, ' 　')::VARCHAR(2) as SGROUP1, -- 英数字
        IFF(rtrim(SGRP2J) = '', '', LPAD(rtrim(SGRP2J), length(SGRP2J), '0'))::VARCHAR(2) as SGRP2J, -- コード／区分
        IFF(rtrim(SGRP21) = '', '', LPAD(rtrim(SGRP21), length(SGRP21), '0'))::VARCHAR(2) as SGRP21, -- コード／区分
        IFF(rtrim(SGRP22) = '', '', LPAD(rtrim(SGRP22), length(SGRP22), '0'))::VARCHAR(2) as SGRP22, -- コード／区分
        IFF(rtrim(SGRP23) = '', '', LPAD(rtrim(SGRP23), length(SGRP23), '0'))::VARCHAR(2) as SGRP23, -- コード／区分
        IFF(rtrim(ZAIKCDJY) = '', '', LPAD(rtrim(ZAIKCDJY), length(ZAIKCDJY), '0'))::VARCHAR(1) as ZAIKCDJY, -- コード／区分
        IFF(rtrim(ZAIKCDJI) = '', '', LPAD(rtrim(ZAIKCDJI), length(ZAIKCDJI), '0'))::VARCHAR(1) as ZAIKCDJI, -- コード／区分
        IFF(rtrim(ZAIKCD1) = '', '', LPAD(rtrim(ZAIKCD1), length(ZAIKCD1), '0'))::VARCHAR(1) as ZAIKCD1, -- コード／区分
        IFF(rtrim(ZAIKCD2) = '', '', LPAD(rtrim(ZAIKCD2), length(ZAIKCD2), '0'))::VARCHAR(1) as ZAIKCD2, -- コード／区分
        IFF(rtrim(ZAIKCD3) = '', '', LPAD(rtrim(ZAIKCD3), length(ZAIKCD3), '0'))::VARCHAR(1) as ZAIKCD3, -- コード／区分
        rtrim(LOCGJ, ' 　')::VARCHAR(1) as LOCGJ, -- 英数字
        rtrim(LOCG1, ' 　')::VARCHAR(1) as LOCG1, -- 英数字
        rtrim(LOCG2, ' 　')::VARCHAR(1) as LOCG2, -- 英数字
        rtrim(LOCG3, ' 　')::VARCHAR(1) as LOCG3, -- 英数字
        IFF(rtrim(KFLGJ) = '', '', LPAD(rtrim(KFLGJ), length(KFLGJ), '0'))::VARCHAR(1) as KFLGJ, -- コード／区分
        IFF(rtrim(KFLG1) = '', '', LPAD(rtrim(KFLG1), length(KFLG1), '0'))::VARCHAR(1) as KFLG1, -- コード／区分
        IFF(rtrim(KFLG2) = '', '', LPAD(rtrim(KFLG2), length(KFLG2), '0'))::VARCHAR(1) as KFLG2, -- コード／区分
        IFF(rtrim(KFLG3) = '', '', LPAD(rtrim(KFLG3), length(KFLG3), '0'))::VARCHAR(1) as KFLG3, -- コード／区分
        rtrim(ODRKBN, ' 　')::VARCHAR(1) as ODRKBN, -- 英数字
        rtrim(JCHUKBN, ' 　')::VARCHAR(1) as JCHUKBN, -- 英数字
        rtrim(NOUHKBN, ' 　')::VARCHAR(1) as NOUHKBN, -- 英数字
        rtrim(FLOHH, ' 　')::VARCHAR(1) as FLOHH, -- 英数字
        rtrim(RIYUU, ' 　')::VARCHAR(2) as RIYUU, -- 英数字
        rtrim(SRIYUU1, ' 　')::VARCHAR(1) as SRIYUU1, -- 英数字
        IFF(rtrim(SRIYUU2) = '', '', LPAD(rtrim(SRIYUU2), length(SRIYUU2), '0'))::VARCHAR(2) as SRIYUU2, -- コード／区分
        rtrim(FLCD, ' 　')::VARCHAR(1) as FLCD, -- 英数字
        rtrim(JTANTOU, ' 　')::VARCHAR(5) as JTANTOU, -- 英数字
        rtrim(UTANTOU, ' 　')::VARCHAR(2) as UTANTOU, -- 英数字
        rtrim(CHOKSO, ' 　')::VARCHAR(1) as CHOKSO, -- 英数字
        IFF(rtrim(MAKERCD) = '', '', LPAD(rtrim(MAKERCD), length(MAKERCD), '0'))::VARCHAR(5) as MAKERCD, -- コード／区分
        IFF(rtrim(DOLD) = '', '', LPAD(rtrim(DOLD), length(DOLD), '0'))::VARCHAR(1) as DOLD, -- コード／区分
        IFF(rtrim(GOGUCHI) = '', '', LPAD(rtrim(GOGUCHI), length(GOGUCHI), '0'))::VARCHAR(1) as GOGUCHI, -- コード／区分
        rtrim(REMARK1, ' 　')::VARCHAR(10) as REMARK1, -- 英数字
        rtrim(SYUKAKBN, ' 　')::VARCHAR(1) as SYUKAKBN, -- 英数字
        rtrim(HIKIFLG, ' 　')::VARCHAR(1) as HIKIFLG, -- 英数字
        rtrim(REMARK2, ' 　')::VARCHAR(10) as REMARK2, -- 英数字
        rtrim(TRNCD, ' 　')::VARCHAR(3) as TRNCD, -- 英数字
        rtrim(TANMATSU, ' 　')::VARCHAR(3) as TANMATSU, -- 英数字
        rtrim(AKADEN, ' 　')::VARCHAR(1) as AKADEN, -- 英数字
        rtrim(HENCD, ' 　')::VARCHAR(1) as HENCD, -- 英数字
        IFF(rtrim(BUSER) = '', '', LPAD(rtrim(BUSER), length(BUSER), '0'))::VARCHAR(5) as BUSER, -- コード／区分
        rtrim(BUSERK, ' 　')::VARCHAR(1) as BUSERK, -- 英数字
        to_decimal(IFF(rtrim("SZEI-I") = '', 0, rtrim("SZEI-I")))::DECIMAL(2) as "SZEI-I", -- 数量／金額／数値
        rtrim("SZEI-D", ' 　')::VARCHAR(1) as "SZEI-D", -- 英数字
        to_decimal(IFF(rtrim("SZEI-F") = '', 0, rtrim("SZEI-F")))::DECIMAL(1) as "SZEI-F", -- 数量／金額／数値
        IFF(rtrim(TENCD) = '', '', LPAD(rtrim(TENCD), length(TENCD), '0'))::VARCHAR(1) as TENCD, -- コード／区分
        IFF(rtrim(JYUJGFLG) = '', '', LPAD(rtrim(JYUJGFLG), length(JYUJGFLG), '0'))::VARCHAR(1) as JYUJGFLG, -- フラグ
        IFF(rtrim(KSKBN) = '', '', LPAD(rtrim(KSKBN), length(KSKBN), '0'))::VARCHAR(1) as KSKBN, -- コード／区分
        IFF(rtrim(ZFFLG) = '', '', LPAD(rtrim(ZFFLG), length(ZFFLG), '0'))::VARCHAR(1) as ZFFLG, -- フラグ
        rtrim(YSYAMEI, ' 　')::VARCHAR(4) as YSYAMEI, -- 英数字
        '  '::VARCHAR(2) as SDAYNUM, -- 日付
        '  '::VARCHAR(2) as JDAYNUM, -- 日付
        rtrim(SENYOFLG, ' 　')::VARCHAR(2) as SENYOFLG, -- 英数字
        rtrim(TOKUSEICD, ' 　')::VARCHAR(2) as TOKUSEICD, -- 英数字
        rtrim(DOKUKAFLG, ' 　')::VARCHAR(1) as DOKUKAFLG, -- 英数字
        rtrim(KAKAKUSKB, ' 　')::VARCHAR(1) as KAKAKUSKB, -- 英数字
        LDTS -- B層のLDTS
    from {{ ref('substr_tbnsyus') }}
)
select * from stg_tbnsyus

{% if is_incremental() %}
    where LDTS > (select max(LDTS) from {{this}})
{% endif %}
