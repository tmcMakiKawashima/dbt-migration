with substr_tsjfa36c as (
    select
        substr(raw_data, 1, 11)::varchar(11) as dummy1,
        substr(raw_data, 12, 2)::varchar(2) as sno,
        substr(raw_data, 14, 117)::varchar(117) as dummy2,
        substr(raw_data, 131, 2)::varchar(2) as shamei,
        substr(raw_data, 133, 20)::varchar(20) as skshameimei,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_tsjfa36c')}}
)
select * from substr_tsjfa36c