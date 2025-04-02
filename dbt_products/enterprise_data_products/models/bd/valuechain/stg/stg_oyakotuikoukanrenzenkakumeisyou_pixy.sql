with stg_oyakotuikoukanrenzenkakumeisyou_pixy as (
    select 
        syameino::varchar(3) as syameino, 
        stcd::varchar(8) as stcd, 
        stmeip::varchar(51) as stmeip, 
        touroku::varchar(8) as touroku, 
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy','raw_cva97dxoyakotknmz') }}
    where _fivetran_deleted = 'false'
)
select * from stg_oyakotuikoukanrenzenkakumeisyou_pixy
