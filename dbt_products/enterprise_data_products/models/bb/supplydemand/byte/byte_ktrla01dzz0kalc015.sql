with byte_ktrla01dzz0kalc015 as (
    select
      to_binary(raw_data, 'utf-8') as raw_data,
      ldts,
      line_number
    from {{ source('snowpipe_db_supplydemand', 'raw_ktrla01dzz0kalc015') }}
)
select * from byte_ktrla01dzz0kalc015
