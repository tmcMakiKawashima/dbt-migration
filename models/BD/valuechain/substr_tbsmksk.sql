with substr_tbsmksk as (
    select
        substr(raw_data, 1, 3)::VARCHAR(3) as ID,
        substr(raw_data, 4, 5)::VARCHAR(5) as KYOUHAN,
        substr(raw_data, 9, 2)::VARCHAR(2) as KYOTEN,
        substr(raw_data, 11, 15)::VARCHAR(15) as YOBI,
        substr(raw_data, 26, 2)::VARCHAR(2) as SISHACD,
        substr(raw_data, 28, 2)::VARCHAR(2) as TSIWAKECD1,
        substr(raw_data, 30, 2)::VARCHAR(2) as TSIWAKECD2,
        substr(raw_data, 32, 369)::VARCHAR(369) as FILLER,
        LDTS
    from {{ source('snowpipe_db_valuechain', 'raw_tbsmksk') }}
)
select * from substr_tbsmksk
