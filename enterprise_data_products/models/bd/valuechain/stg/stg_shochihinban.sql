
with stg_shochihinban as (
    select
        to_number(measurespartnoid,20,0)::number(20,0) as measurespartnoid, 
        to_number(matterid,20,0)::number(20,0) as matterid, 
        measurespartno::varchar(15) as measurespartno, 
        to_number(dummypartflg,1,0)::number(1,0) as dummypartflg, 
        partname::varchar(100) as partname, 
        to_number(changerate,10,0)::number(10,0) as changerate, 
        to_number(forecastchangerate,10,0)::number(10,0) as forecastchangerate, 
        to_number(useinunitnum,10,0)::number(10,0) as useinunitnum, 
        to_number(measurespartnoflg,1,0)::number(1,0) as measurespartnoflg, 
        to_number(localprocurementflg,1,0)::number(1,0) as localprocurementflg, 
        to_number(breaklikelypartsflg,1,0)::number(1,0) as breaklikelypartsflg, 
        createuserid::varchar(15) as createuserid, 
        to_timestamp(createdatetime,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as createdatetime,
        updateuserid::varchar(15) as updateuserid, 
        to_timestamp(updatedatetime,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as updatedatetime,
        remarks::varchar(1000) as remarks, 
        packingplacekbn::varchar(2) as packingplacekbn, 
        productionlt::varchar(10) as productionlt, 
        to_number(productioncapacity,10,0)::number(10,0) as productioncapacity, 
        to_number(initdeliveryperiod,10,0)::number(10,0) as initdeliveryperiod, 
        to_number(basicstock,10,0)::number(10,0) as basicstock, 
        to_number(inventoryrecountflg,1,0)::number(1,0) as inventoryrecountflg, 
        combinationkbn::varchar(2) as combinationkbn, 
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by measurespartnoid
            order by line_number desc
        ) aggkey 
    from {{source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0904')}}
    where ldts = (select max(ldts) from {{source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0904')}})
)
select * exclude(aggkey) from stg_shochihinban
where aggkey = 1