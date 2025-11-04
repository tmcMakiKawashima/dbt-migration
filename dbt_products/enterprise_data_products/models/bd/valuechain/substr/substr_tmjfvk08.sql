with substr_tmjfvk08 as (
    select
        substr(raw_data, 1, 15)::varchar(15) as hinban,
        substr(raw_data, 16, 4)::varchar(4) as syusbetu,
        substr(raw_data, 20, 18)::varchar(18) as seppen,
        substr(raw_data, 38, 8)::varchar(8) as hinbansiki,
        substr(raw_data, 46, 5)::varchar(5) as kosincompid,
        substr(raw_data, 51, 10)::varchar(10) as kosinuserid,
        substr(raw_data, 61, 16)::varchar(16) as kosintime,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_tmjfvk08') }}
)
select * from substr_tmjfvk08