{{ config(snowflake_warehouse='DBT_WH') }}

with substr_cvn35dsyukabin as (
    select
        substr(raw_data, 1 ,7)::varchar(7) as dlrcd,
        substr(raw_data, 8, 2)::varchar(2) as syubetsu,
        substr(raw_data, 10, 1)::varchar(1) as yusokbn,
        substr(raw_data, 11, 1)::varchar(1) as syukkakyotenkbn,
        substr(raw_data, 12, 2)::varchar(2) as sykikicd,
        substr(raw_data, 14, 1)::varchar(1) as satflg,
        substr(raw_data, 15, 4)::varchar(4) as haisyahhmm,
        substr(raw_data, 19, 8)::varchar(8) as tekiyokaisiymd,
        substr(raw_data, 27, 8)::varchar(8) as tekiyosyuryoymd,
        substr(raw_data, 35, 1)::varchar(1) as keikanissu,
        substr(raw_data, 36, 4)::varchar(4) as totyakuhhmm,
        substr(raw_data, 40, 4)::varchar(4) as syukkasijihhmm,
        substr(raw_data, 44, 16)::varchar(16) as mtuserid,
        substr(raw_data, 60, 26)::varchar(26) as mttime,
        ldts
    from {{ source('snowpipe_db_valuechain', 'raw_cvn35dsyukabin')}}
)
select * from substr_cvn35dsyukabin