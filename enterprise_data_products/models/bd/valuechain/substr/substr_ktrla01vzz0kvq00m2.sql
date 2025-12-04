with substr_ktrla01vzz0kvq00m2 as (
    select
        substr(raw_data, 1, 20)::varchar(20) as hinban,
        substr(raw_data, 21, 8)::varchar(8) as tekiyokaisiymd,
        substr(raw_data, 29, 8)::varchar(8) as tekiyosyuryoymd,
        substr(raw_data, 37, 3)::varchar(3) as oprccls,
        substr(raw_data, 40, 8)::varchar(8) as hnkkihonfob,
        substr(raw_data, 48, 1)::varchar(1) as sagyoriyucd,
        substr(raw_data, 49, 2)::varchar(2) as henkoriyucd,
        substr(raw_data, 51, 3)::varchar(3) as seisankyoku,
        substr(raw_data, 54, 3)::varchar(3) as hanbaiktrtry,
        substr(raw_data, 57, 16)::varchar(16) as mtuserid,
        substr(raw_data, 73, 26)::varchar(26) as mttime,
        substr(raw_data, 99, 2)::varchar(2) as filler,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvq00m2')}}
)
select * from substr_ktrla01vzz0kvq00m2