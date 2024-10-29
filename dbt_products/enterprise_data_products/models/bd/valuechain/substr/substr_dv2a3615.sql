with substr_dv2a3615 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 6)::varchar(6) as ctlgcd,
        substr(raw_data, 8, 1)::varchar(1) as emkjgrpcd,
        substr(raw_data, 9, 4)::varchar(4) as figno,
        substr(raw_data, 13, 7)::varchar(7) as hansno,
        substr(raw_data, 20, 20)::varchar(20) as emkjimgflmei,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_dv2a3615')}}
)
select * from substr_dv2a3615