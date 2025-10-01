with substr_k9jfv220 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 6)::varchar(6) as ctlgcd,
        substr(raw_data, 8, 4)::varchar(4) as chubnrcd,
        substr(raw_data, 12, 4)::varchar(4) as svglayermei,
        substr(raw_data, 16, 4)::varchar(4) as figno,
        substr(raw_data, 20, 7)::varchar(7) as hansno,
        substr(raw_data, 27, 20)::varchar(20) as emkjimgflmei,
        substr(raw_data, 47, 1)::varchar(1) as fignotaiouflg,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_k9jfv220')}}
)

select * from substr_k9jfv220