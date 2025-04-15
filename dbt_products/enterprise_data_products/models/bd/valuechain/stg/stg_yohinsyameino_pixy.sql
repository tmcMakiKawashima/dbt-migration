with stg_yohinsyameino_pixy as (
    select 
        syameino::varchar(12) as syameino, 
        syameip::varchar(176) as syameip, 
        syameid::varchar(88) as syameid, 
        kara::varchar(24) as kara, 
        made::varchar(24) as made, 
        kahi::varchar(4) as kahi, 
        gketa::varchar(8) as gketa, 
        touroku::varchar(32) as touroku, 
        kousin::varchar(32) as kousin, 
        tantou::varchar(28) as tantou, 
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva89syameino') }}
    where _fivetran_deleted = 'false'
)
select * from stg_yohinsyameino_pixy