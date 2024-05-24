with substr_ktrla025zz0kil3206 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as delflg,
        substr(raw_data, 2, 9)::varchar(9) as nyukono,
        substr(raw_data, 11, 4)::varchar(4) as meisaino,
        substr(raw_data, 15, 11)::varchar(11) as sobinamesansyocd,
        substr(raw_data, 26, 8)::varchar(8) as seibicd,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla025zz0kil3206') }}
)
select * from substr_ktrla025zz0kil3206
