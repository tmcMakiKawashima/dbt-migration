with substr_da5a213a as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mtkbn,
        substr(raw_data, 2, 1)::varchar(1) as lok_y4,
        substr(raw_data, 3, 9)::varchar(9) as syadai_kt,
        substr(raw_data, 12, 7)::varchar(7) as frmno,
        substr(raw_data, 19, 3)::varchar(3) as wmi,
        substr(raw_data, 22, 6)::varchar(6) as vds,
        substr(raw_data, 28, 1)::varchar(1) as mdlyr,
        substr(raw_data, 29, 1)::varchar(1) as vin_vds_cd,
        substr(raw_data, 30, 4)::varchar(4) as lok_y,
        substr(raw_data, 34, 2)::varchar(2) as lok_m,
        substr(raw_data, 36, 4)::varchar(4) as msgno,
        substr(raw_data, 40, 30)::varchar(30) as itemcontent,
        substr(raw_data, 70, 13)::varchar(13) as createuser,
        substr(raw_data, 83, 26)::varchar(26) as createtime,
        substr(raw_data, 109, 13)::varchar(13) as updateuser,
        substr(raw_data, 122, 26)::varchar(26) as updatetime,
        ldts,
        line_number
    from {{ source('snowpipe_db_supplydemand', 'raw_da5a213a') }}
)
select * from substr_da5a213a