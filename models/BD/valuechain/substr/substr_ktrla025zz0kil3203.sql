with substr_ktrla025zz0kil3203 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as delflg,
        substr(raw_data, 2, 5)::varchar(5) as nyukohanbaitencd,
        substr(raw_data, 7, 8)::varchar(8) as jutyuno,
        substr(raw_data, 15, 4)::varchar(4) as seisany,
        substr(raw_data, 19, 4)::varchar(4) as seisanmd,
        substr(raw_data, 23, 9)::varchar(9) as nyukono,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla025zz0kil3203') }}
)
select * from substr_ktrla025zz0kil3203
