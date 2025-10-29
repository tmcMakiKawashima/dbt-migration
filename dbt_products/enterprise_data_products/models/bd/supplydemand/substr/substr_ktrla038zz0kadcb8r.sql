with substr_ktrla038zz0kadcb8r as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 2)::varchar(2) as carnm_cd,
        substr(raw_data, 6, 2)::varchar(2) as spec_no,
        substr(raw_data, 8, 5)::varchar(5) as dlr_cd,
        substr(raw_data, 13, 8)::varchar(8) as obj_ym_jun,
        substr(raw_data, 21, 7)::varchar(7) as funcdtl_cd,
        substr(raw_data, 28, 5)::varchar(5) as odr_capa_cnt,
        substr(raw_data, 33, 5)::varchar(5) as odr_rslt_cnt,
        substr(raw_data, 38, 5)::varchar(5) as eptcapa_cnt,
        substr(raw_data, 43, 1)::varchar(1) as thirds_use_flg,
        substr(raw_data, 44, 1)::varchar(1) as inodr_exc_flg,
        substr(raw_data, 45, 3)::varchar(3) as shinq_kbn,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb8r')}}
)
select * from substr_ktrla038zz0kadcb8r