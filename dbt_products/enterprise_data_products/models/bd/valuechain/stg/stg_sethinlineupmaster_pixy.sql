with stg_sethinlineupmaster_pixy as (
    select 
        tuikocd::varchar(8) as tuikocd
        ,tuikomei::varchar(51) as tuikomei
        ,teikyokahi::varchar(1) as teikyokahi
        ,tuikosyu::varchar(1) as tuikosyu
        ,categorycd::varchar(10) as categorycd
        ,touroku::varchar(8) as touroku
        ,kousin::varchar(8) as kousin
        ,tantou::varchar(7) as tantou
        ,_fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva32stlineupm') }}
    where _fivetran_deleted = 'false'
)
select * from stg_sethinlineupmaster_pixy
