with substr_ktrla01vzz0kvs00m4 as (
    select
        substr(raw_data, 1, 20)::varchar(20) as shinban,
        substr(raw_data, 21, 1)::varchar(1) as gnsnktrkkanryst,
        substr(raw_data, 22, 1)::varchar(1) as gaikoksngaihkbn,
        substr(raw_data, 23, 40)::varchar(40) as seisnkaisyamei,
        substr(raw_data, 63, 20)::varchar(20) as gensnkmei,
        substr(raw_data, 83, 8)::varchar(8) as tekiyokaisiymd,
        substr(raw_data, 91, 8)::varchar(8) as tekiyosyuryoymd,
        substr(raw_data, 99, 16)::varchar(16) as mtuserid,
        substr(raw_data, 115, 26)::varchar(26) as mttime,
        substr(raw_data, 141, 10)::varchar(10) as filler,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvs00m4')}}
)
select * from substr_ktrla01vzz0kvs00m4