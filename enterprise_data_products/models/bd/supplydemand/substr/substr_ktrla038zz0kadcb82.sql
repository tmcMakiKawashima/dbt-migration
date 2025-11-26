with substr_ktrla038zz0kadcb82 as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 30)::varchar(30) as sle_model,
        substr(raw_data, 34, 2)::varchar(2) as carnm_cd,
        substr(raw_data, 36, 2)::varchar(2) as spec_no,
        substr(raw_data, 38, 2)::varchar(2) as capacity,
        substr(raw_data, 40, 5)::varchar(5) as eng_disp,
        substr(raw_data, 45, 2)::varchar(2) as fuel_cd,
        substr(raw_data, 47, 9)::varchar(9) as eng_model,
        substr(raw_data, 56, 3)::varchar(3) as tire_cd,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb82')}}
)
select * from substr_ktrla038zz0kadcb82