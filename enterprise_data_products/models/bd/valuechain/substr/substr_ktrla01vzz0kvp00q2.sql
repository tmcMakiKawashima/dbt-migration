with substr_ktrla01vzz0kvp00q2 as (
    select
        substr(raw_data, 1, 3)::varchar(3) as srihnymtkey,
        substr(raw_data, 4, 27)::varchar(27) as srihanyomstkey,
        substr(raw_data, 31, 234)::varchar(234) as srihnymtdata,
        substr(raw_data, 265, 16)::varchar(16) as mtuserid,
        substr(raw_data, 281, 26)::varchar(26) as mttime,
        substr(raw_data, 307, 14)::varchar(14) as filler,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvp00q2')}}
)
select * from substr_ktrla01vzz0kvp00q2