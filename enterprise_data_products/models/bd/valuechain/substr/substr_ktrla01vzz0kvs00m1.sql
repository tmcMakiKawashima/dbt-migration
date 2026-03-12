with substr_ktrla01vzz0kvs00m1 as (
    select
        substr(raw_data, 1, 20)::varchar(20) as hinban,
        substr(raw_data, 21, 20)::varchar(20) as hinmeien,
        substr(raw_data, 41, 6)::varchar(6) as zensekaisiki,
        substr(raw_data, 47, 6)::varchar(6) as zensekaisyuki,
        substr(raw_data, 53, 6)::varchar(6) as nihonkyokusiki,
        substr(raw_data, 59, 6)::varchar(6) as nihonkyokusyuki,
        substr(raw_data, 65, 6)::varchar(6) as bhntehaikaisiym,
        substr(raw_data, 71, 10)::varchar(10) as sinsetusppnnmbr,
        substr(raw_data, 81, 10)::varchar(10) as haisinsppnnmbr,
        substr(raw_data, 91, 9)::varchar(9) as brnet,
        substr(raw_data, 100, 7)::varchar(7) as buturyutani1,
        substr(raw_data, 107, 7)::varchar(7) as buturyutani2,
        substr(raw_data, 114, 7)::varchar(7) as buturyutani3,
        substr(raw_data, 121, 1)::varchar(1) as zantikbn,
        substr(raw_data, 122, 16)::varchar(16) as mtuserid,
        substr(raw_data, 138, 26)::varchar(26) as mttime,
        substr(raw_data, 164, 17)::varchar(17) as filler,
        ldts,
        line_number
    from {{source('snowpipe_db_valuechain', 'raw_ktrla01vzz0kvs00m1')}}
)
select * from substr_ktrla01vzz0kvs00m1