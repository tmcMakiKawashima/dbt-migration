with substr_tsjfa36i as (
    select
        substr(raw_data, 132, 7)::varchar(7) as kncode,
        substr(raw_data, 139, 20)::varchar(20) as sknmmei,
        substr(raw_data, 159, 20)::varchar(20) as egymmei,
        substr(raw_data, 179, 8)::varchar(8) as sakusei_ymd,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_tsjfa36i')}}
)
select * from substr_tsjfa36i