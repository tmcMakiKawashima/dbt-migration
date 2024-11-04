with stg_bunkaizukensaku as (
    select
        mntkbn::varchar(1) as mntkbn,
        ctlgcd::varchar(6) as ctlgcd,
        figno::varchar(4) as figno,
        bnkren4::varchar(4) as bnkren4,
        rtrim(hansno,' 　')::varchar(7) as hansno, -- 右blank
        jissijikik::varchar(6) as jissijikik,
        jissijikim::varchar(6) as jissijikim,
        epckataptno::varchar(6) as epckataptno,
        ilstcmtno::varchar(5) as ilstcmtno,
        katahgnjiki::varchar(148) as katahgnjiki,
        ilstqty::varchar(8) as ilstqty,
        ldts, -- b層のldts
        line_number,
        rank() over (
                partition by
                    ctlgcd,
                    figno,
                    bnkren4,
                    jissijikik,
                    jissijikim
                order by ldts desc, line_number desc
            ) aggkey
        from {{ref('substr_dv2a3628')}})
select * exclude(aggkey, line_number, mntkbn) from stg_bunkaizukensaku where aggkey = 1 and mntkbn in ('C', 'U')