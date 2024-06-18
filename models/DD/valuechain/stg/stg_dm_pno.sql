{{ config(snowflake_warehouse='DBT_WH') }}

with stg_dm_pno as (
    select * from {{ source('dx0yui_db_public', 'raw_dm_pno') }}
    --他の結合処理(YUI)で保証されたデータかつ全件取得するマスタデータはデータ品質レイヤ(raw_)を不要とする
)

select * from stg_dm_pno
