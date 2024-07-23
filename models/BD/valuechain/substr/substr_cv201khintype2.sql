with substr_cv201khintype2 as (
    select
        substr(file_row_data, 1, 1)::varchar(1) as mntkbn,
        substr(file_row_data, 2, 3)::varchar(3) as langkbn,
        substr(file_row_data, 5, 6)::varchar(6) as ctlgcd,
        substr(file_row_data, 11, 6)::varchar(6) as hinmeicd,
        substr(file_row_data, 17, 4)::varchar(4) as syasyu_cd,
        substr(file_row_data, 21, 12)::varchar(12) as hinban,
        substr(file_row_data, 33, 2)::varchar(2) as kosu,
        substr(file_row_data, 35, 6)::varchar(6) as jissijikik,
        substr(file_row_data, 41, 6)::varchar(6) as jissijikim,
        substr(file_row_data, 47, 4)::varchar(4) as siyoptno,
        substr(file_row_data, 51, 6)::varchar(6) as epckataptno,
        substr(file_row_data, 57, 4)::varchar(4) as kiricdk,
        substr(file_row_data, 61, 4)::varchar(4) as kiricdm,
        substr(file_row_data, 65, 64)::varchar(64) as trmcdmlt,
        substr(file_row_data, 129, 75)::varchar(75) as clrcdmlt,
        substr(file_row_data, 204, 1)::varchar(1) as tkstkbn,
        substr(file_row_data, 205, 1)::varchar(1) as  hktkgaikbn,
        substr(file_row_data, 206, 12)::varchar(12) as hosemhin,
        substr(file_row_data, 218, 1)::varchar(1) as srcflg,
        substr(file_row_data, 219, 2048)::varchar(2048) as tkkatahgn,
        substr(file_row_data, 2267, 8192)::varchar(8192) as biko,
        ldts
    from {{source('snowpipe_db_valuechain', 'raw_epc_fixlen_cv201khintype2')}}
)
select * from substr_cv201khintype2