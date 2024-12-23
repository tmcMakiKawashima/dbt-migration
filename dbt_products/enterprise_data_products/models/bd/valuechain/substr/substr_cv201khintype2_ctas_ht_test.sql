with substr_cv201khintype2_ctas_ht_test as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 3)::varchar(3) as langkbn,
        substr(raw_data, 5, 6)::varchar(6) as ctlgcd,
        substr(raw_data, 11, 6)::varchar(6) as hinmeicd,
        substr(raw_data, 17, 4)::varchar(4) as syasyu_cd,
        substr(raw_data, 21, 12)::varchar(12) as hinban,
        substr(raw_data, 33, 2)::varchar(2) as kosu,
        substr(raw_data, 35, 6)::varchar(6) as jissijikik,
        substr(raw_data, 41, 6)::varchar(6) as jissijikim,
        substr(raw_data, 47, 4)::varchar(4) as siyoptno,
        substr(raw_data, 51, 6)::varchar(6) as epckataptno,
        substr(raw_data, 57, 4)::varchar(4) as kiricdk,
        substr(raw_data, 61, 4)::varchar(4) as kiricdm,
        substr(raw_data, 65, 64)::varchar(64) as trmcdmlt,
        substr(raw_data, 129, 75)::varchar(75) as clrcdmlt,
        substr(raw_data, 204, 1)::varchar(1) as tkstkbn,
        substr(raw_data, 205, 1)::varchar(1) as hktkgaikbn,
        substr(raw_data, 206, 12)::varchar(12) as hosemhin,
        substr(raw_data, 218, 1)::varchar(1) as srcflg,
        substr(raw_data, 219, 2048)::varchar(2048) as tkkatahgn,
        substr(raw_data, 2267, 8192)::varchar(8192) as biko,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_cv201khintype2')}}
)
select * from substr_cv201khintype2_ctas_ht_test