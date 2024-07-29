{{ config(snowflake_warehouse='DBT_WH') }}

with substr_tbdaihl as (
    select
        substr(raw_data, 1, 5)::VARCHAR(5) as KYOUHAN,
        substr(raw_data, 6, 20)::VARCHAR(20) as HATUHINB,
        substr(raw_data, 26, 1)::VARCHAR(1) as HATUMKBN,
        substr(raw_data, 27, 5)::VARCHAR(5) as CHUMON,
        substr(raw_data, 32, 2)::VARCHAR(2) as ODERSYU,
        substr(raw_data, 34, 5)::VARCHAR(5) as USERCD,
        substr(raw_data, 39, 2)::VARCHAR(2) as KAISYA,
        substr(raw_data, 41, 14)::VARCHAR(14) as TCHUMON,
        substr(raw_data, 55, 8)::VARCHAR(8) as HATTYUHI,
        substr(raw_data, 63, 3)::VARCHAR(3) as FRMKBN,
        substr(raw_data, 66, 7)::VARCHAR(7) as FRMNO,
        substr(raw_data, 73, 20)::VARCHAR(20) as HANKATA,
        substr(raw_data, 93, 1)::VARCHAR(1) as "HATTYUSU-S",
        substr(raw_data, 94, 5)::VARCHAR(5) as HATTYUSU,
        substr(raw_data, 99, 1)::VARCHAR(1) as TORITOKB,
        substr(raw_data, 100, 20)::VARCHAR(20) as HINBAN,
        substr(raw_data, 120, 1)::VARCHAR(1) as MEKAKB,
        LDTS
    from {{ source('snowpipe_db_valuechain', 'raw_tbdaihl') }}
)
select * from substr_tbdaihl
