with substr_ktrla038zz0kadcb89 as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 2)::varchar(2) as spec_no,
        substr(raw_data, 6, 2)::varchar(2) as carnm_cd,
        substr(raw_data, 8, 7)::varchar(7) as funcdtl_cd,
        substr(raw_data, 15, 20)::varchar(20) as ctl_model,
        substr(raw_data, 35, 3)::varchar(3) as bdcol_cd,
        substr(raw_data, 38, 4)::varchar(4) as inner_cd,
        substr(raw_data, 42, 4)::varchar(4) as eqp_cond1,
        substr(raw_data, 46, 4)::varchar(4) as eqp_cond2,
        substr(raw_data, 50, 4)::varchar(4) as eqp_cond3,
        substr(raw_data, 54, 4)::varchar(4) as eqp_cond4,
        substr(raw_data, 58, 4)::varchar(4) as eqp_cond5,
        substr(raw_data, 62, 4)::varchar(4) as eqp_cond6,
        substr(raw_data, 66, 4)::varchar(4) as eqp_cond7,
        substr(raw_data, 70, 4)::varchar(4) as eqp_cond8,
        substr(raw_data, 74, 3)::varchar(3) as tire_cd,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb89')}}
)
select * from substr_ktrla038zz0kadcb89