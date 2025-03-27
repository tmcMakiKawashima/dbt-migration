with substr_dv2a5544 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 7)::varchar(7) as hansno,
        substr(raw_data, 9, 8)::varchar(8) as bnkimgflmei,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_dv2a5544')}}
)
select * from substr_dv2a5544