{{ 
    config(materialized='ephemeral') 
}}
-- 循環処理のためE層のテーブルをソースとして扱う

with tmp_hinban_eph as (
    select * from {{ source('engineering_db_public', 'raw_stg_hinban') }}
)

select * from tmp_hinban_eph