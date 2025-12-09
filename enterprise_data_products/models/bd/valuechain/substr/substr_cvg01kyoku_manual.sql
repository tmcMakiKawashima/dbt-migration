with substr_cvg01kyoku_manual as (
    select
        substr(raw_data, 1, 3)::varchar(3) as kyokucd,
        substr(raw_data, 5, 10)::varchar(10) as kyokumeiwa,
        substr(raw_data, 16, 20)::varchar(20) as kyokumeiei,
        substr(raw_data, 36, 8)::varchar(8) as torokud,
        substr(raw_data, 44, 6)::varchar(6) as torokut,
        substr(raw_data, 50, 8)::varchar(8) as kosind,
        substr(raw_data, 58, 6)::varchar(6) as kosint,
        substr(raw_data, 64, 16)::varchar(16) as kosinsya,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_cvg01kyoku_manual') }}
)
select * from substr_cvg01kyoku_manual