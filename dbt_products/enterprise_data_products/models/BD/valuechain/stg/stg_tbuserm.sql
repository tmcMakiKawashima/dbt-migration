{{ config(snowflake_warehouse='DBT_WH') }}

with stg_tbuserm as (
    select
        rtrim(KYOUHAN,' 　')::VARCHAR(5) as KYOUHAN,  -- 英数字
        IFF(rtrim(USRCOD) = '','',LPAD(rtrim(USRCOD),length(USRCOD),'0'))::VARCHAR(5) as USRCOD,  -- コード/区分
        IFF(rtrim(HANBAITEN) = '','',LPAD(rtrim(HANBAITEN),length(HANBAITEN),'0'))::VARCHAR(5) as HANBAITEN,  -- コード/区分
        IFF(rtrim(TIKU) = '','',LPAD(rtrim(TIKU),length(TIKU),'0'))::VARCHAR(5) as TIKU,  -- コード/区分
        IFF(rtrim(BUROCK) = '','',LPAD(rtrim(BUROCK),length(BUROCK),'0'))::VARCHAR(2) as BUROCK,  -- コード/区分
        IFF(rtrim(KTN) = '','',LPAD(rtrim(KTN),length(KTN),'0'))::VARCHAR(2) as KTN,  -- コード/区分
        IFF(rtrim(KA) = '','',LPAD(rtrim(KA),length(KA),'0'))::VARCHAR(1) as KA,  -- コード/区分
        IFF(rtrim(STF) = '','',LPAD(rtrim(STF),length(STF),'0'))::VARCHAR(2) as STF,  -- コード/区分
        IFF(rtrim(GSY) = '','',LPAD(rtrim(GSY),length(GSY),'0'))::VARCHAR(2) as GSY,  -- コード/区分
        rtrim(UKCOD,' 　')::VARCHAR(1) as UKCOD,  -- 英数字
        IFF(rtrim(TEISI) = '','',LPAD(rtrim(TEISI),length(TEISI),'0'))::VARCHAR(8) as TEISI,  -- 日付
        rtrim(KNTUNM,' 　')::VARCHAR(5) as KNTUNM,  -- 英数字
        rtrim(KNUSRNM,' 　')::VARCHAR(25) as KNUSRNM,  -- 英数字
        rtrim(KJTUNM,' 　')::VARCHAR(8) as KJTUNM,  -- 英数字
        rtrim(KJUSRNM,' 　')::VARCHAR(20) as KJUSRNM,  -- 英数字
        rtrim(TEL,' 　')::VARCHAR(12) as TEL,  -- 英数字
        rtrim(YBNBNG,' 　')::VARCHAR(8) as YBNBNG,  -- 英数字
        rtrim(KNAJUS,' 　')::VARCHAR(35) as KNAJUS,  -- 英数字
        rtrim(KJJUS,' 　')::VARCHAR(25) as KJJUS,  -- 英数字
        IFF(rtrim(KQQSCOD) = '','',LPAD(rtrim(KQQSCOD),length(KQQSCOD),'0'))::VARCHAR(1) as KQQSCOD,  -- コード/区分
        IFF(rtrim(RESCSKD) = '','',LPAD(rtrim(RESCSKD),length(RESCSKD),'0'))::VARCHAR(1) as RESCSKD,  -- コード/区分
        IFF(rtrim(HSRCOD1) = '','',LPAD(rtrim(HSRCOD1),length(HSRCOD1),'0'))::VARCHAR(1) as HSRCOD1,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK1) = '',0,rtrim(SKRRNK1)))::DECIMAL(2) as SKRRNK1,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT1-I") = '',0,rtrim("KKRIT1-I")))::DECIMAL(3) as "KKRIT1-I",  -- 数量／金額／数値
        rtrim("KKRIT1-D",' 　')::VARCHAR(1) as "KKRIT1-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT1-F") = '',0,rtrim("KKRIT1-F")))::DECIMAL(1) as "KKRIT1-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD2) = '','',LPAD(rtrim(HSRCOD2),length(HSRCOD2),'0'))::VARCHAR(1) as HSRCOD2,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK2) = '',0,rtrim(SKRRNK2)))::DECIMAL(2) as SKRRNK2,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT2-I") = '',0,rtrim("KKRIT2-I")))::DECIMAL(3) as "KKRIT2-I",  -- 数量／金額／数値
        rtrim("KKRIT2-D",' 　')::VARCHAR(1) as "KKRIT2-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT2-F") = '',0,rtrim("KKRIT2-F")))::DECIMAL(1) as "KKRIT2-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD3) = '','',LPAD(rtrim(HSRCOD3),length(HSRCOD3),'0'))::VARCHAR(1) as HSRCOD3,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK3) = '',0,rtrim(SKRRNK3)))::DECIMAL(2) as SKRRNK3,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT3-I") = '',0,rtrim("KKRIT3-I")))::DECIMAL(3) as "KKRIT3-I",  -- 数量／金額／数値
        rtrim("KKRIT3-D",' 　')::VARCHAR(1) as "KKRIT3-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT3-F") = '',0,rtrim("KKRIT3-F")))::DECIMAL(1) as "KKRIT3-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD4) = '','',LPAD(rtrim(HSRCOD4),length(HSRCOD4),'0'))::VARCHAR(1) as HSRCOD4,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK4) = '',0,rtrim(SKRRNK4)))::DECIMAL(2) as SKRRNK4,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT4-I") = '',0,rtrim("KKRIT4-I")))::DECIMAL(3) as "KKRIT4-I",  -- 数量／金額／数値
        rtrim("KKRIT4-D",' 　')::VARCHAR(1) as "KKRIT4-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT4-F") = '',0,rtrim("KKRIT4-F")))::DECIMAL(1) as "KKRIT4-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD5) = '','',LPAD(rtrim(HSRCOD5),length(HSRCOD5),'0'))::VARCHAR(1) as HSRCOD5,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK5) = '',0,rtrim(SKRRNK5)))::DECIMAL(2) as SKRRNK5,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT5-I") = '',0,rtrim("KKRIT5-I")))::DECIMAL(3) as "KKRIT5-I",  -- 数量／金額／数値
        rtrim("KKRIT5-D",' 　')::VARCHAR(1) as "KKRIT5-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT5-F") = '',0,rtrim("KKRIT5-F")))::DECIMAL(1) as "KKRIT5-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD6) = '','',LPAD(rtrim(HSRCOD6),length(HSRCOD6),'0'))::VARCHAR(1) as HSRCOD6,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK6) = '',0,rtrim(SKRRNK6)))::DECIMAL(2) as SKRRNK6,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT6-I") = '',0,rtrim("KKRIT6-I")))::DECIMAL(3) as "KKRIT6-I",  -- 数量／金額／数値
        rtrim("KKRIT6-D",' 　')::VARCHAR(1) as "KKRIT6-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT6-F") = '',0,rtrim("KKRIT6-F")))::DECIMAL(1) as "KKRIT6-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD7) = '','',LPAD(rtrim(HSRCOD7),length(HSRCOD7),'0'))::VARCHAR(1) as HSRCOD7,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK7) = '',0,rtrim(SKRRNK7)))::DECIMAL(2) as SKRRNK7,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT7-I") = '',0,rtrim("KKRIT7-I")))::DECIMAL(3) as "KKRIT7-I",  -- 数量／金額／数値
        rtrim("KKRIT7-D",' 　')::VARCHAR(1) as "KKRIT7-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT7-F") = '',0,rtrim("KKRIT7-F")))::DECIMAL(1) as "KKRIT7-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD8) = '','',LPAD(rtrim(HSRCOD8),length(HSRCOD8),'0'))::VARCHAR(1) as HSRCOD8,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK8) = '',0,rtrim(SKRRNK8)))::DECIMAL(2) as SKRRNK8,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT8-I") = '',0,rtrim("KKRIT8-I")))::DECIMAL(3) as "KKRIT8-I",  -- 数量／金額／数値
        rtrim("KKRIT8-D",' 　')::VARCHAR(1) as "KKRIT8-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT8-F") = '',0,rtrim("KKRIT8-F")))::DECIMAL(1) as "KKRIT8-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD9) = '','',LPAD(rtrim(HSRCOD9),length(HSRCOD9),'0'))::VARCHAR(1) as HSRCOD9,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK9) = '',0,rtrim(SKRRNK9)))::DECIMAL(2) as SKRRNK9,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT9-I") = '',0,rtrim("KKRIT9-I")))::DECIMAL(3) as "KKRIT9-I",  -- 数量／金額／数値
        rtrim("KKRIT9-D",' 　')::VARCHAR(1) as "KKRIT9-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT9-F") = '',0,rtrim("KKRIT9-F")))::DECIMAL(1) as "KKRIT9-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD10) = '','',LPAD(rtrim(HSRCOD10),length(HSRCOD10),'0'))::VARCHAR(1) as HSRCOD10,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK10) = '',0,rtrim(SKRRNK10)))::DECIMAL(2) as SKRRNK10,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT10-I") = '',0,rtrim("KKRIT10-I")))::DECIMAL(3) as "KKRIT10-I",  -- 数量／金額／数値
        rtrim("KKRIT10-D",' 　')::VARCHAR(1) as "KKRIT10-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT10-F") = '',0,rtrim("KKRIT10-F")))::DECIMAL(1) as "KKRIT10-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD11) = '','',LPAD(rtrim(HSRCOD11),length(HSRCOD11),'0'))::VARCHAR(1) as HSRCOD11,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK11) = '',0,rtrim(SKRRNK11)))::DECIMAL(2) as SKRRNK11,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT11-I") = '',0,rtrim("KKRIT11-I")))::DECIMAL(3) as "KKRIT11-I",  -- 数量／金額／数値
        rtrim("KKRIT11-D",' 　')::VARCHAR(1) as "KKRIT11-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT11-F") = '',0,rtrim("KKRIT11-F")))::DECIMAL(1) as "KKRIT11-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD12) = '','',LPAD(rtrim(HSRCOD12),length(HSRCOD12),'0'))::VARCHAR(1) as HSRCOD12,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK12) = '',0,rtrim(SKRRNK12)))::DECIMAL(2) as SKRRNK12,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT12-I") = '',0,rtrim("KKRIT12-I")))::DECIMAL(3) as "KKRIT12-I",  -- 数量／金額／数値
        rtrim("KKRIT12-D",' 　')::VARCHAR(1) as "KKRIT12-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT12-F") = '',0,rtrim("KKRIT12-F")))::DECIMAL(1) as "KKRIT12-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD13) = '','',LPAD(rtrim(HSRCOD13),length(HSRCOD13),'0'))::VARCHAR(1) as HSRCOD13,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK13) = '',0,rtrim(SKRRNK13)))::DECIMAL(2) as SKRRNK13,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT13-I") = '',0,rtrim("KKRIT13-I")))::DECIMAL(3) as "KKRIT13-I",  -- 数量／金額／数値
        rtrim("KKRIT13-D",' 　')::VARCHAR(1) as "KKRIT13-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT13-F") = '',0,rtrim("KKRIT13-F")))::DECIMAL(1) as "KKRIT13-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD14) = '','',LPAD(rtrim(HSRCOD14),length(HSRCOD14),'0'))::VARCHAR(1) as HSRCOD14,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK14) = '',0,rtrim(SKRRNK14)))::DECIMAL(2) as SKRRNK14,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT14-I") = '',0,rtrim("KKRIT14-I")))::DECIMAL(3) as "KKRIT14-I",  -- 数量／金額／数値
        rtrim("KKRIT14-D",' 　')::VARCHAR(1) as "KKRIT14-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT14-F") = '',0,rtrim("KKRIT14-F")))::DECIMAL(1) as "KKRIT14-F",  -- 数量／金額／数値
        IFF(rtrim(HSRCOD15) = '','',LPAD(rtrim(HSRCOD15),length(HSRCOD15),'0'))::VARCHAR(1) as HSRCOD15,  -- コード/区分
        to_decimal(IFF(rtrim(SKRRNK15) = '',0,rtrim(SKRRNK15)))::DECIMAL(2) as SKRRNK15,  -- 数量／金額／数値
        to_decimal(IFF(rtrim("KKRIT15-I") = '',0,rtrim("KKRIT15-I")))::DECIMAL(3) as "KKRIT15-I",  -- 数量／金額／数値
        rtrim("KKRIT15-D",' 　')::VARCHAR(1) as "KKRIT15-D",  -- 英数字
        to_decimal(IFF(rtrim("KKRIT15-F") = '',0,rtrim("KKRIT15-F")))::DECIMAL(1) as "KKRIT15-F",  -- 数量／金額／数値
        IFF(rtrim(DAIKOKAIF) = '','',LPAD(rtrim(DAIKOKAIF),length(DAIKOKAIF),'0'))::VARCHAR(2) as DAIKOKAIF,  -- コード/区分
        IFF(rtrim(USRZKKBN) = '','',LPAD(rtrim(USRZKKBN),length(USRZKKBN),'0'))::VARCHAR(1) as USRZKKBN,  -- コード/区分
        IFF(rtrim(KSHGRF) = '','',LPAD(rtrim(KSHGRF),length(KSHGRF),'0'))::VARCHAR(1) as KSHGRF,  -- フラグ
        IFF(rtrim(FAXAUMGF) = '','',LPAD(rtrim(FAXAUMGF),length(FAXAUMGF),'0'))::VARCHAR(1) as FAXAUMGF,  -- フラグ
        rtrim(FAXBNG,' 　')::VARCHAR(12) as FAXBNG,  -- 英数字
        IFF(rtrim(JJGF) = '','',LPAD(rtrim(JJGF),length(JJGF),'0'))::VARCHAR(1) as JJGF,  -- フラグ
        IFF(rtrim(BSTEN) = '','',LPAD(rtrim(BSTEN),length(BSTEN),'0'))::VARCHAR(2) as BSTEN,  -- コード/区分
        IFF(rtrim(BSHA0) = '','',LPAD(rtrim(BSHA0),length(BSHA0),'0'))::VARCHAR(2) as BSHA0,  -- コード/区分
        IFF(rtrim(BSHA1) = '','',LPAD(rtrim(BSHA1),length(BSHA1),'0'))::VARCHAR(2) as BSHA1,  -- コード/区分
        IFF(rtrim(BSHA2) = '','',LPAD(rtrim(BSHA2),length(BSHA2),'0'))::VARCHAR(2) as BSHA2,  -- コード/区分
        IFF(rtrim(BSHA3) = '','',LPAD(rtrim(BSHA3),length(BSHA3),'0'))::VARCHAR(2) as BSHA3,  -- コード/区分
        IFF(rtrim(BSHA4) = '','',LPAD(rtrim(BSHA4),length(BSHA4),'0'))::VARCHAR(2) as BSHA4,  -- コード/区分
        IFF(rtrim(BSHA5) = '','',LPAD(rtrim(BSHA5),length(BSHA5),'0'))::VARCHAR(2) as BSHA5,  -- コード/区分
        IFF(rtrim(BSHA6) = '','',LPAD(rtrim(BSHA6),length(BSHA6),'0'))::VARCHAR(2) as BSHA6,  -- コード/区分
        IFF(rtrim(BSHA7) = '','',LPAD(rtrim(BSHA7),length(BSHA7),'0'))::VARCHAR(2) as BSHA7,  -- コード/区分
        IFF(rtrim(BSHA8) = '','',LPAD(rtrim(BSHA8),length(BSHA8),'0'))::VARCHAR(2) as BSHA8,  -- コード/区分
        IFF(rtrim(BSHA9) = '','',LPAD(rtrim(BSHA9),length(BSHA9),'0'))::VARCHAR(2) as BSHA9,  -- コード/区分
        IFF(rtrim(BSSHA) = '','',LPAD(rtrim(BSSHA),length(BSSHA),'0'))::VARCHAR(2) as BSSHA,  -- コード/区分
        rtrim(BSKYOUHAN,' 　')::VARCHAR(5) as BSKYOUHAN,  -- 英数字
        IFF(rtrim(BSSIIRE) = '','',LPAD(rtrim(BSSIIRE),length(BSSIIRE),'0'))::VARCHAR(5) as BSSIIRE,  -- コード/区分
        IFF(rtrim(BSIUSER) = '','',LPAD(rtrim(BSIUSER),length(BSIUSER),'0'))::VARCHAR(5) as BSIUSER,  -- コード/区分
        rtrim(UOEFCOD,' 　')::VARCHAR(1) as UOEFCOD,  -- 英数字
        rtrim(PSW1,' 　')::VARCHAR(2) as PSW1,  -- 英数字
        rtrim(PSW2,' 　')::VARCHAR(2) as PSW2,  -- 英数字
        rtrim(PSW3,' 　')::VARCHAR(2) as PSW3,  -- 英数字
        rtrim(PSW4,' 　')::VARCHAR(2) as PSW4,  -- 英数字
        rtrim(PSW5,' 　')::VARCHAR(2) as PSW5,  -- 英数字
        IFF(rtrim(DMOFLG) = '','',LPAD(rtrim(DMOFLG),length(DMOFLG),'0'))::VARCHAR(1) as DMOFLG,  -- コード/区分
        IFF(rtrim(HDKBN) = '','',LPAD(rtrim(HDKBN),length(HDKBN),'0'))::VARCHAR(1) as HDKBN,  -- コード/区分
        LDTS -- B層のLDTS
    from {{ ref('substr_tbuserm') }}
)
select * from stg_tbuserm
where LDTS = (select max(LDTS) from stg_tbuserm)