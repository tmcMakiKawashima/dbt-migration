with substr_ktrla05azz0kvw0006 as (
    select
        substr(raw_data, 1, 6)::varchar(6) as cd_pubbnd,
        substr(raw_data, 7, 5)::varchar(5) as "cd_model_nm",
        substr(raw_data, 12, 6)::varchar(6) as cd_vtype,
        substr(raw_data, 18, 6)::varchar(6) as dd_pubbnd_trmfrym,
        substr(raw_data, 24, 20)::varchar(20) as "cd_fll_mdl",
        ldts,
        line_number
    from {{source('snowpipe_db_customerservice', 'raw_ktrla05azz0kvw0006')}}
)
select * from substr_ktrla05azz0kvw0006