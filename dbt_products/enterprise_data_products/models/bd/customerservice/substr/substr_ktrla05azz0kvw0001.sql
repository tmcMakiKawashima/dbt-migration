with substr_ktrla05azz0kvw0001 as (
    select
        substr(raw_data, 1, 16)::varchar(16) as no_ofr_alt_pub,
        substr(raw_data, 17, 6)::varchar(6) as cd_pubbnd,
        substr(raw_data, 23, 10)::varchar(10) as no_pub,
        substr(raw_data, 33, 3)::varchar(3) as no_pub_termfrid,
        substr(raw_data, 36, 1)::varchar(1) as kb_lang,
        substr(raw_data, 37, 6)::varchar(6) as dd_pub_trmfrym,
        substr(raw_data, 43, 1)::varchar(1) as kb_pub_type,
        substr(raw_data, 44, 2)::varchar(2) as kb_cont_type,
        substr(raw_data, 46, 1)::varchar(1) as cd_trgt,
        substr(raw_data, 47, 2)::varchar(2) as cd_brand,
        substr(raw_data, 49, 12)::varchar(12) as dt_server_opn,
        substr(raw_data, 61, 1)::varchar(1) as kb_pub_form,
        ldts,
        line_number
    from {{source('snowpipe_db_customerservice', 'raw_ktrla05azz0kvw0001')}}
)
select * from substr_ktrla05azz0kvw0001