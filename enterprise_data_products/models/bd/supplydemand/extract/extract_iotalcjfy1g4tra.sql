with extract_iotalcjfy1g4tra as (
    select
        raw_data:data_id::varchar(19) as data_id, 
        raw_data:line::varchar(1) as line, 
        raw_data:sf_item_name::varchar(20) as sf_item_name, 
        raw_data:pro_tag_cd::varchar(12) as pro_tag_cd, 
        raw_data:pro_tag_name::varchar(50) as pro_tag_name, 
        raw_data:pro_key_cd::varchar(16) as pro_key_cd, 
        raw_data:pro_serial_cd::varchar(30) as pro_serial_cd, 
        raw_data:trace_tag_cd::varchar(12) as trace_tag_cd, 
        raw_data:trace_tag_name::varchar(80) as trace_tag_name, 
        raw_data:tag_type::varchar(1) as tag_type, 
        raw_data:trace_key_cd::varchar(16) as trace_key_cd, 
        raw_data:value::varchar(1000) as value, 
        raw_data:unit::varchar(10) as unit,
        raw_data:org_date_time::varchar(30) as org_date_time, 
        raw_data:rec_date_time::varchar(30) as rec_date_time, 
        raw_data:expire_date::varchar(30) as expire_date, 
        raw_data:his_create_date::varchar(30) as his_create_date, 
        raw_data:__created_at::varchar(30) as __created_at, 
        raw_data:__updated_at::varchar(30) as __updated_at, 
        ldts,
        line_number
        from
            {{ source('snowpipe_db_supplydemand', 'raw_iotalcjfy1g4tra') }}
    )
select * from extract_iotalcjfy1g4tra