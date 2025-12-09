with substr_ktrla038zz0kadcb8f as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 2)::varchar(2) as spec_no,
        substr(raw_data, 6, 2)::varchar(2) as carnm_cd,
        substr(raw_data, 8, 7)::varchar(7) as funcdtl_cd,
        substr(raw_data, 15, 8)::varchar(8) as lineoff_beto_ymd,
        substr(raw_data, 23, 5)::varchar(5) as eptcapa_cnt,
        substr(raw_data, 28, 5)::varchar(5) as odr_rslt_cnt,
        substr(raw_data, 33, 5)::varchar(5) as std_cnt,
        substr(raw_data, 38, 5)::varchar(5) as uprlmt_cnt,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb8f')}}
)
select * from substr_ktrla038zz0kadcb8f