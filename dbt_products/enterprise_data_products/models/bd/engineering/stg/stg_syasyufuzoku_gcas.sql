{{
    config (
        materialized = 'incremental',
        unique_key = ['syasyu', 'hansiyono8', 'hankata'],
        incremental_strategy = 'merge',
        pre_hook ="
            {% if is_incremental() %}
                delete from {{ this }} stg
                using 
                  {{ source('fivetran_database_ogg_gcas','raw_cyyg9syasyufuzoku') }} raw
                   where 
                    stg.syasyu = raw.syasyu
                    and stg.hansiyono8 = raw.hansiyono8
                    and stg.hankata = raw.hankata
                    and raw._fivetran_deleted = 'true'
            {% endif %}
        "
    )
}}
--pre_hookによる不要データ削除処理を実装
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

    {% if is_incremental() %}
        and _fivetran_synced > (select max(ldts) from {{ this }})
    {% endif %}

)
select * from stg_syasyufuzoku_gcas
