{{ config(snowflake_warehouse='DBT_WH') }}

with replace_tbnokjs as (
    select
        replace(raw_data, '／', '  ') as raw_data,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_tbnokjs') }}
)
select * from replace_tbnokjs
