with stg_tuikousotyakujokenjoho_pixy as (
    select 
        syasyug::varchar(4) as syasyug,
        tuikocd::varchar(8) as tuikocd,
        siyousyono::varchar(8) as siyousyono,
        hankata::varchar(20) as hankata,
        kotuikocd::varchar(8) as kotuikocd,
        vari::varchar(2) as vari,
        varix::varchar(2) as varix,
        torizikan::varchar(4) as torizikan,
        tuikomei::varchar(51) as tuikomei,
        hissucd::varchar(100) as hissucd,
        fukacd1::varchar(200) as fukacd1,
        fukacd2::varchar(200) as fukacd2,
        hincd::varchar(4) as hincd,
        syucd::varchar(2) as syucd,
        tuikosyu::varchar(1) as tuikosyu,
        syameino::varchar(3) as syameino,
        syameiedaban::varchar(3) as syameiedaban,
        avnmodely::varchar(4) as avnmodely,
        oiban::varchar(1) as oiban,
        touroku::varchar(8) as touroku,
        kousin::varchar(8) as kousin,
        tantou::varchar(7) as tantou,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva33tuikosochaku') }}
    where _fivetran_deleted = 'false'
)
select * from stg_tuikousotyakujokenjoho_pixy