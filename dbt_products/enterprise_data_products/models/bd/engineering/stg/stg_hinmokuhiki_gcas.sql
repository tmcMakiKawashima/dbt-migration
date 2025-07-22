{{
    config (
        materialized = 'incremental',
        unique_key = ['syasyu', 'db', 'hansiyono8','hinmoku','syurui','jyokenno'],
        incremental_strategy = 'merge',
        pre_hook ="
            {% if is_incremental() %}
                delete from {{ this }} stg
                using 
                  {{ source('fivetran_database_ogg_gcas','raw_cyyg9hinmokuhiki') }} raw
                   where 
                    stg.syasyu = raw.syasyu
                    and stg.db = raw.db
                    and stg.hansiyono8 = raw.hansiyono8
                    and stg.hinmoku = raw.hinmoku
                    and stg.syurui = raw.syurui
                    and stg.jyokenno = raw.jyokenno
                    and raw._fivetran_deleted = 'true'
                    and raw._fivetran_synced > (select max(ldts) from {{ this }})
            {% endif %}
        "
    )
}}
--pre_hookによる不要データ削除処理を実装
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

    {% if is_incremental() %}
        and _fivetran_synced > (select max(ldts) from {{ this }})
    {% endif %}

)
select * from stg_hinmokuhiki_gcas