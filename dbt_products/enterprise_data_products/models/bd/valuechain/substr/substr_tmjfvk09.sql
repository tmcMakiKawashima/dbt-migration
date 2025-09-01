with substr_tmjfvk09 as (
    select
        substr(raw_data, 1, 15)::varchar(15) as hinban,
        substr(raw_data, 16, 4)::varchar(4) as syusbetu,
        substr(raw_data, 20, 15)::varchar(15) as seppenjun,
        substr(raw_data, 35, 5)::varchar(5) as kerekijun,
        substr(raw_data, 40, 8)::varchar(8) as kara,
        substr(raw_data, 48, 8)::varchar(8) as made,
        substr(raw_data, 56, 8)::varchar(8) as motomade,
        substr(raw_data, 64, 18)::varchar(18) as seppen,
        substr(raw_data, 82, 2)::varchar(2) as hokyukbn,
        substr(raw_data, 84, 1)::varchar(1) as gokbn,
        substr(raw_data, 85, 1)::varchar(1) as hokyumukoflg,
        substr(raw_data, 86, 5)::varchar(5) as kosincompid,
        substr(raw_data, 91, 10)::varchar(10) as kosinuserid,
        substr(raw_data, 101, 16)::varchar(16) as kosintime,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_tmjfvk09') }}
)
select * from substr_tmjfvk09