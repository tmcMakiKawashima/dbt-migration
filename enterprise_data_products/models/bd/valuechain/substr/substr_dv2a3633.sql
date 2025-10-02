with substr_dv2a3633 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 6)::varchar(6) as ctlgcd,
        substr(raw_data, 8, 6)::varchar(6) as epckataptno,
        substr(raw_data, 14, 3)::varchar(3) as katano,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_dv2a3633')}}
)
select * from substr_dv2a3633