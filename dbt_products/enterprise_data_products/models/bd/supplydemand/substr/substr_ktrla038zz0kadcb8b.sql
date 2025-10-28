with substr_ktrla038zz0kadcb8b as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 5)::varchar(5) as dlr_cd,
        substr(raw_data, 9, 30)::varchar(30) as sle_model,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb8b')}}
)
select * from substr_ktrla038zz0kadcb8b