{{
    config(
        materialized='table'
    )
}}
-- 処理レスポンスを考慮しtable実装
select * from {{ref('tmp05_dm_kousei_jyufukublktenkai')}} as zk1
union
select * from {{ref('tmp07_dm_kousei_jyufukublktenkai')}} as zk2