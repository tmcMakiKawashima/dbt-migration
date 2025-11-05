with substr_jf04455d as (
    select
        substr(raw_data, 1, 4)::varchar(4) as ckaishacd,
        substr(raw_data, 5, 7)::varchar(7) as cuserid,
        substr(raw_data, 12, 14)::varchar(14) as cdatetime,
        substr(raw_data, 26, 1)::varchar(1) as cinoutflg,
        substr(raw_data, 27, 6)::varchar(6) as ctanmatsucd,
        ldts
    from {{source('snowpipe_db_administration', 'raw_jf04455d')}}
)

select * from substr_jf04455d