with substr_da5a219a as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mtkbn,
        substr(raw_data, 2, 6)::varchar(6) as syadai_kt,
        substr(raw_data, 8, 7)::varchar(7) as frmno,
        substr(raw_data, 15, 5)::varchar(5) as hnbaitncd,
        substr(raw_data, 20, 4)::varchar(4) as haisya_y,
        substr(raw_data, 24, 2)::varchar(2) as haisya_m,
        substr(raw_data, 26, 2)::varchar(2) as haisya_d,
        substr(raw_data, 28, 13)::varchar(13) as createuser,
        substr(raw_data, 41, 26)::varchar(26) as createtime,
        substr(raw_data, 67, 13)::varchar(13) as updateuser,
        substr(raw_data, 80, 26)::varchar(26) as updatetime,
        ldts
    from {{ source('snowpipe_db_supplydemand', 'raw_da5a219a') }}
)
select * from substr_da5a219a