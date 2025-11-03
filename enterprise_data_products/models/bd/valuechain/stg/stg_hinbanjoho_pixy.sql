with stg_hinbanjoho_pixy as (
    select 
        syasyug::varchar(4) as syasyug,
        tuikocd::varchar(8) as tuikocd,
        siyousyono::varchar(8) as siyousyono,
        hankata::varchar(20) as hankata,
        vari::varchar(2) as vari,
        lv1hinban::varchar(10) as lv1hinban,
        htyhkykbn::varchar(1) as htyhkykbn,
        hinban::varchar(10) as hinban,
        iroruibetu::varchar(2) as iroruibetu,
        syaryouclr::varchar(5) as syaryouclr,
        to_number(iff(rtrim(kosu) = '', 0, kosu)) ::number(3,0) as kosu,
        hinmei::varchar(40) as hinmei,
        colormei::varchar(25) as colormei,
        naigaikbn::varchar(1) as naigaikbn,
        touroku::varchar(8) as touroku,
        kousin::varchar(8) as kousin,
        tantou::varchar(7) as tantou,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva33hinbanpy') }}
    where _fivetran_deleted = 'false'
)
select * from stg_hinbanjoho_pixy