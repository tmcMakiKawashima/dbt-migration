with substr_dfsc_kanrikino_meisai_kanren_master_syaryosys as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 5)::varchar(5) as dfsc,
        substr(raw_data, 9, 7)::varchar(7) as funcdtl_cd,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb86')}}
)
select * from substr_dfsc_kanrikino_meisai_kanren_master_syaryosys