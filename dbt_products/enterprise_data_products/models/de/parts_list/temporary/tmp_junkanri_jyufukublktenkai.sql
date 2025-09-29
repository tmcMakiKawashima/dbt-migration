{{
    config(
        materialized = 'incremental',
        incremental_strategy = 'append',
        transient = false,
        pre_hook = "
            {% if is_incremental() %}
              delete from {{this}} a
              using {{ref('tmp08_dm_kousei_jyufukublktenkai')}} b
              where a.syasyu = b.syasyu 
            {% endif %}
        "
    )
}}
-- 車種単位で洗い替えする必要がある為、pre_hookで削除を行う。
select distinct
    syasyu,
    target,
    torokujun,
    seppenno,
    maxmttime,
    mttime
from {{ref('tmp08_dm_kousei_jyufukublktenkai')}}