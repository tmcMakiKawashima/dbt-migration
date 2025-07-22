{{
    config (
        materialized = 'incremental',
        unique_key = ['syasyu', 'hansiyono8', 'jyokenno'],
        incremental_strategy = 'merge',
        pre_hook ="
            {% if is_incremental() %}
                delete from {{ this }} stg
                using 
                  {{ source('fivetran_database_ogg_gcas','raw_cyyg9syasyusiji') }} raw
                   where 
                    stg.syasyu = raw.syasyu
                    and stg.hansiyono8 = raw.hansiyono8
                    and stg.jyokenno = raw.jyokenno
                    and raw._fivetran_deleted = 'true'
                    and raw._fivetran_synced > (select max(ldts) from {{ this }})
            {% endif %}
        "
    )
}}
--pre_hookによる不要データ削除処理を実装
with stg_syasyusiji_gcas as (
    select 
        syasyu::varchar(4) as syasyu,
        hansiyono8::varchar(8) as hansiyono8,
        jyokenno::varchar(4) as jyokenno,
        seisan80::varchar(6) as seisan80,
        seisan100::varchar(1) as seisan100,
        hankatajk1ud::varchar(1) as hankatajk1ud,
        hankatajk1keta::varchar(1) as hankatajk1keta,
        hankatajk1val::varchar(1) as hankatajk1val,
        hankatajk2ud::varchar(1) as hankatajk2ud,
        hankatajk2val::varchar(1) as hankatajk2val,
        framejkkara::varchar(7) as framejkkara,
        framejkmade::varchar(7) as framejkmade,
        yusendo::varchar(2) as yusendo,
        syori::varchar(1) as syori,
        com::varchar(100) as com,
        mttime::varchar(16) as mttime,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_ogg_gcas','raw_cyyg9syasyusiji') }}
    where _fivetran_deleted = 'false'

    {% if is_incremental() %}
        and _fivetran_synced > (select max(ldts) from {{ this }})
    {% endif %}

)
select * from stg_syasyusiji_gcas