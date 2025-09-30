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
with tmp08_dm_kousei_jyufukublktenkai as (
select distinct
    syasyu, -- 車種コード
    target, -- ターゲット
    torokujun, -- 登録／生認順
    seppenno, -- 設変No.
    maxmttime, -- MAXMTTIME
    mttime -- MTTIME
from {{ref('tmp08_dm_kousei_jyufukublktenkai')}}
)
select * from tmp08_dm_kousei_jyufukublktenkai