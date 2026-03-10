with extract_iotalcjfy1g4ctr as (
    select
        raw_data:sfkey::varchar(16) as sfkey,
        raw_data:file_date::varchar(30) as file_date,
        raw_data:timezone::varchar(16777216) as timezone,
        raw_data:alc_ver::varchar(16777216) as alc_ver,
        raw_data:db_reg_date::varchar(30) as db_reg_date,
        raw_data:db_upd_date::varchar(30) as db_upd_date,
        raw_data:__created_at::varchar(30) as __created_at,
        raw_data:__updated_at::varchar(30) as __updated_at,
        ldts,
        line_number
    from
        {{ source('snowpipe_db_supplydemand', 'raw_iotalcjfy1g4ctr') }}
    )
select * from extract_iotalcjfy1g4ctr