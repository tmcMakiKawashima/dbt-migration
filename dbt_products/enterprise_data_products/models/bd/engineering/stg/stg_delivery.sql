with stg_delivery as (
    select
        delivery_id::number(10,0) as delivery_id,
        material_id::number(10,0) as material_id,
        lot_no::varchar(50) as lot_no,
        lot_year::number(10,0) as lot_year,
        manufactured_date::timestamp_ntz(6) as manufactured_date,
        created_at::timestamp_ntz(6) as created_at,
        updated_at::timestamp_ntz(6) as updated_at,
        ldts,
        row_number() over(partition by delivery_id order by updated_at desc, line_number desc) aggkey
    from {{source('snowpipe_db_engineering', 'raw_lotot_delivery_t') }}
)
select * exclude(aggkey) from stg_delivery
where aggkey = 1 