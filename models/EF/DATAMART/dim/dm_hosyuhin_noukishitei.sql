{{ config(snowflake_warehouse='DBT_WH') }}

with dm_hosyuhin_noukishitei as (
    select * from {{ ref('tmp10_dm_hosyuhin_noukishitei') }}
)
select * from dm_hosyuhin_noukishitei