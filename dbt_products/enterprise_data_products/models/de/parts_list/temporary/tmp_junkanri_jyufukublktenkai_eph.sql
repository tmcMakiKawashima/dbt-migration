{{ 
    config(materialized = 'ephemeral') 
}}
-- 循環処理のためE層のテーブルをソースとして扱う
with tmp_junkanri_jyufukublktenkai_eph as (
    select * from {{source('parts_list_db_public', 'raw_tmp_junkanri_jyufukublktenkai')}}
)
select * from tmp_junkanri_jyufukublktenkai_eph