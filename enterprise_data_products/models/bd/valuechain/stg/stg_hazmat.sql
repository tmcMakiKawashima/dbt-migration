with stg_hazmat as (
    select
        haz::varchar(3) as haz,
        hazkankbn::varchar(1) as hazkankbn,
        kikenhinclass::varchar(3) as kikenhinclass,
        unno::varchar(4) as unno,
        psn::varchar(70) as psn,
        yokitoukyu::varchar(1) as yokitoukyu,
        haisiymd::varchar(8) as haisiymd,
        kosincompid::varchar(5) as kosincompid,
        kosinuserid::varchar(10) as kosinuserid,
        kosintime::varchar(16) as kosintime,
        onkosintime::timestamp_ntz as onkosintime, -- timestamp型
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{source('fivetran_database_idr_gsps_dxpfy2d', 'raw_cvk09hazmat')}}
    where _fivetran_deleted = 'false'
)
select * from stg_hazmat