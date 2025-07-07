with substr_k9jfv219 as (
        select
            substr(raw_data, 1, 1)::varchar(1) as mntkbn,
            substr(raw_data, 2, 6)::varchar(6) as ctlgcd,
            substr(raw_data, 8, 4)::varchar(4) as chubnrcd,
            substr(raw_data, 12, 4)::varchar(4) as svglayermei,
            substr(raw_data, 16, 4)::varchar(4) as chuchubnrcd,
            ldts,
            line_number
        from {{source('snowpipe_db_valuechain', 'raw_k9jfv219')}}
)

select * from substr_k9jfv219