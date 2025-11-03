with substr_dv2a353c as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 6)::varchar(6) as ctlgcd,
        substr(raw_data, 8, 12)::varchar(12) as hinban,
        substr(raw_data, 20, 6)::varchar(6) as pnc,
        substr(raw_data, 26, 4)::varchar(4) as figno,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_dv2a353c')}}
)
select * from substr_dv2a353c