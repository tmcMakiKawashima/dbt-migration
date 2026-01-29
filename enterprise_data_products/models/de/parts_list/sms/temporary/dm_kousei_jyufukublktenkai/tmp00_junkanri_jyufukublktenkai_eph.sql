{{ 
    config(materialized = 'ephemeral') 
}}
-- 循環処理のためE層のテーブルをソースとして扱う
with raw_tmp00_junkanri_jyufukublktenkai as (
    select * from {{source('parts_list_db_sms', 'raw_tmp00_junkanri_jyufukublktenkai')}}
)
select * from raw_tmp00_junkanri_jyufukublktenkai