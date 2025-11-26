with substr_tmjfvk05 as (
    select
        substr(raw_data, 1, 15)::varchar(15) as hinban,
        substr(raw_data, 16, 3)::varchar(3) as seisankyoku,
        substr(raw_data, 19, 6)::varchar(6) as hosyubas,
        substr(raw_data, 25, 5)::varchar(5) as hantiiki,
        substr(raw_data, 30, 4)::varchar(4) as syusbetu,
        substr(raw_data, 34, 15)::varchar(15) as seppenjun,
        substr(raw_data, 49, 7)::varchar(7) as orderjtai1,
        substr(raw_data, 56, 7)::varchar(7) as orderjtai2,
        substr(raw_data, 63, 7)::varchar(7) as orderjtai3,
        substr(raw_data, 70, 7)::varchar(7) as orderjtai4,
        substr(raw_data, 77, 7)::varchar(7) as orderjtai5,
        substr(raw_data, 84, 8)::varchar(8) as kara,
        substr(raw_data, 92, 8)::varchar(8) as made,
        substr(raw_data, 100, 8)::varchar(8) as motomade,
        substr(raw_data, 108, 18)::varchar(18) as seppen,
        substr(raw_data, 126, 1)::varchar(1) as hokyuyouhi,
        substr(raw_data, 127, 1)::varchar(1) as orderresetkbn,
        substr(raw_data, 128, 1)::varchar(1) as onkyoseihenko,
        substr(raw_data, 129, 1)::varchar(1) as dkjgenkbn,
        substr(raw_data, 130, 1)::varchar(1) as dkjgenumukbn,
        substr(raw_data, 131, 1)::varchar(1) as mukoflg,
        substr(raw_data, 132, 5)::varchar(5) as kosincompid,
        substr(raw_data, 137, 10)::varchar(10) as kosinuserid,
        substr(raw_data, 147, 16)::varchar(16) as kosintime,
        ldts,
        line_number
    from {{ source('snowpipe_db_valuechain', 'raw_tmjfvk05') }}
)
select * from substr_tmjfvk05