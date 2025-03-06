with substr_ktrla05azz0kvw0007 as (
    select
        substr(raw_data, 1, 6)::varchar(6) as cd_pubbnd,
        ldts,
        line_number
    from {{source('snowpipe_db_customerservice', 'raw_ktrla05azz0kvw0007')}}
)
select * from substr_ktrla05azz0kvw0007