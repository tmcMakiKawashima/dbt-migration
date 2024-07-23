with substr_dv2a4774 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 4)::varchar(4) as syasyu_cd,
        substr(raw_data, 6, 4)::varchar(4) as siyoptno,
        substr(raw_data, 10, 4)::varchar(4) as siyocd,
        ldts
    from {{source('snowpipe_db_valuechain', 'raw_dv2a4774')}}
)
select * from substr_dv2a4774