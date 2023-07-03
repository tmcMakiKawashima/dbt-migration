with raw_tbdaihl as (
    select
        RAW_DATA,
        LDTS
    from {{ source('snowpipe_db_valuechain', 'DXDAIH99') }}
)
select * from raw_tbdaihl
