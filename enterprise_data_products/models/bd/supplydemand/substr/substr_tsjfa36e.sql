with substr_tsjfa36e as (
    select
        substr(raw_data, 152, 2)::varchar(2) as shamei,
        substr(raw_data, 154, 2)::varchar(2) as sno,
        substr(raw_data, 131, 5)::varchar(5) as dfsc,
        substr(raw_data, 157, 20)::varchar(20) as hkata,
        substr(raw_data, 177, 4)::varchar(4) as gaicd,
        substr(raw_data, 181, 4)::varchar(4) as ucd,
        substr(raw_data, 185, 3)::varchar(3) as tire,
        substr(raw_data, 268, 80)::varchar(80) as hoption,
        substr(raw_data, 348, 5)::varchar(5) as katacd,
        substr(raw_data, 353, 20)::varchar(20) as bkata,
        substr(raw_data, 373, 16)::varchar(16) as ckata,
        substr(raw_data, 389, 1)::varchar(1) as tecs,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_tsjfa36e')}}
)
select * from substr_tsjfa36e