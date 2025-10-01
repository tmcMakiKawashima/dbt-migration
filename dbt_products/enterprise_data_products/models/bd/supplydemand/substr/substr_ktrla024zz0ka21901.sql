with substr_ktrla024zz0ka21901 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mtkbn,
        substr(raw_data, 2, 4)::varchar(4) as syasyu,
        substr(raw_data, 6, 2)::varchar(2) as sno,
        substr(raw_data, 8, 1)::varchar(1) as jidokbn,
        substr(raw_data, 9, 1)::varchar(1) as sktire,
        substr(raw_data, 10, 1)::varchar(1) as skdoitu,
        substr(raw_data, 11, 1)::varchar(1) as tokusyu,
        substr(raw_data, 12, 1)::varchar(1) as syflg,
        substr(raw_data, 13, 4)::varchar(4) as maesyasyu,
        substr(raw_data, 17, 3)::varchar(3) as tutisyo,
        substr(raw_data, 20, 2)::varchar(2) as tutisuf,
        substr(raw_data, 22, 1)::varchar(1) as lang,
        substr(raw_data, 23, 1)::varchar(1) as lang2,
        substr(raw_data, 24, 14)::varchar(14) as mtdate,
        line_number,
        ldts
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla024zz0ka21901')}}
)
select * from substr_ktrla024zz0ka21901