with substr_dv2a5404 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 7)::varchar(7) as frmnokata,
        substr(raw_data, 9, 7)::varchar(7) as frmno,
        substr(raw_data, 16, 1)::varchar(1) as mdlyearkbn,
        substr(raw_data, 17, 17)::varchar(17) as vin,
        substr(raw_data, 34, 4)::varchar(4) as nen,
        substr(raw_data, 38, 2)::varchar(2) as tuki,
        substr(raw_data, 40, 3)::varchar(3) as clrcd,
        substr(raw_data, 43, 4)::varchar(4) as trmcd,
        substr(raw_data, 47, 4)::varchar(4) as syasyu_cd,
        substr(raw_data, 51, 4)::varchar(4) as siyoptno,
        substr(raw_data, 55, 1)::varchar(1) as tkstkbn,
        substr(raw_data, 56, 20)::varchar(20) as syakata,
        substr(raw_data, 76, 20)::varchar(20) as hanbai_kt,
        substr(raw_data, 96, 7)::varchar(7) as eng_type,
        substr(raw_data, 103, 6)::varchar(6) as transkata,
        substr(raw_data, 109, 3)::varchar(3) as rdf_type,
        ldts
    from {{source('snowpipe_db_valuechain', 'raw_dv2a5404')}}
)
select * from substr_dv2a5404