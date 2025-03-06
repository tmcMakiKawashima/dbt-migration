with substr_ktrla05azz0kvw0004 as (
    select
        substr(raw_data, 1, 6)::varchar(6) as cd_pubbnd,
        substr(raw_data, 7, 100)::varchar(100) as mj_opt1_str,
        substr(raw_data, 107, 100)::varchar(100) as mj_opt2_str,
        substr(raw_data, 207, 100)::varchar(100) as mj_opt3_str,
        substr(raw_data, 307, 100)::varchar(100) as mj_opt4_str,
        substr(raw_data, 407, 100)::varchar(100) as mj_opt5_str,
        ldts,
        line_number
    from {{source('snowpipe_db_customerservice', 'raw_ktrla05azz0kvw0004')}}
)
select * from substr_ktrla05azz0kvw0004