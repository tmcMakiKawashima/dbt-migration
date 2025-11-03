with substr_ktrla038zz0kadcb8j as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 8)::varchar(8) as ymd,
        substr(raw_data, 12, 1)::varchar(1) as ope_flg,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb8j')}}
)
select * from substr_ktrla038zz0kadcb8j