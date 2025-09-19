with stg_syasyusiji_gcas as (
    select 
        syasyu::varchar(4) as syasyu,
        hansiyono8::varchar(8) as hansiyono8,
        jyokenno::varchar(4) as jyokenno,
        seisan80::varchar(1) as seisan80,
        seisan100::varchar(1) as seisan100,
        hankatajk1ud::varchar(1) as hankatajk1ud,
        hankatajk1keta::varchar(1) as hankatajk1keta,
        hankatajk1val::varchar(1) as hankatajk1val,
        hankatajk2ud::varchar(1) as hankatajk2ud,
        hankatajk2val::varchar(10) as hankatajk2val,
        framejkkara::varchar(7) as framejkkara,
        framejkmade::varchar(7) as framejkmade,
        yusendo::varchar(2) as yusendo,
        syori::varchar(1) as syori,
        com::varchar(100) as com,
        mttime::varchar(16) as mttime,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_ogg_gcas_osyyvl0100db20','raw_cyyg9syasyusiji') }}
    where _fivetran_deleted = 'false'
)
select * from stg_syasyusiji_gcas