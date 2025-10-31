with union_all_na_cka01t0990 as (
    {{ dynamic_union_all('snowpipe_db', 'supplydemand', 'union_all_na_cka01t0990') }}
)
select * from union_all_na_cka01t0990