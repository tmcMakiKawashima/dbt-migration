with stg_katashikihenkanmaster_pixy as (
    select 
        syameino::varchar(3) as syameino, 
        ctlkata::varchar(16) as ctlkata, 
        hanbaicd::varchar(4) as hanbaicd, 
        bitno::varchar(3) as bitno, 
        reqop::varchar(1) as reqop, 
        reqac::varchar(1) as reqac, 
        reqad::varchar(1) as reqad, 
        touroku::varchar(8) as touroku, 
        kousin::varchar(8) as kousin, 
        tantou::varchar(7) as tantou,  
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva97katahen') }}
    where _fivetran_deleted = 'false'
)
select * from stg_katashikihenkanmaster_pixy
