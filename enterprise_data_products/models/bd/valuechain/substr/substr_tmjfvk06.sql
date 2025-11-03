with substr_tmjfvk06 as (
    select
        substr(raw_data, 1, 15)::varchar(15) as daiohin,
        substr(raw_data, 16, 2)::varchar(2) as daiohinsbetu,
        substr(raw_data, 18, 5)::varchar(5) as hantiiki,
        substr(raw_data, 23, 4)::varchar(4) as syusbetu,
        substr(raw_data, 27, 7)::varchar(7) as orderjtai1,
        substr(raw_data, 34, 7)::varchar(7) as orderjtai2,
        substr(raw_data, 41, 7)::varchar(7) as orderjtai3,
        substr(raw_data, 48, 7)::varchar(7) as orderjtai4,
        substr(raw_data, 55, 7)::varchar(7) as orderjtai5,
        substr(raw_data, 62, 8)::varchar(8) as made,
        substr(raw_data, 70, 5)::varchar(5) as kosincompid,
        substr(raw_data, 75, 10)::varchar(10) as kosinuserid,
        substr(raw_data, 85, 16)::varchar(16) as kosintime,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_tmjfvk06') }}
)
select * from substr_tmjfvk06