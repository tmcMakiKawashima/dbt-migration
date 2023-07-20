{{ config(materialized='table') }}

with stg_tbdaikl as (
    select
        rtrim(KYOUHAN, ' 　')::VARCHAR(5) as KYOUHAN, -- 英数字
        IFF(rtrim(USERCD) = '', '', LPAD(rtrim(USERCD), length(USERCD), '0'))::VARCHAR(5) as USERCD, -- コード／区分
        rtrim(KAISYA, ' 　')::VARCHAR(2) as KAISYA, -- 英数字
        rtrim(TCHUMON, ' 　')::VARCHAR(14) as TCHUMON, -- 英数字
        rtrim(FRMKB, ' 　')::VARCHAR(3) as FRMKB, -- 英数字
        rtrim(FRMNO, ' 　')::VARCHAR(7) as FRMNO, -- 英数字
        rtrim(HANKATA, ' 　')::VARCHAR(20) as HANKATA, -- 英数字
        rtrim(JYOTAI, ' 　')::VARCHAR(1) as JYOTAI, -- 英数字
        rtrim(HASSIN, ' 　')::VARCHAR(5) as HASSIN, -- 英数字
        rtrim(UTANTO, ' 　')::VARCHAR(2) as UTANTO, -- 英数字
        rtrim(SENTER, ' 　')::VARCHAR(3) as SENTER, -- 英数字
        rtrim(TENPO, ' 　')::VARCHAR(3) as TENPO, -- 英数字
        rtrim(NOHINKB, ' 　')::VARCHAR(1) as NOHINKB, -- 英数字
        rtrim(FNOHINKB, ' 　')::VARCHAR(1) as FNOHINKB, -- 英数字
        rtrim(RIMARKU1, ' 　')::VARCHAR(8) as RIMARKU1, -- 英数字
        rtrim(RIMARKU2, ' 　')::VARCHAR(10) as RIMARKU2, -- 英数字
        rtrim(KYOTEN, ' 　')::VARCHAR(2) as KYOTEN, -- 英数字
        IFF(rtrim(JZNJUSIN) = '', '', LPAD(rtrim(JZNJUSIN), length(JZNJUSIN), '0'))::VARCHAR(8) as JZNJUSIN, -- 日付
        IFF(rtrim(JZNJUSIT) = '', '', LPAD(rtrim(JZNJUSIT), length(JZNJUSIT), '0'))::VARCHAR(4) as JZNJUSIT, -- 時間
        IFF(rtrim(FINJUSIN) = '', '', LPAD(rtrim(FINJUSIN), length(FINJUSIN), '0'))::VARCHAR(8) as FINJUSIN, -- 日付
        IFF(rtrim(FINJUSIT) = '', '', LPAD(rtrim(FINJUSIT), length(FINJUSIT), '0'))::VARCHAR(4) as FINJUSIT, -- 時間
        IFF(rtrim(JUSIN) = '', '', LPAD(rtrim(JUSIN), length(JUSIN), '0'))::VARCHAR(8) as JUSIN, -- 日付
        IFF(rtrim(JUSINT) = '', '', LPAD(rtrim(JUSINT), length(JUSINT), '0'))::VARCHAR(4) as JUSINT, -- 時間
        IFF(rtrim(TTYOTE) = '', '', LPAD(rtrim(TTYOTE), length(TTYOTE), '0'))::VARCHAR(8) as TTYOTE, -- 日付
        IFF(rtrim(ZAIYOTE) = '', '', LPAD(rtrim(ZAIYOTE), length(ZAIYOTE), '0'))::VARCHAR(8) as ZAIYOTE, -- 日付
        IFF(rtrim(KINYOTE) = '', '', LPAD(rtrim(KINYOTE), length(KINYOTE), '0'))::VARCHAR(8) as KINYOTE, -- 日付
        IFF(rtrim(ZAIKYOTE) = '', '', LPAD(rtrim(ZAIKYOTE), length(ZAIKYOTE), '0'))::VARCHAR(8) as ZAIKYOTE, -- 日付
        IFF(rtrim(CANYOTE) = '', '', LPAD(rtrim(CANYOTE), length(CANYOTE), '0'))::VARCHAR(8) as CANYOTE, -- 日付
        IFF(rtrim(MAETYAKO) = '', '', LPAD(rtrim(MAETYAKO), length(MAETYAKO), '0'))::VARCHAR(8) as MAETYAKO, -- 日付
        IFF(rtrim(MAEZAIHO) = '', '', LPAD(rtrim(MAEZAIHO), length(MAEZAIHO), '0'))::VARCHAR(8) as MAEZAIHO, -- 日付
        IFF(rtrim(MAEKNKYU) = '', '', LPAD(rtrim(MAEKNKYU), length(MAEKNKYU), '0'))::VARCHAR(8) as MAEKNKYU, -- 日付
        IFF(rtrim(MAEZAIKO) = '', '', LPAD(rtrim(MAEZAIKO), length(MAEZAIKO), '0'))::VARCHAR(8) as MAEZAIKO, -- 日付
        IFF(rtrim(MAECAN) = '', '', LPAD(rtrim(MAECAN), length(MAECAN), '0'))::VARCHAR(8) as MAECAN, -- 日付
        IFF(rtrim(TYAKKO) = '', '', LPAD(rtrim(TYAKKO), length(TYAKKO), '0'))::VARCHAR(8) as TYAKKO, -- 日付
        IFF(rtrim(TOSAIT) = '', '', LPAD(rtrim(TOSAIT), length(TOSAIT), '0'))::VARCHAR(4) as TOSAIT, -- 時間
        rtrim(TOSAIJ, ' 　')::VARCHAR(4) as TOSAIJ, -- 英数字
        IFF(rtrim(TORITUKT) = '', '', LPAD(rtrim(TORITUKT), length(TORITUKT), '0'))::VARCHAR(4) as TORITUKT, -- 時間
        rtrim(TORITUKJ, ' 　')::VARCHAR(4) as TORITUKJ, -- 英数字
        IFF(rtrim(KANSEI) = '', '', LPAD(rtrim(KANSEI), length(KANSEI), '0'))::VARCHAR(8) as KANSEI, -- 日付
        IFF(rtrim(KANSEIT) = '', '', LPAD(rtrim(KANSEIT), length(KANSEIT), '0'))::VARCHAR(4) as KANSEIT, -- 時間
        rtrim(KANSEIJ, ' 　')::VARCHAR(4) as KANSEIJ, -- 英数字
        rtrim(ZAIHIKIF, ' 　')::VARCHAR(1) as ZAIHIKIF, -- 英数字
        IFF(rtrim(ZENHIKDD) = '', '', LPAD(rtrim(ZENHIKDD), length(ZENHIKDD), '0'))::VARCHAR(8) as ZENHIKDD, -- 日付
        IFF(rtrim(ZAIHATYU) = '', '', LPAD(rtrim(ZAIHATYU), length(ZAIHATYU), '0'))::VARCHAR(8) as ZAIHATYU, -- 日付
        IFF(rtrim(KINHATYU) = '', '', LPAD(rtrim(KINHATYU), length(KINHATYU), '0'))::VARCHAR(8) as KINHATYU, -- 日付
        IFF(rtrim(CANCEL) = '', '', LPAD(rtrim(CANCEL), length(CANCEL), '0'))::VARCHAR(8) as CANCEL, -- 日付
        IFF(rtrim(SYUKTEN) = '', '', LPAD(rtrim(SYUKTEN), length(SYUKTEN), '0'))::VARCHAR(2) as SYUKTEN, -- コード／区分
        LDTS, -- B層のLDTS
        RANK() over (partition by KYOUHAN, HASSIN, USERCD, KAISYA, TCHUMON, JZNJUSIN order by LDTS desc) aggkey
    from {{ ref('substr_tbdaikl') }}
)
select * from stg_tbdaikl
where aggkey = 1
