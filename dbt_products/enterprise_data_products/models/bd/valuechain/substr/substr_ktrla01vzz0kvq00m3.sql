with substr_ktrla01vzz0kvq00m3 as (
    select
        substr(raw_data, 1, 20)::varchar(20) as hinban,
        substr(raw_data, 21, 5)::varchar(5) as dist,
        substr(raw_data, 26, 2)::varchar(2) as fdcd,
        substr(raw_data, 28, 8)::varchar(8) as tekiyokaisiymd,
        substr(raw_data, 36, 8)::varchar(8) as tekiyosyuryoymd,
        substr(raw_data, 44, 11)::varchar(11) as tokafob,
        substr(raw_data, 55, 2)::varchar(2) as tokkasyurui,
        substr(raw_data, 57, 5)::varchar(5) as busyocd,
        substr(raw_data, 62, 10)::varchar(10) as juchucnt,
        substr(raw_data, 72, 1)::varchar(1) as sakuseikbn,
        substr(raw_data, 73, 20)::varchar(20) as kgispfobcom,
        substr(raw_data, 93, 8)::varchar(8) as torokuymd,
        substr(raw_data, 101, 16)::varchar(16) as mtuserid,
        substr(raw_data, 117, 26)::varchar(26) as mttime,
        substr(raw_data, 143, 8)::varchar(8) as filler,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvq00m3')}}
)
select * from substr_ktrla01vzz0kvq00m3