with substr_ktrla024zz0ka218 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mtkbn,
        substr(raw_data, 2, 4)::varchar(4) as syasyu,
        substr(raw_data, 6, 3)::varchar(3) as siyoudai5,
        substr(raw_data, 9, 2)::varchar(2) as siyousai5,
        substr(raw_data, 11, 3)::varchar(3) as siyoudai4,
        substr(raw_data, 14, 1)::varchar(1) as siyousai4,
        substr(raw_data, 15, 3)::varchar(3) as s1keta,
        substr(raw_data, 18, 1)::varchar(1) as s1kigo,
        substr(raw_data, 19, 3)::varchar(3) as s2keta,
        substr(raw_data, 22, 1)::varchar(1) as s2kigo,
        substr(raw_data, 23, 3)::varchar(3) as s3keta,
        substr(raw_data, 26, 1)::varchar(1) as s3kigo,
        substr(raw_data, 27, 20)::varchar(20) as ctlkata,
        substr(raw_data, 47, 1)::varchar(1) as tokukbn,
        substr(raw_data, 48, 9)::varchar(9) as sijikara,
        substr(raw_data, 57, 3)::varchar(3) as tutisyokara,
        substr(raw_data, 60, 2)::varchar(2) as tutisufkara,
        substr(raw_data, 62, 3)::varchar(3) as tutisyomade,
        substr(raw_data, 65, 2)::varchar(2) as tutisufmade,
        substr(raw_data, 67, 8)::varchar(8) as tekikara,
        substr(raw_data, 75, 8)::varchar(8) as tekimade,
        substr(raw_data, 83, 14)::varchar(14) as mtdate,
        line_number,
        ldts
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla024zz0ka218')}}
)
select * from substr_ktrla024zz0ka218