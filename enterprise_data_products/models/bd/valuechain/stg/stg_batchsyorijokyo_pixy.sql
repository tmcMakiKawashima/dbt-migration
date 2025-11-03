with stg_batchsyorijokyo_pixy as (
    select 
        kinouid::varchar(8) as kinouid,
        syasyug::varchar(4) as syasyug,
        syoristatime::varchar(14) as syoristatime,
        syoriendtime::varchar(14) as syoriendtime,
        touroku::varchar(8) as touroku,
        kousin::varchar(8) as kousin,
        tantou::varchar(7) as tantou,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva33batchstatus') }}
    where _fivetran_deleted = 'false'
)
select * from stg_batchsyorijokyo_pixy