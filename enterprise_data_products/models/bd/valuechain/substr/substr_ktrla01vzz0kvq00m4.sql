with substr_ktrla01vzz0kvq00m4 as (
    select
        substr(raw_data, 1, 5)::varchar(5) as dist,
        substr(raw_data, 6, 2)::varchar(2) as fdcd,
        substr(raw_data, 8, 1)::varchar(1) as tukacd,
        substr(raw_data, 9, 4)::varchar(4) as enzansizin,
        substr(raw_data, 13, 4)::varchar(4) as enzansizio,
        substr(raw_data, 17, 8)::varchar(8) as eznsijikrkeymd,
        substr(raw_data, 25, 3)::varchar(3) as rgncdn,
        substr(raw_data, 28, 3)::varchar(3) as rgncdo,
        substr(raw_data, 31, 8)::varchar(8) as rgncdkrkeymd,
        substr(raw_data, 39, 3)::varchar(3) as tiikicd3,
        substr(raw_data, 42, 8)::varchar(8) as torokuymd,
        substr(raw_data, 50, 16)::varchar(16) as mtuserid,
        substr(raw_data, 66, 26)::varchar(26) as mttime,
        substr(raw_data, 92, 9)::varchar(9) as filler,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvq00m4')}}
)
select * from substr_ktrla01vzz0kvq00m4