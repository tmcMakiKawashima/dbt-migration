with union_all_vehicle_specification as (
    {{ dynamic_union_all('snowpipe_db', 'supplydemand', 'union_all_vehicle_specification') }}
)
select * from union_all_vehicle_specification