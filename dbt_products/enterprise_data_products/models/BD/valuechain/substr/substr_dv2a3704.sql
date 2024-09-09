with substr_dv2a3704 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 6)::varchar(6) as ctlgcd,
        substr(raw_data, 8, 4)::varchar(4) as kiricd,
        substr(raw_data, 12, 3)::varchar(3) as prtren,
        substr(raw_data, 15, 1)::varchar(1) as datakbn,
        substr(raw_data, 16, 20)::varchar(20) as frmnok,
        substr(raw_data, 36, 20)::varchar(20) as frmnom,
        substr(raw_data, 56, 20)::varchar(20) as pltno,
        ldts
    from {{source('snowpipe_db_valuechain', 'raw_dv2a3704')}}
)
select * from substr_dv2a3704