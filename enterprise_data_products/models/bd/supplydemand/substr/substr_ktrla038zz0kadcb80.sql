with substr_ktrla038zz0kadcb80 as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 5)::varchar(5) as dlr_cd,
        substr(raw_data, 9, 2)::varchar(2) as carnm_cd,
        substr(raw_data, 11, 2)::varchar(2) as spec_no,
        substr(raw_data, 13, 1)::varchar(1) as post_class,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb80')}}
)
select * from substr_ktrla038zz0kadcb80