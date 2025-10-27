with stg_katashikibit_pixy as (
    select 
        syameino::varchar(12) as syameino, 
        tuikou::varchar(32) as tuikou, 
        seg::varchar(12) as seg, 
        seq::varchar(12) as seq, 
        bitno::varchar(12) as bitno, 
        touroku::varchar(32) as touroku, 
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva97dxyohinmktbit') }}
    where _fivetran_deleted = 'false'
)
select * from stg_katashikibit_pixy
