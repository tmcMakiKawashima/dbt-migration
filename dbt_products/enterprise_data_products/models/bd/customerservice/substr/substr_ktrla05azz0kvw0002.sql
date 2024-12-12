with substr_ktrla05azz0kvw0002 as (
    select
        substr(raw_data, 1, 17)::varchar(17) as no_vin_frameno,
        substr(raw_data, 18, 1)::varchar(1) as kb_frameno,
        substr(raw_data, 19, 20)::varchar(20) as "cd_fll_mdl",
        substr(raw_data, 39, 6)::varchar(6) as cd_pubbnd,
        substr(raw_data, 45, 5)::varchar(5) as "cd_model_nm",
        substr(raw_data, 50, 6)::varchar(6) as cd_vtype,
        substr(raw_data, 56, 6)::varchar(6) as dd_pubbnd_trmfrym,
        substr(raw_data, 62, 4)::varchar(4) as "dd_mdly",
        substr(raw_data, 66, 8)::varchar(8) as dd_sectest,
        substr(raw_data, 74, 4)::varchar(4) as "cd_sms",
        substr(raw_data, 78, 20)::varchar(20) as "cd_dispatch_mdl",
        substr(raw_data, 98, 20)::varchar(20) as "cd_sale_mdl",
        substr(raw_data, 118, 8)::varchar(8) as dt_frameno_capture,
        ldts,
        line_number
    from {{source('snowpipe_db_customerservice', 'raw_ktrla05azz0kvw0002')}}
)
select * from substr_ktrla05azz0kvw0002