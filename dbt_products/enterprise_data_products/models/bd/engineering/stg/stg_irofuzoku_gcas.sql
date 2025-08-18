{{
    config (
        materialized = 'incremental',
        unique_key = ['naigaikbn', 'clrno', 'syasyu'],
        incremental_strategy = 'merge',
        pre_hook ="
            {% if is_incremental() %}
                delete from {{ this }} stg
                using 
                  {{ source('fivetran_database_ogg_gcas','raw_cyyg9irofuzoku') }} raw
                   where 
                    stg.naigaikbn = raw.naigaikbn
                    and stg.clrno = raw.clrno
                    and stg.syasyu = raw.syasyu
                    and raw._fivetran_deleted = 'true'
            {% endif %}
        "
    )
}}
--pre_hookによる不要データ削除処理を実装
with stg_irofuzoku_gcas as (
    select 
        naigaikbn::varchar(1) as naigaikbn,
        clrno::varchar(5) as clrno,
        syasyu::varchar(4) as syasyu,
        clrmei::varchar(50) as clrmei,
        mttime::varchar(16) as mttime,
        _fivetran_synced::timestamp_ntz as ldts
    from {{ source('fivetran_database_ogg_gcas','raw_cyyg9irofuzoku') }}
    where _fivetran_deleted = 'false'

    {% if is_incremental() %}
        and _fivetran_synced > (select max(ldts) from {{ this }})
    {% endif %}

)
select * from stg_irofuzoku_gcas
