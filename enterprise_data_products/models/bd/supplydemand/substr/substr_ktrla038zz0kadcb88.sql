with substr_ktrla038zz0kadcb88 as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 30)::varchar(30) as sle_model,
        substr(raw_data, 34, 1)::varchar(1) as che_fil_clss,
        substr(raw_data, 35, 1)::varchar(1) as eqp_typ,
        substr(raw_data, 36, 5)::varchar(5) as eqp_cond_cd,
        substr(raw_data, 41, 2)::varchar(2) as set_contno,
        substr(raw_data, 43, 1)::varchar(1) as set_eqp_typ,
        substr(raw_data, 44, 4)::varchar(4) as set_eqp_cd,
        substr(raw_data, 48, 2)::varchar(2) as carnm_cd,
        substr(raw_data, 50, 2)::varchar(2) as spec_no,
        substr(raw_data, 52, 20)::varchar(20) as ctl_model,
        substr(raw_data, 72, 1)::varchar(1) as one_set_clss,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb88')}}
)
select * from substr_ktrla038zz0kadcb88