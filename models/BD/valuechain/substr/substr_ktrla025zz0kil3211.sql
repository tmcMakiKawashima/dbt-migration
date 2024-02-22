with substr_ktrla025zz0kil3211 as (
    select
        substr(raw_data, 1, 5)::varchar(5) as hanbaitencd,
        substr(raw_data, 6, 3)::varchar(3) as tenpocd,
        substr(raw_data, 9, 20)::varchar(20) as tenponame,
        substr(raw_data, 29, 6)::varchar(6) as startym,
        substr(raw_data, 35, 6)::varchar(6) as endym,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_ktrla025zz0kil3211') }}
)
select * from substr_ktrla025zz0kil3211
