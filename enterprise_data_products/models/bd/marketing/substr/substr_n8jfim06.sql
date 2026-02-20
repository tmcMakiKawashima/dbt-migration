with substr_n8jfim06 as (
  select
    to_varchar(substr(raw_data, 2, 4), 'utf-8')::varchar(4) as car_kind_cd,
    to_varchar(substr(raw_data, 6, 1), 'utf-8')::varchar(1) as ctg_cd,
    to_varchar(substr(raw_data, 7, 3), 'utf-8')::varchar(3) as chg_no,
    to_varchar(substr(raw_data, 10, 2), 'utf-8')::varchar(2) as car_name_cd,
    to_varchar(substr(raw_data, 12, 1), 'utf-8')::varchar(1) as cnl_cd,
    to_varchar(substr(raw_data, 13, 9), 'utf-8')::varchar(9) as eqp_mgr_id,
    to_varchar(substr(raw_data, 22, 8), 'utf-8')::varchar(8) as eqp_cd,
    to_varchar(substr(raw_data, 30, 4), 'utf-8')::varchar(4) as eqp_dtl_cd,
    to_varchar(substr(raw_data, 34, 1), 'utf-8')::varchar(1) as data_kbn,
    to_varchar(substr(raw_data, 35, 150), 'utf-8')::varchar(150) as eqp_dtl_org,
    to_varchar(substr(raw_data, 185, 768), 'utf-8')::varchar(768) as eqp_dtl_chg_kanji,
    to_varchar(substr(raw_data, 953, 180), 'utf-8')::varchar(180) as eqp_dtl_chg,
    to_varchar(substr(raw_data, 1133, 3), 'utf-8')::varchar(3) as veh_eqp_cd,
    to_varchar(substr(raw_data, 1136, 4), 'utf-8')::varchar(4) as veh_eqp_dtl_cd,
    to_varchar(substr(raw_data, 1140, 5), 'utf-8')::varchar(5) as dsp_odr,
    ldts,
    line_number
  from {{ ref('byte_n8jfim06')}}
)
select * from substr_n8jfim06