{{
    config (
        post_hook=
            'create or replace hybrid table valuechain_db.public.stg_hinbankensakutype2_ctas_ht_tbl_test (
                langkbn varchar(3) not null,
                ctlgcd varchar(6) not null,
                hinmeicd varchar(6) not null,
                syasyu_cd varchar(4) not null,
                hinban varchar(12) not null,
                kosu varchar(2) not null,
                jissijikik varchar(6) not null,
                jissijikim varchar(6) not null,
                siyoptno varchar(4) not null,
                epckataptno varchar(6) not null,
                kiricdk varchar(4) not null,
                kiricdm varchar(4) not null,
                trmcdmlt varchar(64) not null,
                clrcdmlt varchar(75) not null,
                tkstkbn varchar(1) not null,
                hktkgaikbn varchar(1) not null,
                hosemhin varchar(12) not null,
                srcflg varchar(1),
                tkkatahgn varchar(2048),
                biko varchar(8192),
                ldts timestamp_ntz(9),
                constraint stg_hinbankensakutype2_ctas_ht_tbl_test_langkbn_ctlgcd_hinmeicd_syasyu_cd_hinban_kosu_jissijikik_jissijikim_siyoptno_epckataptno_kiricdk_kiricdm_trmcdmlt_clrcdmlt_tkstkbn_hktkgaikbn_hosemhin_uk primary key (langkbn, ctlgcd, hinmeicd, syasyu_cd, hinban, kosu, jissijikik, jissijikim, siyoptno, epckataptno, kiricdk, kiricdm, trmcdmlt, clrcdmlt, tkstkbn, hktkgaikbn, hosemhin) rely 
            ) as select * from {{this}}'
    )
}}

with stg_hinbankensakutype2_ctas_ht_tbl_test as (
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
    from {{ ref('substr_cv201khintype2_ctas_ht_tbl_test') }}
)
select * exclude(mntkbn, line_number, aggkey)
from stg_hinbankensakutype2_ctas_ht_tbl_test
where aggkey = 1 and mntkbn in ('C', 'U')