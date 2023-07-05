with raw_DVNP0700 as (
    select
        RAW_DATA,
        LDTS
    from {{ source('snowpipe_db_valuechain', 'KTRLA01VZZ0KVN00G6') }}
)
select * from raw_DVNP0700
