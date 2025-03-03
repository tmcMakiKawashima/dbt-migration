with substr_dv2a4723 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 3)::varchar(3) as langkbn,
        substr(raw_data, 5, 4)::varchar(4) as figno,
        substr(raw_data, 9, 240)::varchar(240) as figmei,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_dv2a4723')}}
)
select * from substr_dv2a4723