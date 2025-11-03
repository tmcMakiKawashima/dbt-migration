with substr_tmjfvk02 as (
    select
        substr(raw_data, 1, 3)::varchar(3) as donyutiiki,
        substr(raw_data, 4, 5)::varchar(5) as hantiiki,
        substr(raw_data, 9, 10)::varchar(10) as hantiikijp,
        substr(raw_data, 19, 20)::varchar(20) as hantiikien,
        substr(raw_data, 39, 8)::varchar(8) as haisiymd,
        substr(raw_data, 47, 5)::varchar(5) as kosincompid,
        substr(raw_data, 52, 10)::varchar(10) as kosinuserid,
        substr(raw_data, 62, 16)::varchar(16) as kosintime,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_tmjfvk02') }}
)
select * from substr_tmjfvk02