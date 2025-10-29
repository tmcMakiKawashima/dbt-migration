with substr_ktrla038zz0kadcb81 as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 2)::varchar(2) as carnm_cd,
        substr(raw_data, 6, 2)::varchar(2) as spec_no,
        substr(raw_data, 8, 1)::varchar(1) as day_sesn_clss,
        substr(raw_data, 9, 1)::varchar(1) as slecar_flg,
        substr(raw_data, 10, 1)::varchar(1) as apitdt_prpt_obj_flg,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb81')}}
)
select * from substr_ktrla038zz0kadcb81