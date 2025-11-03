with substr_ktrla01vzz0kvs00m0 as (
    select
        substr(raw_data, 1, 20)::varchar(20) as shinban,
        substr(raw_data, 21, 1)::varchar(1) as hanbaikbn,
        substr(raw_data, 22, 1)::varchar(1) as syukancd,
        substr(raw_data, 23, 3)::varchar(3) as tokeibricd,
        substr(raw_data, 26, 1)::varchar(1) as jukenkbn,
        substr(raw_data, 27, 1)::varchar(1) as raisenscd,
        substr(raw_data, 28, 1)::varchar(1) as menzeikbn,
        substr(raw_data, 29, 40)::varchar(40) as zaisitcd,
        substr(raw_data, 69, 8)::varchar(8) as tekiyokaisiymd,
        substr(raw_data, 77, 8)::varchar(8) as tekiyosyuryoymd,
        substr(raw_data, 85, 16)::varchar(16) as mtuserid,
        substr(raw_data, 101, 26)::varchar(26) as mttime,
        substr(raw_data, 127, 4)::varchar(4) as filler,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvs00m0')}}
)
select * from substr_ktrla01vzz0kvs00m0