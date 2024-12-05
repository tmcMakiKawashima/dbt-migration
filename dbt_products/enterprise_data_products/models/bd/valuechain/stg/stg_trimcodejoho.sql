with stg_trimcodejoho as (
    select
        mntkbn::varchar(1) as mntkbn, 
        ctlgcd::varchar(6) as ctlgcd, 
        syasyu_cd::varchar(4) as syasyu_cd, 
        hinban::varchar(12) as hinban, 
        trmcd::varchar(2) as trmcd, 
        figno::varchar(4) as figno, 
        ldts, -- b層のldts
        rank() over (
                partition by
                    ctlgcd,
                    syasyu_cd,
                    hinban,
                    trmcd,
                    figno
                order by ldts desc
            ) aggkey
        from {{ref('substr_dv2a38b4')}})
select * exclude(aggkey, mntkbn) from stg_trimcodejoho where aggkey = 1 and mntkbn in ('C', 'U')