with stg_avnsyohinhinmokumeisyo_pixy as (
    select 
        syasyug::varchar(4) as syasyug,
        dbase::varchar(8) as dbase,
        avnmodely::varchar(4) as avnmodely,
        oiban::varchar(1) as oiban,
        syouhinno::varchar(4) as syouhinno,
        syouhinmei::varchar(25) as syouhinmei,
        touroku::varchar(8) as touroku,
        kousin::varchar(8) as kousin,
        tantou::varchar(7) as tantou,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva31avnsyohin') }}
    where _fivetran_deleted = 'false'
)
select * from stg_avnsyohinhinmokumeisyo_pixy