with substr_ktrla01dzz0kalc016 as (
    select
        substr(raw_data, 3, 2)::varchar(2) as shamei,
        substr(raw_data, 1, 2)::varchar(2) as sno,
        substr(raw_data, 5, 7)::varchar(7) as kncode,
        substr(raw_data, 12, 1)::varchar(1) as odt,
        substr(raw_data, 13, 1)::varchar(1) as nisgta,
        substr(raw_data, 14, 3)::varchar(3) as smka,
        substr(raw_data, 17, 20)::varchar(20) as ckataa,
        substr(raw_data, 37, 4)::varchar(4) as gaicda,
        substr(raw_data, 41, 4)::varchar(4) as ucda,
        substr(raw_data, 45, 80)::varchar(80) as sspeckkigo_area_g,
        substr(raw_data, 125, 1)::varchar(1) as nrknrflg,
        substr(raw_data, 126, 1)::varchar(1) as nrkensyoflg,
        substr(raw_data, 127, 8)::varchar(8) as creymd,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla01dzz0kalc016')}}
)
select * from substr_ktrla01dzz0kalc016