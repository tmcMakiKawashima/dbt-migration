with substr_ktrla025zz0kil3207 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mtkbn,
        substr(raw_data, 2, 9)::varchar(9) as strno,
        substr(raw_data, 11, 4)::varchar(4) as dtlno,
        substr(raw_data, 15, 4)::varchar(4) as prtnum,
        substr(raw_data, 19, 11)::varchar(11) as prtnmcd,
        substr(raw_data, 30, 15)::varchar(15) as hnbncd,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla025zz0kil3207') }}
)
select * from substr_ktrla025zz0kil3207
