with substr_tmjfvk10 as (
    select
        substr(raw_data, 1, 15)::varchar(15) as daiohin,
        substr(raw_data, 16, 4)::varchar(4) as syusbetu,
        substr(raw_data, 20, 15)::varchar(15) as seppenjun,
        substr(raw_data, 35, 15)::varchar(15) as dainhin,
        substr(raw_data, 50, 5)::varchar(5) as kerekijun,
        substr(raw_data, 55, 8)::varchar(8) as kara,
        substr(raw_data, 63, 8)::varchar(8) as made,
        substr(raw_data, 71, 8)::varchar(8) as motomade,
        substr(raw_data, 79, 2)::varchar(2) as daitype,
        substr(raw_data, 81, 2)::varchar(2) as daikbn,
        substr(raw_data, 83, 2)::varchar(2) as daikosu,
        substr(raw_data, 85, 30)::varchar(30) as daicom,
        substr(raw_data, 115, 15)::varchar(15) as mainhin,
        substr(raw_data, 130, 2)::varchar(2) as setm,
        substr(raw_data, 132, 2)::varchar(2) as sentakukbn,
        substr(raw_data, 134, 18)::varchar(18) as seppen,
        substr(raw_data, 152, 18)::varchar(18) as kosinseppen,
        substr(raw_data, 170, 1)::varchar(1) as hokyumukoflg,
        substr(raw_data, 171, 5)::varchar(5) as kosincompid,
        substr(raw_data, 176, 10)::varchar(10) as kosinuserid,
        substr(raw_data, 186, 16)::varchar(16) as kosintime,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_tmjfvk10') }}
)
select * from substr_tmjfvk10