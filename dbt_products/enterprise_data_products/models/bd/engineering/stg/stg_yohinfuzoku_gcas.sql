{{
    config (
        materialized = 'incremental',
        unique_key = ['syasyu', 'tuikocd', 'syameino','edaban','fuzokukbn'],
        incremental_strategy = 'merge',
        pre_hook ="
            {% if is_incremental() %}
                delete from {{ this }} stg
                using 
                  {{ source('fivetran_database_ogg_gcas','raw_cyyg9yohinfuzoku') }} raw
                   where 
                    stg.syasyu = raw.syasyu
                    and stg.tuikocd = raw.tuikocd
                    and stg.syameino = raw.syameino
                    and stg.edaban = raw.edaban
                    and stg.fuzokukbn = raw.fuzokukbn
                    and raw._fivetran_deleted = 'true'
                    and raw._fivetran_synced > (select max(ldts) from {{ this }})
            {% endif %}
        "
    )
}}
--pre_hookによる不要データ削除処理を実装
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

    {% if is_incremental() %}
        and _fivetran_synced > (select max(ldts) from {{ this }})
    {% endif %}

)
select * from stg_yohinfuzoku_gcas