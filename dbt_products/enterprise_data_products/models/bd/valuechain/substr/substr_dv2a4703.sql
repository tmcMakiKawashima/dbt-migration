with substr_dv2a4703 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 3)::varchar(3) as langkbn,
        substr(raw_data, 5, 6)::varchar(6) as pnc,
        substr(raw_data, 11, 240)::varchar(240) as hinmei,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_dv2a4703')}}
)
select * from substr_dv2a4703