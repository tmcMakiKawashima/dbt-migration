with substr_dv2a4763 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 12)::varchar(12) as hinban,
        substr(raw_data, 14, 5)::varchar(5) as hnbtikicd,
        substr(raw_data, 19, 12)::varchar(12) as dthin,
        substr(raw_data, 31, 2)::varchar(2) as dtkosu,
        substr(raw_data, 33, 8)::varchar(8) as dthintkdate,
        substr(raw_data, 41, 2)::varchar(2) as dttype,
        substr(raw_data, 43, 1)::varchar(1) as mainflg,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_dv2a4763')}}
)
select * from substr_dv2a4763