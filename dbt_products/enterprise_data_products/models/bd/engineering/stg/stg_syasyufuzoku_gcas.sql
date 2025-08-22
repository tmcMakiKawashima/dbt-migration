with stg_syasyufuzoku_gcas as (
    select 
        syasyu::varchar(4) as syasyu,
        hansiyono8::varchar(8) as hansiyono8,
        hankata::varchar(20) as hankata,
        syamei::varchar(50) as syamei,
        brand::varchar(1) as brand,
        bodytype::varchar(50) as bodytype,
        grademei::varchar(100) as grademei,
        nensiki::varchar(6) as nensiki,
        kirinaiyo::varchar(1) as kirinaiyo,
        mttime::varchar(16) as mttime,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_ogg_gcas','raw_cyyg9syasyufuzoku') }}
    where _fivetran_deleted = 'false'
)
select * from stg_syasyufuzoku_gcas
