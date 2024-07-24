with substr_n8jfim04 as (
    select
        substr(raw_data, 2, 11)::varchar(11) as hanbaino,
        substr(raw_data, 13, 20)::varchar(20) as kosyokata,
        substr(raw_data, 33, 3)::varchar(3) as suffix_code,
        substr(raw_data, 36, 30)::varchar(30) as hanbaikata,
        substr(raw_data, 66, 3)::varchar(3) as shiyoudai,
        substr(raw_data, 69, 3)::varchar(3) as shiyousai,
        substr(raw_data, 72, 1)::varchar(1) as hsochaku,
        substr(raw_data, 73, 1)::varchar(1) as sflg,
        substr(raw_data, 74, 9)::varchar(9) as cd_sksifunc,
        substr(raw_data, 83, 9)::varchar(9) as cd_ksnfunc,
        substr(raw_data, 92, 16)::varchar(16) as cd_sksisya,
        substr(raw_data, 108, 16)::varchar(16) as cd_ksnsya,
        substr(raw_data, 124, 26)::varchar(26) as dt_sakusei,
        substr(raw_data, 150, 26)::varchar(26) as dt_kosin,
        ldts
    from {{ source('snowpipe_db_marketing', 'raw_n8jfim04') }}
)
select * from substr_n8jfim04