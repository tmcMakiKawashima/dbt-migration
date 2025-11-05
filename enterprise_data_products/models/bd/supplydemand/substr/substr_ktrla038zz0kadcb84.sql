with substr_ktrla038zz0kadcb84 as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 30)::varchar(30) as sle_model,
        substr(raw_data, 34, 3)::varchar(3) as bdcol_cd,
        substr(raw_data, 37, 4)::varchar(4) as inner_cd,
        substr(raw_data, 41, 3)::varchar(3) as opt_cd,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb84')}}
)
select * from substr_ktrla038zz0kadcb84