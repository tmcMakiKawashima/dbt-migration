with substr_ktrla01vzz0kvq00m6 as (
    select
        substr(raw_data, 1, 20)::varchar(20) as hinban,
        substr(raw_data, 21, 1)::varchar(1) as tiikigrpcd,
        substr(raw_data, 22, 2)::varchar(2) as pfcdn,
        substr(raw_data, 24, 2)::varchar(2) as pfcdo,
        substr(raw_data, 26, 8)::varchar(8) as pfcdkrkeymd,
        substr(raw_data, 34, 1)::varchar(1) as zidoskskbn,
        substr(raw_data, 35, 8)::varchar(8) as torokuymd,
        substr(raw_data, 43, 20)::varchar(20) as mdlskicom,
        substr(raw_data, 63, 16)::varchar(16) as mtuserid,
        substr(raw_data, 79, 26)::varchar(26) as mttime,
        substr(raw_data, 105, 6)::varchar(6) as filler,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvq00m6')}}
)
select * from substr_ktrla01vzz0kvq00m6