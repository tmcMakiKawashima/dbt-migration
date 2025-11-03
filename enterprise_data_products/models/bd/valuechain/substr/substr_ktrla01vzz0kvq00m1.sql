with substr_ktrla01vzz0kvq00m1 as (
    select
        substr(raw_data, 1, 20)::varchar(20) as hinban,
        substr(raw_data, 21, 1)::varchar(1) as hinbansikicd,
        substr(raw_data, 22, 2)::varchar(2) as knisyohincd,
        substr(raw_data, 24, 2)::varchar(2) as kgisyohincd,
        substr(raw_data, 26, 4)::varchar(4) as hinmkcd,
        substr(raw_data, 30, 6)::varchar(6) as zissijiki,
        substr(raw_data, 36, 20)::varchar(20) as siryomeihanka,
        substr(raw_data, 56, 40)::varchar(40) as hnmeiassep,
        substr(raw_data, 96, 1)::varchar(1) as syuyohinmokukbn,
        substr(raw_data, 97, 4)::varchar(4) as sagyokancd,
        substr(raw_data, 101, 8)::varchar(8) as syokaistiymd,
        substr(raw_data, 109, 2)::varchar(2) as hsstihohocd,
        substr(raw_data, 111, 1)::varchar(1) as zidosticd,
        substr(raw_data, 112, 2)::varchar(2) as kgikyutaiocd,
        substr(raw_data, 114, 14)::varchar(14) as zaisitu,
        substr(raw_data, 128, 8)::varchar(8) as itaatugpn,
        substr(raw_data, 136, 9)::varchar(9) as smsjuryo,
        substr(raw_data, 145, 20)::varchar(20) as hikakuhinban,
        substr(raw_data, 165, 1)::varchar(1) as zumenumu,
        substr(raw_data, 166, 12)::varchar(12) as oyazuban,
        substr(raw_data, 178, 68)::varchar(68) as pristiyoso,
        substr(raw_data, 246, 1)::varchar(1) as zeikbn,
        substr(raw_data, 247, 16)::varchar(16) as mtuserid,
        substr(raw_data, 263, 26)::varchar(26) as mttime,
        substr(raw_data, 289, 12)::varchar(12) as filler,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvq00m1')}}
)
select * from substr_ktrla01vzz0kvq00m1