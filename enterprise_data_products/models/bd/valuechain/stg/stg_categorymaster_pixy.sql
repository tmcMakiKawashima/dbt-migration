with stg_categorymaster_pixy as (
    select 
        categorycd::varchar(10) as categorycd
        ,categorykai::varchar(1) as categorykai
        ,categorymei::varchar(50) as categorymei
        ,touroku::varchar(8) as touroku
        ,kousin::varchar(8) as kousin
        ,tantou::varchar(7) as tantou
        ,_fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva32categorym') }}
    where _fivetran_deleted = 'false'
)
select * from stg_categorymaster_pixy
