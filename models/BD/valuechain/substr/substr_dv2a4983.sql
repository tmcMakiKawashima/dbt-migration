with substr_dv2a4983 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 12)::varchar(12) as hinban,
        substr(raw_data, 14, 3)::varchar(3) as dntikicd,
        substr(raw_data, 17, 12)::varchar(12) as cthin,
        substr(raw_data, 29, 8)::varchar(8) as tktermk,
        substr(raw_data, 37, 8)::varchar(8) as tktermm,
        ldts
    from {{source('snowpipe_db_valuechain', 'raw_dv2a4983')}}
)
select * from substr_dv2a4983