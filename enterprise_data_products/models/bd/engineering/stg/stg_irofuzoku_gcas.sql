with stg_irofuzoku_gcas as (
    select 
        naigaikbn::varchar(1) as naigaikbn,
        clrno::varchar(5) as clrno,
        syasyu::varchar(4) as syasyu,
        clrmei::varchar(50) as clrmei,
        mttime::varchar(16) as mttime,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_ogg_gcas_osyyvl0100db20','raw_cyyg9irofuzoku') }}
    where _fivetran_deleted = 'false'
)
select * from stg_irofuzoku_gcas