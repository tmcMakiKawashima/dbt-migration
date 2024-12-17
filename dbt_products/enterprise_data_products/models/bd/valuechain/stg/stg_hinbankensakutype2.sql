with stg_hinbankensakutype2 as (
    select
        mntkbn::varchar(1) as mntkbn, 
        langkbn::varchar(3) as langkbn, 
        ctlgcd::varchar(6) as ctlgcd, 
        hinmeicd::varchar(6) as hinmeicd, 
        syasyu_cd::varchar(4) as syasyu_cd, 
        hinban::varchar(12) as hinban, 
        kosu::varchar(2) as kosu, 
        jissijikik::varchar(6) as jissijikik, 
        jissijikim::varchar(6) as jissijikim, 
        siyoptno::varchar(4) as siyoptno, 
        epckataptno::varchar(6) as epckataptno, 
        kiricdk::varchar(4) as kiricdk, 
        kiricdm::varchar(4) as kiricdm, 
        trmcdmlt::varchar(64) as trmcdmlt, 
        clrcdmlt::varchar(75) as clrcdmlt, 
        tkstkbn::varchar(1) as tkstkbn, 
        hktkgaikbn::varchar(1) as hktkgaikbn, 
        hosemhin::varchar(12) as hosemhin, 
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