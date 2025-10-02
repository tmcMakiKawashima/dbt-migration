with stg_shipnamemst_vlc as (
    select
        fune_cd::varchar(6) as fune_cd, 
        funemei::varchar(24) as funemei, 
        capa::varchar(4) as capa, 
        hyoujijyun::varchar(3) as hyoujijyun, 
        upddatetime::timestamp_ntz(9) as upddatetime, 
        upduid::varchar(20) as upduid, 
        insertdatetime::timestamp_ntz(9) as insertdatetime, 
        insertuid::varchar(20) as insertuid, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubs100shipnamem') }}
    where _fivetran_deleted = 'false'
)
select * from stg_shipnamemst_vlc