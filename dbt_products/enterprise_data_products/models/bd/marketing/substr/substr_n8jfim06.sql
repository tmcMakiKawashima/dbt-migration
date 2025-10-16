with substr_n8jfim06 as (
  select
    substr(raw_data, 2, 4)::varchar(4) as car_kind_cd,
    substr(raw_data, 6, 1)::varchar(1) as ctg_cd,
    substr(raw_data, 7, 3)::varchar(3) as chg_no,
    substr(raw_data, 10, 2)::varchar(2) as car_name_cd,
    substr(raw_data, 12, 1)::varchar(1) as cnl_cd,
    substr(raw_data, 13, 9)::varchar(9) as eqp_mgr_id,
    substr(raw_data, 22, 8)::varchar(8) as eqp_cd,
    substr(raw_data, 30, 4)::varchar(4) as eqp_dtl_cd,
    substr(raw_data, 34, 1)::varchar(1) as data_kbn,
    substr(raw_data, 35, 150)::varchar(150) as eqp_dtl_org,
    substr(raw_data, 185, 768)::varchar(768) as eqp_dtl_chg_kanji,
    substr(raw_data, 953, 180)::varchar(180) as eqp_dtl_chg,
    substr(raw_data, 1133, 3)::varchar(3) as veh_eqp_cd,
    substr(raw_data, 1136, 4)::varchar(4) as veh_eqp_dtl_cd,
    substr(raw_data, 1140, 5)::varchar(5) as dsp_odr,
    ldts,
    line_number
  from {{ source('snowpipe_db_marketing', 'raw_n8jfim06')}}
)
select * from substr_n8jfim06