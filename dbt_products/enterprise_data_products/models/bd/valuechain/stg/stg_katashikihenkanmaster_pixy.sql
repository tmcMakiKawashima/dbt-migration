with stg_katashikihenkanmaster_pixy as (
    select 
        syameino::varchar(12) as syameino, 
        ctlkata::varchar(64) as ctlkata, 
        hanbaicd::varchar(16) as hanbaicd, 
        bitno::varchar(12) as bitno, 
        reqop::varchar(4) as reqop, 
        reqac::varchar(4) as reqac, 
        reqad::varchar(4) as reqad, 
        touroku::varchar(32) as touroku, 
        kousin::varchar(32) as kousin, 
        tantou::varchar(28) as tantou, 
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva97katahen') }}
    where _fivetran_deleted = 'false'
)
select * from stg_katashikihenkanmaster_pixy
