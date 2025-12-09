with subtsr_tsjfa36h as (
    select
        substr(raw_data, 1, 2)::varchar(2) as shamei,
        substr(raw_data, 3, 2)::varchar(2) as sno,
        substr(raw_data, 5, 5)::varchar(5) as hknisu,
        substr(raw_data, 10, 6)::varchar(6) as hksa,
        substr(raw_data, 16, 3)::varchar(3) as yrnisu,
        substr(raw_data, 19, 8)::varchar(8) as yrdaisu,
        substr(raw_data, 27, 3)::varchar(3) as tare,
        substr(raw_data, 30, 8)::varchar(8) as saisou,
        substr(raw_data, 38, 8)::varchar(8) as saiti,
        substr(raw_data, 46, 5)::varchar(5) as codai,
        substr(raw_data, 51, 5)::varchar(5) as yoyu,
        substr(raw_data, 56, 5)::varchar(5) as kari,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_tsjfa36h')}}
)
select * from subtsr_tsjfa36h