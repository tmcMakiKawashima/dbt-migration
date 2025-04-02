with stg_tuikouzenkakumeisyou_pixy as (
    select 
        syameino::varchar(3) as syameino, 
        tuikou::varchar(8) as tuikou, 
        tuimeig::varchar(51) as tuimeig, 
        touroku::varchar(8) as touroku, 
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy','raw_cva97dxyohintknmz') }}
    where _fivetran_deleted = 'false'
)
select * from stg_tuikouzenkakumeisyou_pixy