with stg_hinbankensakutype2 as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(langkbn, ' 　')::varchar(3) as langkbn, -- 右blank
        rtrim(ctlgcd, ' 　')::varchar(6) as ctlgcd, -- 右blank
        rtrim(hinmeicd, ' 　')::varchar(6) as hinmeicd, -- 右blank
        rtrim(syasyu_cd, ' 　')::varchar(4) as syasyu_cd, -- 右blank
        rtrim(hinban, ' 　')::varchar(12) as hinban, -- 右blank
        rtrim(kosu, ' 　')::varchar(2) as kosu, -- 右blank
        rtrim(jissijikik, ' 　')::varchar(6) as jissijikik, -- 右blank
        rtrim(jissijikim, ' 　')::varchar(6) as jissijikim, -- 右blank
        rtrim(siyoptno, ' 　')::varchar(4) as siyoptno, -- 右blank
        rtrim(epckataptno, ' 　')::varchar(6) as epckataptno, -- 右blank
        rtrim(kiricdk, ' 　')::varchar(4) as kiricdk, -- 右blank
        rtrim(kiricdm, ' 　')::varchar(4) as kiricdm, -- 右blank
        rtrim(trmcdmlt, ' 　')::varchar(64) as trmcdmlt, -- 右blank
        rtrim(clrcdmlt, ' 　')::varchar(75) as clrcdmlt, -- 右blank
        rtrim(tkstkbn, ' 　')::varchar(1) as tkstkbn, -- 右blank
        rtrim(hktkgaikbn, ' 　')::varchar(1) as hktkgaikbn, -- 右blank
        rtrim(hosemhin, ' 　')::varchar(12) as hosemhin, -- 右blank
        srcflg::varchar(1) as srcflg, 
        tkkatahgn::varchar(2048) as tkkatahgn, 
        biko::varchar(8192) as biko, 
        ldts, --B層取込日時
        line_number,
        rank() over (
            partition by
                langkbn,
                ctlgcd,
                hinmeicd,
                syasyu_cd,
                hinban,
                kosu,
                jissijikik,
                jissijikim,
                siyoptno,
                epckataptno,
                kiricdk,
                kiricdm,
                trmcdmlt,
                clrcdmlt,
                tkstkbn,
                hktkgaikbn,
                hosemhin
            order by ldts desc, line_number desc
        ) aggkey
    from {{ ref('substr_cv201khintype2') }}
)
select * exclude(mntkbn, line_number, aggkey)
from stg_hinbankensakutype2
where aggkey = 1 and mntkbn in ('C', 'U')