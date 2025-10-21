with substr_dfsc_option_master_syaryosys as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 5)::varchar(5) as dfsc,
        substr(raw_data, 9, 3)::varchar(3) as opt_cd,
        substr(raw_data, 12, 1)::varchar(1) as cstmers_std_clss,
        substr(raw_data, 13, 8)::varchar(8) as time_stmp_temp,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb87')}}
)
select * from substr_dfsc_option_master_syaryosys