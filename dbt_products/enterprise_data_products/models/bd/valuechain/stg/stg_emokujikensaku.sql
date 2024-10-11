with stg_emokujikensaku as (
    select
        mntkbn::varchar(1) as mntkbn,
        ctlgcd::varchar(6) as ctlgcd,
        emkjgrpcd::varchar(1) as emkjgrpcd,
        figno::varchar(4) as figno,
        rtrim(hansno,' 　')::varchar(7) as hansno, -- 右blank
        emkjimgflmei::varchar(20) as emkjimgflmei,
        ldts, -- b層のldts
        line_number,
        rank() over (
                partition by
                    ctlgcd,
                    emkjgrpcd,
                    figno
                order by ldts desc, line_number desc
            ) aggkey
        from {{ref('substr_dv2a3615')}})
select * exclude(aggkey, line_number, mntkbn) from stg_emokujikensaku where aggkey = 1 and mntkbn in ('C', 'U')