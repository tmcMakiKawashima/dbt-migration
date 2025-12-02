with stg_syaryojoho_yohinsyameino_pixy as (
    select 
        syasyug::varchar(4) as syasyug,
        siyousyono::varchar(8) as siyousyono,
        hankata::varchar(20) as hankata,
        syameikbn::varchar(1) as syameikbn,
        sinkyukbn::varchar(1) as sinkyukbn,
        seikansyamei::varchar(2) as seikansyamei,
        nensiki::varchar(6) as nensiki,
        syameiedasan::varchar(69) as syameiedasan,
        syameino::varchar(3) as syameino,
        syameiedaban::varchar(3) as syameiedaban,
        touroku::varchar(8) as touroku,
        kousin::varchar(8) as kousin,
        tantou::varchar(7) as tantou,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_idr_pixy_dxpfy2d','raw_cva33syaryosya') }}
    where _fivetran_deleted = 'false'
)
select * from stg_syaryojoho_yohinsyameino_pixy