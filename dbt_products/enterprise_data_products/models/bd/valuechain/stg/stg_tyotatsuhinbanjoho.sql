with stg_tyotatsuhinbanjoho as (
    select
        mntkbn::varchar(1) as mntkbn,
        hinban::varchar(12) as hinban,
        dntikicd::varchar(3) as dntikicd,
        cthin::varchar(12) as cthin,
        tktermk::varchar(8) as tktermk,
        tktermm::varchar(8) as tktermm,
        ldts, -- b層のldts
        rank() over (
                partition by
                    hinban,
                    dntikicd,
                    cthin
                order by ldts desc
            ) aggkey
        from {{ref('substr_dv2a4983')}})
select * exclude(aggkey, mntkbn) from stg_tyotatsuhinbanjoho where aggkey = 1 and mntkbn in ('C', 'U')