{{ config(snowflake_warehouse='DBT_WH') }}

with substr_tbnsyus as (
    select
        replace(raw_data, '／', '  ') as raw_data,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_tbnsyus') }}    
)
select * from substr_tbnsyus