with substr_dv2a38b4 as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 6)::varchar(6) as ctlgcd,
        substr(raw_data, 8, 4)::varchar(4) as syasyu_cd,
        substr(raw_data, 12, 12)::varchar(12) as hinban,
        substr(raw_data, 24, 2)::varchar(2) as trmcd,
        substr(raw_data, 26, 4)::varchar(4) as figno,
        ldts
    from {{source('snowpipe_db_valuechain', 'raw_dv2a38b4')}}
)
select * from substr_dv2a38b4