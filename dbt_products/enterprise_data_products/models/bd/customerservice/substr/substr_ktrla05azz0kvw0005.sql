with substr_ktrla05azz0kvw0005 as (
    select
        substr(raw_data, 1, 6)::varchar(6) as cd_pubbnd,
        substr(raw_data, 7, 6)::varchar(6) as dd_pubbnd_trmfrym,
        substr(raw_data, 13, 4)::varchar(4) as dd_mdly,
        ldts,
        line_number
    from {{source('snowpipe_db_customerservice', 'raw_ktrla05azz0kvw0005')}}
)
select * from substr_ktrla05azz0kvw0005