with substr_ktrla038zz0kadcb85 as (
    select
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 5)::varchar(5) as dfsc,
        substr(raw_data, 9, 2)::varchar(2) as spec_no,
        substr(raw_data, 11, 2)::varchar(2) as carnm_cd,
        substr(raw_data, 13, 30)::varchar(30) as sle_model,
        substr(raw_data, 43, 3)::varchar(3) as bdcol_cd,
        substr(raw_data, 46, 4)::varchar(4) as inner_cd,
        substr(raw_data, 50, 3)::varchar(3) as tire_cd,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb85')}}
)
select * from substr_ktrla038zz0kadcb85