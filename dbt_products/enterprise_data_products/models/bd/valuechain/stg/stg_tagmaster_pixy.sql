with stg_tagmaster_pixy as (
    select 
        tagcd::varchar(4) as tagcd
        ,tagkaiso::varchar(1) as tagkaiso
        ,tagmei::varchar(50) as tagmei
        ,touroku::varchar(8) as touroku
        ,kousin::varchar(8) as kousin
        ,tantou::varchar(7) as tantou
        ,_fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva32tagm') }}
    where _fivetran_deleted = 'false'
)
select * from stg_tagmaster_pixy
