with stg_hinbankensakutype1 as (
    select
        mntkbn::varchar(1) as mntkbn, 
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