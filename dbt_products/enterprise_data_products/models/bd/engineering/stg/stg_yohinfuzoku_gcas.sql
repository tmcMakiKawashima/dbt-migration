with stg_yohinfuzoku_gcas as (
    select 
        syasyu::varchar(4) as syasyu,
        tuikocd::varchar(6) as tuikocd,
        tuikomei::varchar(102) as tuikomei,
        syameino::varchar(3) as syameino,
        edaban::varchar(3) as edaban,
        fuzokukbn::varchar(3) as fuzokukbn,
        title::varchar(100) as title,
        value::varchar(2048) as value,
        mttime::varchar(16) as mttime,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_ogg_gcas','raw_cyyg9yohinfuzoku') }}
    where _fivetran_deleted = 'false'
)
select * from stg_yohinfuzoku_gcas
