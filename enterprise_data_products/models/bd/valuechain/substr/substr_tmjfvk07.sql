with substr_tmjfvk07 as (
    select
        substr(raw_data, 1, 15)::varchar(15) as daiohin,
        substr(raw_data, 16, 7)::varchar(7) as orderjtai,
        substr(raw_data, 23, 5)::varchar(5) as hantiiki,
        substr(raw_data, 28, 4)::varchar(4) as syusbetu,
        substr(raw_data, 32, 1)::varchar(1) as daikiriymdkm,
        substr(raw_data, 33, 8)::varchar(8) as haisincreymd,
        substr(raw_data, 41, 8)::varchar(8) as daikiriyoteiymd,
        substr(raw_data, 49, 8)::varchar(8) as daikiriymd,
        substr(raw_data, 57, 5)::varchar(5) as kosincompid,
        substr(raw_data, 62, 10)::varchar(10) as kosinuserid,
        substr(raw_data, 72, 16)::varchar(16) as kosintime,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_tmjfvk07') }}
)
select * from substr_tmjfvk07