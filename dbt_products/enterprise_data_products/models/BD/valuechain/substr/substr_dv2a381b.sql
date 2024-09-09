with substr_dv2a381b as (
    select
        substr(raw_data, 1, 1)::varchar(1) as mntkbn,
        substr(raw_data, 2, 6)::varchar(6) as ctlgcd,
        substr(raw_data, 8, 6)::varchar(6) as hinmeicd,
        substr(raw_data, 14, 4)::varchar(4) as syasyu_cd,
        substr(raw_data, 18, 12)::varchar(12) as hinban,
        substr(raw_data, 30, 2)::varchar(2) as kosu,
        substr(raw_data, 32, 6)::varchar(6) as jissijikik,
        substr(raw_data, 38, 6)::varchar(6) as jissijikim,
        substr(raw_data, 44, 4)::varchar(4) as siyoptno,
        substr(raw_data, 48, 6)::varchar(6) as epckataptno,
        substr(raw_data, 54, 4)::varchar(4) as kiricdk,
        substr(raw_data, 58, 4)::varchar(4) as kiricdm,
        substr(raw_data, 62, 64)::varchar(64) as trmcdmlt,
        substr(raw_data, 126, 75)::varchar(75) as clrcdmlt,
        substr(raw_data, 201, 1)::varchar(1) as tkstkbn,
        substr(raw_data, 202, 1)::varchar(1) as hktkgaikbn,
        substr(raw_data, 203, 12)::varchar(12) as hosemhin,
        substr(raw_data, 215, 800)::varchar(800) as siyocdmlt,
        substr(raw_data, 1015, 1920)::varchar(1920) as katanomlt,
        ldts
    from {{source('snowpipe_db_valuechain', 'raw_dv2a381b')}}
)
select * from substr_dv2a381b