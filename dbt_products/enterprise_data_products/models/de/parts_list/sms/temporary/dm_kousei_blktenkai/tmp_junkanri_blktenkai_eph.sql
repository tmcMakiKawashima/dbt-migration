{{ 
    config(materialized='ephemeral') 
}}
-- 循環処理のためE層のテーブルをソースとして扱う

with tmp_junkanri_blktenkai_eph as (
    select * from {{ source('parts_list_db_sms', 'raw_tmp_junkanri_blktenkai') }}
)

select * from tmp_junkanri_blktenkai_eph