{{
    config (
        materialized='view',
        post_hook=
            'create or replace hybrid table valuechain_db.public.stg_hinbankensakutype2_ctas_ht_test (
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
                constraint stg_hinbankensakutype2_ctas_ht_test_langkbn_ctlgcd_hinmeicd_syasyu_cd_hinban_kosu_jissijikik_jissijikim_siyoptno_epckataptno_kiricdk_kiricdm_trmcdmlt_clrcdmlt_tkstkbn_hktkgaikbn_hosemhin_uk primary key (langkbn, ctlgcd, hinmeicd, syasyu_cd, hinban, kosu, jissijikik, jissijikim, siyoptno, epckataptno, kiricdk, kiricdm, trmcdmlt, clrcdmlt, tkstkbn, hktkgaikbn, hosemhin) rely 
            ) as select * from {{this}}'
    )
}}

with tmp_hinbankensakutype2_ctas_ht_test as (
    select
        mntkbn, 
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
        hosemhin, 
        srcflg, 
        tkkatahgn, 
        biko, 
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
    from {{ ref('substr_cv201khintype2_ctas_ht_test') }}
)
select * exclude(mntkbn, line_number, aggkey)
from tmp_hinbankensakutype2_ctas_ht_test
where aggkey = 1 and mntkbn in ('C', 'U')