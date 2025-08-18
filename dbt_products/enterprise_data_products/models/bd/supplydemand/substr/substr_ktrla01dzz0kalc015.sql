with substr_ktrla01dzz0kalc015 as (
    select
        substr(raw_data, 1, 7)::varchar(7) as kncode,
        substr(raw_data, 8, 60)::varchar(60) as sknmmei,
        substr(raw_data, 68, 1)::varchar(1) as knmsortjun,
        substr(raw_data, 69, 8)::varchar(8) as creymd,
        substr(raw_data, 77, 18)::varchar(18) as mtuser,
        substr(raw_data, 95, 26)::varchar(26) as mttime,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla01dzz0kalc015')}}
)
select * from substr_ktrla01dzz0kalc015