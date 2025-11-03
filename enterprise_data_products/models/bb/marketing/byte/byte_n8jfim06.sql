with byte_n8jfim06 as (
    select
      to_binary(raw_data, 'utf-8') as raw_data,
      ldts,
      line_number
    from {{ source('snowpipe_db_marketing', 'raw_n8jfim06') }}
)
select * from byte_n8jfim06
