with
    byte_ktrla038zz0kadda01 as (
        select
            to_binary(raw_data, 'utf-8') as raw_data,
            ldts,
            line_number
        from {{ source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadda01') }}
    )
select * from byte_ktrla038zz0kadda01
