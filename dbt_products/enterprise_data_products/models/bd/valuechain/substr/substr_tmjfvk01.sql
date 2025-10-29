with substr_tmjfvk01 as (
    select
        substr(raw_data, 1, 7)::varchar(7) as jtai,
        substr(raw_data, 8, 20)::varchar(20) as jtaimei,
        substr(raw_data, 28, 1)::varchar(1) as siirekbn,
        substr(raw_data, 29, 1)::varchar(1) as orderkbn,
        substr(raw_data, 30, 8)::varchar(8) as haisiymd,
        substr(raw_data, 38, 5)::varchar(5) as kosincompid,
        substr(raw_data, 43, 10)::varchar(10) as kosinuserid,
        substr(raw_data, 53, 16)::varchar(16) as kosintime,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_tmjfvk01') }}
)
select * from substr_tmjfvk01