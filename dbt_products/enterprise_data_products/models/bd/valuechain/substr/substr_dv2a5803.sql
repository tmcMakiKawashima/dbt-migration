with substr_dv2a5803 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 3)::varchar(3) as langkbn,
        substr(raw_data, 5, 5)::varchar(5) as ilstcmtno,
        substr(raw_data, 10, 140)::varchar(140) as ilstcmt,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_dv2a5803')}}
)
select * from substr_dv2a5803