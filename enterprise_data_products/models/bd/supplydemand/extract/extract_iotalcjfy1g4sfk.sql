with extract_iotalcjfy1g4sfk as (
    select
       raw_data:sf_kind::numeric(1) as sf_kind,
       raw_data:sfkey::varchar(16) as sfkey,
       raw_data:modtype::varchar(2) as modtype,
       raw_data:ref_sfkey::varchar(16) as ref_sfkey,
       raw_data:parent_sfkey::varchar(16) as parent_sfkey,
       raw_data:family_sfkey::varchar(16) as family_sfkey,
       raw_data:modno::varchar(8) as modno,
       raw_data:idno::varchar(10) as idno,
       raw_data:bdno::varchar(5) as bdno,
       raw_data:fr_code::varchar(3) as fr_code,
       raw_data:fr_seq::varchar(7) as fr_seq,
       raw_data:urn::varchar(10) as urn,
       raw_data:carrierno::varchar(10) as carrierno,
       raw_data:vinno::varchar(17) as vinno,
       raw_data:mod_serial_no::varchar(30) as mod_serial_no,
       raw_data:__created_at::timestamp_ntz(6) as __created_at,
       raw_data:__updated_at::timestamp_ntz(6) as __updated_at,
       ldts,
       line_number
     from
        {{ source('snowpipe_db_supplydemand', 'raw_iotalcjfy1g4sfk') }}
    )
select * from extract_iotalcjfy1g4sfk