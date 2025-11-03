with substr_ktrla038zz0kadcb8n as (
    select
        substr(raw_data, 1, 2)::varchar(2) as reckbn,
        substr(raw_data, 3, 1)::varchar(1) as mtkbn,
        substr(raw_data, 4, 2)::varchar(2) as carnm_cd,
        substr(raw_data, 6, 2)::varchar(2) as spec_no,
        substr(raw_data, 8, 4)::varchar(4) as inner_cd,
        ldts,
        line_number
    from {{source('snowpipe_db_supplydemand', 'raw_ktrla038zz0kadcb8n')}}
)
select * from substr_ktrla038zz0kadcb8n