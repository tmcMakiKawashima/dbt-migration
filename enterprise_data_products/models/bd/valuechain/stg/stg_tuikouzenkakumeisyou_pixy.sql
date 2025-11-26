with stg_tuikouzenkakumeisyou_pixy as (
    select 
        syameino::varchar(12) as syameino, 
        tuikou::varchar(32) as tuikou, 
        tuimeig::varchar(204) as tuimeig, 
        touroku::varchar(32) as touroku, 
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva97dxyohintknmz') }}
    where _fivetran_deleted = 'false'
)
select * from stg_tuikouzenkakumeisyou_pixy