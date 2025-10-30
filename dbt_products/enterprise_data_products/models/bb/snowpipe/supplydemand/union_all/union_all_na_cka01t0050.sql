with union_all_na_cka01t0050 as (
    {{ dynamic_union_all('snowpipe_db', 'supplydemand', 'union_all_na_cka01t0050') }}
)
select * from union_all_na_cka01t0050