with stg_oyakotuikoukanrenzenkakumeisyou_pixy as (
    select 
        syameino::varchar(12) as syameino, 
        stcd::varchar(32) as stcd, 
        stmeig::varchar(204) as stmeig, 
        touroku::varchar(32) as touroku, 
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva97dxoyakotknmz') }}
    where _fivetran_deleted = 'false'
)
select * from stg_oyakotuikoukanrenzenkakumeisyou_pixy
