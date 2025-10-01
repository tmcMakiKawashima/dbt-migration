with stg_bunkaizukensaku as (
    select
        mntkbn::varchar(1) as mntkbn,
        rtrim(ctlgcd,' 　')::varchar(6) as ctlgcd, -- 右blank
        rtrim(figno,' 　')::varchar(4) as figno, -- 右blank
        rtrim(bnkren4,' 　')::varchar(4) as bnkren4, -- 右blank
        rtrim(hansno,' 　')::varchar(7) as hansno, -- 右blank
        rtrim(jissijikik,' 　')::varchar(6) as jissijikik, -- 右blank
        rtrim(jissijikim,' 　')::varchar(6) as jissijikim, -- 右blank
        epckataptno::varchar(6) as epckataptno,
        rtrim(ilstcmtno,' 　')::varchar(5) as ilstcmtno, -- 右blank
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