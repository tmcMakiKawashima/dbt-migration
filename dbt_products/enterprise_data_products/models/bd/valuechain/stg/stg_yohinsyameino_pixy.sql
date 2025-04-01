with stg_yohinsyameino_pixy as (
    select 
        syameino::varchar(3) as syameino, 
        syameip::varchar(44) as syameip, 
        syameid::varchar(22) as syameid, 
        kara::varchar(6) as kara, 
        made::varchar(6) as made, 
        kahi::varchar(1) as kahi, 
        gketa::varchar(2) as gketa, 
        touroku::varchar(8) as touroku, 
        kousin::varchar(8) as kousin, 
        tantou::varchar(7) as tantou, 
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy','raw_cva89syameino') }}
    where _fivetran_deleted = 'false'
)
select * from stg_yohinsyameino_pixy