with substr_dv2a3628 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 6)::varchar(6) as ctlgcd,
        substr(raw_data, 8, 4)::varchar(4) as figno,
        substr(raw_data, 12, 4)::varchar(4) as bnkren4,
        substr(raw_data, 16, 7)::varchar(7) as hansno,
        substr(raw_data, 23, 6)::varchar(6) as jissijikik,
        substr(raw_data, 29, 6)::varchar(6) as jissijikim,
        substr(raw_data, 35, 6)::varchar(6) as epckataptno,
        substr(raw_data, 41, 5)::varchar(5) as ilstcmtno,
        substr(raw_data, 46, 148)::varchar(148) as katahgnjiki,
        substr(raw_data, 194, 8)::varchar(8) as ilstqty,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_dv2a3628')}}
)
select * from substr_dv2a3628