with substr_ktrla01vzz0kvq00m5 as (
    select
        substr(raw_data, 1, 3)::varchar(3) as rgncd3,
        substr(raw_data, 4, 3)::varchar(3) as oprccls,
        substr(raw_data, 7, 5)::varchar(5) as fobsisun,
        substr(raw_data, 12, 5)::varchar(5) as fobsisuo,
        substr(raw_data, 17, 8)::varchar(8) as fobsisukrkeymd,
        substr(raw_data, 25, 8)::varchar(8) as torokuymd,
        substr(raw_data, 33, 16)::varchar(16) as mtuserid,
        substr(raw_data, 49, 26)::varchar(26) as mttime,
        substr(raw_data, 75, 6)::varchar(6) as filler,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvq00m5')}}
)
select * from substr_ktrla01vzz0kvq00m5