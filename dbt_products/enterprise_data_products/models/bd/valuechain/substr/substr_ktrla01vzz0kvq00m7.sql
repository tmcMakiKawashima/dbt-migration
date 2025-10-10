with substr_ktrla01vzz0kvq00m7 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as tukacd,
        substr(raw_data, 2, 7)::varchar(7) as kawaseraten,
        substr(raw_data, 9, 7)::varchar(7) as kawaserateo,
        substr(raw_data, 16, 8)::varchar(8) as kwsratekrkeymd,
        substr(raw_data, 24, 10)::varchar(10) as tukacdmei,
        substr(raw_data, 34, 2)::varchar(2) as tukakigo,
        substr(raw_data, 36, 1)::varchar(1) as syohenkbn,
        substr(raw_data, 37, 8)::varchar(8) as torokuymd,
        substr(raw_data, 45, 16)::varchar(16) as mtuserid,
        substr(raw_data, 61, 26)::varchar(26) as mttime,
        substr(raw_data, 87, 14)::varchar(14) as filler,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvq00m7')}}
)
select * from substr_ktrla01vzz0kvq00m7