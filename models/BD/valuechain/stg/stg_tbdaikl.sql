{{ config(snowflake_warehouse='DBT_WH') }}

with stg_tbdaikl as (
    select
        rtrim(kyouhan, ' 　')::varchar(5) as kyouhan, -- 英数字
        iff(rtrim(usercd) = '', '', lpad(rtrim(usercd), length(usercd), '0'))::varchar(5) as usercd, -- コード／区分
        rtrim(kaisya, ' 　')::varchar(2) as kaisya, -- 英数字
        rtrim(tchumon, ' 　')::varchar(14) as tchumon, -- 英数字
        rtrim(frmkb, ' 　')::varchar(3) as frmkb, -- 英数字
        rtrim(frmno, ' 　')::varchar(7) as frmno, -- 英数字
        rtrim(hankata, ' 　')::varchar(20) as hankata, -- 英数字
        rtrim(jyotai, ' 　')::varchar(1) as jyotai, -- 英数字
        rtrim(hassin, ' 　')::varchar(5) as hassin, -- 英数字
        rtrim(utanto, ' 　')::varchar(2) as utanto, -- 英数字
        rtrim(senter, ' 　')::varchar(3) as senter, -- 英数字
        rtrim(tenpo, ' 　')::varchar(3) as tenpo, -- 英数字
        rtrim(nohinkb, ' 　')::varchar(1) as nohinkb, -- 英数字
        rtrim(fnohinkb, ' 　')::varchar(1) as fnohinkb, -- 英数字
        rtrim(rimarku1, ' 　')::varchar(8) as rimarku1, -- 英数字
        rtrim(rimarku2, ' 　')::varchar(10) as rimarku2, -- 英数字
        rtrim(kyoten, ' 　')::varchar(2) as kyoten, -- 英数字
        iff(rtrim(jznjusin) = '', '', lpad(rtrim(jznjusin), length(jznjusin), '0'))::varchar(8) as jznjusin, -- 日付
        iff(rtrim(jznjusit) = '', '', lpad(rtrim(jznjusit), length(jznjusit), '0'))::varchar(4) as jznjusit, -- 時間
        iff(rtrim(finjusin) = '', '', lpad(rtrim(finjusin), length(finjusin), '0'))::varchar(8) as finjusin, -- 日付
        iff(rtrim(finjusit) = '', '', lpad(rtrim(finjusit), length(finjusit), '0'))::varchar(4) as finjusit, -- 時間
        iff(rtrim(jusin) = '', '', lpad(rtrim(jusin), length(jusin), '0'))::varchar(8) as jusin, -- 日付
        iff(rtrim(jusint) = '', '', lpad(rtrim(jusint), length(jusint), '0'))::varchar(4) as jusint, -- 時間
        iff(rtrim(ttyote) = '', '', lpad(rtrim(ttyote), length(ttyote), '0'))::varchar(8) as ttyote, -- 日付
        iff(rtrim(zaiyote) = '', '', lpad(rtrim(zaiyote), length(zaiyote), '0'))::varchar(8) as zaiyote, -- 日付
        iff(rtrim(kinyote) = '', '', lpad(rtrim(kinyote), length(kinyote), '0'))::varchar(8) as kinyote, -- 日付
        iff(rtrim(zaikyote) = '', '', lpad(rtrim(zaikyote), length(zaikyote), '0'))::varchar(8) as zaikyote, -- 日付
        iff(rtrim(canyote) = '', '', lpad(rtrim(canyote), length(canyote), '0'))::varchar(8) as canyote, -- 日付
        iff(rtrim(maetyako) = '', '', lpad(rtrim(maetyako), length(maetyako), '0'))::varchar(8) as maetyako, -- 日付
        iff(rtrim(maezaiho) = '', '', lpad(rtrim(maezaiho), length(maezaiho), '0'))::varchar(8) as maezaiho, -- 日付
        iff(rtrim(maeknkyu) = '', '', lpad(rtrim(maeknkyu), length(maeknkyu), '0'))::varchar(8) as maeknkyu, -- 日付
        iff(rtrim(maezaiko) = '', '', lpad(rtrim(maezaiko), length(maezaiko), '0'))::varchar(8) as maezaiko, -- 日付
        iff(rtrim(maecan) = '', '', lpad(rtrim(maecan), length(maecan), '0'))::varchar(8) as maecan, -- 日付
        iff(rtrim(tyakko) = '', '', lpad(rtrim(tyakko), length(tyakko), '0'))::varchar(8) as tyakko, -- 日付
        iff(rtrim(tosait) = '', '', lpad(rtrim(tosait), length(tosait), '0'))::varchar(4) as tosait, -- 時間
        rtrim(tosaij, ' 　')::varchar(4) as tosaij, -- 英数字
        iff(rtrim(toritukt) = '', '', lpad(rtrim(toritukt), length(toritukt), '0'))::varchar(4) as toritukt, -- 時間
        rtrim(toritukj, ' 　')::varchar(4) as toritukj, -- 英数字
        iff(rtrim(kansei) = '', '', lpad(rtrim(kansei), length(kansei), '0'))::varchar(8) as kansei, -- 日付
        iff(rtrim(kanseit) = '', '', lpad(rtrim(kanseit), length(kanseit), '0'))::varchar(4) as kanseit, -- 時間
        rtrim(kanseij, ' 　')::varchar(4) as kanseij, -- 英数字
        rtrim(zaihikif, ' 　')::varchar(1) as zaihikif, -- 英数字
        iff(rtrim(zenhikdd) = '', '', lpad(rtrim(zenhikdd), length(zenhikdd), '0'))::varchar(8) as zenhikdd, -- 日付
        iff(rtrim(zaihatyu) = '', '', lpad(rtrim(zaihatyu), length(zaihatyu), '0'))::varchar(8) as zaihatyu, -- 日付
        iff(rtrim(kinhatyu) = '', '', lpad(rtrim(kinhatyu), length(kinhatyu), '0'))::varchar(8) as kinhatyu, -- 日付
        iff(rtrim(cancel) = '', '', lpad(rtrim(cancel), length(cancel), '0'))::varchar(8) as cancel, -- 日付
        iff(rtrim(syukten) = '', '', lpad(rtrim(syukten), length(syukten), '0'))::varchar(2) as syukten, -- コード／区分
        ldts, -- B層のLDTS
        rank() over (partition by kyouhan, hassin, usercd, kaisya, tchumon, jznjusin order by ldts desc) aggkey
    from {{ ref('substr_tbdaikl') }}
)
select * from stg_tbdaikl
where aggkey = 1
