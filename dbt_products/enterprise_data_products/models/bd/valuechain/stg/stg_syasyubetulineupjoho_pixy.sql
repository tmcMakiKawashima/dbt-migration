with stg_syasyubetulineupjoho_pixy as (
    select 
        syameino::varchar(3) as syameino,
        tuikocd::varchar(8) as tuikocd,
        tuikomei::varchar(51) as tuikomei,
        teikyokahi::varchar(1) as teikyokahi,
        tuikosyu::varchar(1) as tuikosyu,
        hincd::varchar(4) as hincd,
        syucd::varchar(2) as syucd,
        syasyug::varchar(4) as syasyug,
        sinsetuflg::varchar(1) as sinsetuflg,
        touroku::varchar(8) as touroku,
        kousin::varchar(8) as kousin,
        tantou::varchar(7) as tantou,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva33syalineupinf') }}
    where _fivetran_deleted = 'false'
)
select * from stg_syasyubetulineupjoho_pixy