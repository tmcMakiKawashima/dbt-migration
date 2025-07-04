with stg_lineupmaster_pixy as (
    select 
        hincd::varchar(4) as hincd
        ,syucd::varchar(2) as syucd
        ,tuikocd::varchar(8) as tuikocd
        ,hinmokumei::varchar(25) as hinmokumei
        ,syuruimei::varchar(25) as syuruimei
        ,teikyokahi::varchar(1) as teikyokahi
        ,tuikosyu::varchar(1) as tuikosyu
        ,categorycd::varchar(10) as categorycd
        ,touroku::varchar(8) as touroku
        ,kousin::varchar(8) as kousin
        ,tantou::varchar(7) as tantou
        ,_fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva32lineupm') }}
    where _fivetran_deleted = 'false'
)
select * from stg_lineupmaster_pixy
