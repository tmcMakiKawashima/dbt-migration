with stg_tagjoho_pixy as (
    select 
        tuikocd::varchar(8) as tuikocd
        ,tagcd::varchar(4) as tagcd
        ,touroku::varchar(8) as touroku
        ,kousin::varchar(8) as kousin
        ,tantou::varchar(7) as tantou
        ,_fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva32taginf') }}
    where _fivetran_deleted = 'false'
)
select * from stg_tagjoho_pixy
