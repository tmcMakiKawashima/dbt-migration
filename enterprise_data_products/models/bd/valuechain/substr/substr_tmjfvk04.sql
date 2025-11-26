with substr_tmjfvk04 as (
    select
        substr(raw_data, 1, 15)::varchar(15) as hinban,
        substr(raw_data, 16, 2)::varchar(2) as hinbansbetu,
        substr(raw_data, 18, 4)::varchar(4) as syusbetu,
        substr(raw_data, 22, 2)::varchar(2) as hasseigen,
        substr(raw_data, 24, 40)::varchar(40) as hinmei,
        substr(raw_data, 64, 1)::varchar(1) as hinbanhyojikbn,
        substr(raw_data, 65, 5)::varchar(5) as kosincompid,
        substr(raw_data, 70, 10)::varchar(10) as kosinuserid,
        substr(raw_data, 80, 16)::varchar(16) as kosintime,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_tmjfvk04') }}
)
select * from substr_tmjfvk04