with substr_ktrla025zz0kil3204 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mtkbn,
        substr(raw_data, 2, 9)::varchar(9) as strno,
        substr(raw_data, 11, 4)::varchar(4) as dtlno,
        substr(raw_data, 15, 1)::varchar(1) as grtpa,
        substr(raw_data, 16, 4)::varchar(4) as t1wcd,
        substr(raw_data, 20, 10)::varchar(10) as refcd,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla025zz0kil3204') }}
)
select * from substr_ktrla025zz0kil3204
