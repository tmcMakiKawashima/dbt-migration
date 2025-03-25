{{
    config (
        post_hook=
            'create or replace hybrid table valuechain_db.public.stg_hinbankensakutype1 (
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
                 siyocdmlt varchar(800),
                 katanomlt varchar(1920),
                 ldts timestamp_ntz(9),
                 constraint stg_hinbankensakutype1_ctlgcd_hinmeicd_syasyu_cd_hinban_kosu_jissijikik_jissijikim_siyoptno_epckataptno_kiricdk_kiricdm_trmcdmlt_clrcdmlt_tkstkbn_hktkgaikbn_hosemhin_uk primary key (ctlgcd, hinmeicd, syasyu_cd, hinban, kosu, jissijikik, jissijikim, siyoptno, epckataptno, kiricdk, kiricdm, trmcdmlt, clrcdmlt, tkstkbn, hktkgaikbn, hosemhin) rely 
             ) as select * from  {{this}}'
    )
}}

with stg_hinbankensakutype1 as (
    select
        mntkbn::varchar(1) as mntkbn, 
        rtrim(ctlgcd, ' 　')::varchar(6) as ctlgcd, 
        rtrim(hinmeicd, ' 　')::varchar(6) as hinmeicd, 
        rtrim(syasyu_cd, ' 　')::varchar(4) as syasyu_cd, 
        rtrim(hinban, ' 　')::varchar(12) as hinban, 
        rtrim(kosu, ' 　')::varchar(2) as kosu, 
        rtrim(jissijikik, ' 　')::varchar(6) as jissijikik, 
        rtrim(jissijikim, ' 　')::varchar(6) as jissijikim, 
        rtrim(siyoptno, ' 　')::varchar(4) as siyoptno, 
        rtrim(epckataptno, ' 　')::varchar(6) as epckataptno, 
        rtrim(kiricdk, ' 　')::varchar(4) as kiricdk, 
        rtrim(kiricdm, ' 　')::varchar(4) as kiricdm, 
        rtrim(trmcdmlt, ' 　')::varchar(64) as trmcdmlt, 
        rtrim(clrcdmlt, ' 　')::varchar(75) as clrcdmlt, 
        rtrim(tkstkbn, ' 　')::varchar(1) as tkstkbn, 
        rtrim(hktkgaikbn, ' 　')::varchar(1) as hktkgaikbn, 
        rtrim(hosemhin, ' 　')::varchar(12) as hosemhin, 
        siyocdmlt::varchar(800) as siyocdmlt, 
        katanomlt::varchar(1920) as katanomlt, 
        ldts, -- b層のldts
        rank() over (
                partition by
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
                order by ldts desc
            ) aggkey
        from {{ref('substr_dv2a381b')}})
select * exclude(aggkey, mntkbn) from stg_hinbankensakutype1 where aggkey = 1 and mntkbn in ('C', 'U')