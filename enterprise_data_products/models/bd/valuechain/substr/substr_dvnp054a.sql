{{ config(snowflake_warehouse='DBT_WH') }}

with substr_dvnp054a as (
  select
    substr(raw_data, 1, 7)::VARCHAR(7) as DLRCD,
    substr(raw_data, 8, 10)::VARCHAR(10) as SMKMEIJPJH,
    substr(raw_data, 18, 10)::VARCHAR(10) as SMKMEIJPJS,
    substr(raw_data, 28, 20)::VARCHAR(20) as SMKMEIKJH,
    substr(raw_data, 48, 20)::VARCHAR(20) as SMKMEIKJS,
    substr(raw_data, 68, 10)::VARCHAR(10) as JUSYO1JP,
    substr(raw_data, 78, 10)::VARCHAR(10) as JUSYO2JP,
    substr(raw_data, 88, 10)::VARCHAR(10) as JUSYO3JP,
    substr(raw_data, 98, 10)::VARCHAR(10) as JUSYO4JP,
    substr(raw_data, 108, 16)::VARCHAR(16) as MTUSERID,
    substr(raw_data, 124, 26)::VARCHAR(26) as MTTIME,
    substr(raw_data, 150, 9)::VARCHAR(9) as DUMMY,
    LDTS
  from {{source('snowpipe_db_valuechain', 'raw_dvnp054a')}}
)
select * from substr_dvnp054a
