with stg_hinmokuhiki_gcas as (
    select 
        syasyu::varchar(4) as syasyu,
        db::varchar(8) as db,
        hansiyono8::varchar(8) as hansiyono8,
        hinmoku::varchar(4) as hinmoku,
        syurui::varchar(2) as syurui,
        jyokenno::varchar(4) as jyokenno,
        seisanjk1keta::varchar(3) as seisanjk1keta,
        seisanjk1val::varchar(1) as seisanjk1val,
        seisanjk2keta::varchar(3) as seisanjk2keta,
        seisanjk2val::varchar(1) as seisanjk2val,
        hankatajk1ud::varchar(1) as hankatajk1ud,
        hankatajk1keta::varchar(1) as hankatajk1keta,
        hankatajk1val::varchar(1) as hankatajk1val,
        hankatajk2ud::varchar(1) as hankatajk2ud,
        hankatajk2val::varchar(10) as hankatajk2val,
        framejkkara::varchar(7) as framejkkara,
        framejkmade::varchar(7) as framejkmade,
        mttime::varchar(16) as mttime,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_ogg_gcas','raw_cyyg9hinmokuhiki') }}
    where _fivetran_deleted = 'false'
)
select * from stg_hinmokuhiki_gcas
