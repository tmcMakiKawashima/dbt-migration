with stg_katashikibit_pixy as (
    select 
        syameino::varchar(3) as syameino, 
        tuikou::varchar(8) as tuikou, 
        seg::varchar(3) as seg, 
        seq::varchar(3) as seq, 
        bitno::varchar(3) as bitno, 
        touroku::varchar(8) as touroku, 
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva97dxyohinmktbit') }}
    where _fivetran_deleted = 'false'
)
select * from stg_katashikibit_pixy
