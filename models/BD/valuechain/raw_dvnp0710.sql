with raw_dvnp0710 as (
    select
        RAW_DATA,
        LDTS
    from {{ source('snowpipe_db_valuechain', 'KTRLA01VZZ0KVN00G4') }}
)
select * from raw_dvnp0710
