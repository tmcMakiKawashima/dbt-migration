{{ config(
      materialized='incremental',
      unique_key = ['dlrcd', 'cuno', 'edano', 'ym', 'nykt', 'tkcd'],
      incremental_strategy = 'merge'
   ) }}

with stg_yohinmeisai as (
    select
        mntkbn::varchar(1) as mntkbn, -- なし
        dlrcd::varchar(5) as dlrcd, -- なし
        rtrim(cuno, ' 　')::varchar(12) as cuno, -- 右ブランク
        edano::varchar(2) as edano, -- なし
        to_varchar(ym)::varchar(6) as ym,-- なし
        to_varchar(nykt)::varchar(1) as nykt,-- なし
        rtrim(tkcd, ' 　')::varchar(6) as tkcd,-- 右ブランク
        tkmeikbn::varchar(1) as tkmeikbn,-- なし
        kosuu::number(2) as kosuu,-- なし
        rtrim(tkname, ' 　')::varchar(60) as tkname,-- 右ブランク
        _fivetran_synced::timestamp_ntz as ldts,
        rank() over (partition by dlrcd, cuno, edano, ym, nykt, tkcd order by ldts desc) aggkey
    from {{ source('fivetran_database_marketing', 'raw_ktrla07vzz0kiw0004') }}
           {% if is_incremental() %}
               where ldts > (select max(ldts) from {{this}})
           {% endif %}
)
select * exclude(aggkey) from stg_yohinmeisai
where aggkey = 1