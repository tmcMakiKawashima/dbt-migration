
with stg_chiikimaster as (
    select
        areacd::varchar(3) as areacd, 
        areaname::varchar(64) as areaname, 
        groupkbn::varchar(2) as groupkbn, 
        to_number(sequence,10,0)::number(10,0) as sequence,
        to_number(domesticflg,1,0)::number(1,0) as domesticflg,
        to_number(communicationstartdate,10,0)::number(10,0) as communicationstartdate,
        to_number(warehousenum,10,0)::number(10,0) as warehousenum,
        mailadress::varchar(100) as mailadress, 
        to_number(bodetectionflag,1,0)::number(1,0) as bodetectionflag,
        areanamejp::varchar(64) as areanamejp, 
        createuserid::varchar(15) as createuserid, 
        to_timestamp(createdatetime,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as createdatetime,
        updateuserid::varchar(15) as updateuserid,
        to_timestamp(updatedatetime,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as updatedatetime,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by areacd
            order by line_number desc
        ) aggkey 
    from {{source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0909')}}
    where ldts = (select max(ldts) from {{source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0909')}})
)
select * exclude(aggkey) from stg_chiikimaster
where aggkey = 1