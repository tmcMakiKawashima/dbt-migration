
with stg_monitorjokyo as (
    select
        to_number(id,20,0)::number(20,0) as id,
        to_number(matterid,20,0)::number(20,0) as matterid,
        areacd::varchar(3) as areacd, 
        to_number(measurespartnoid,20,0)::number(20,0) as measurespartnoid,
        monitorkbn::varchar(2) as monitorkbn, 
        areamonitorstopkbn::varchar(2) as areamonitorstopkbn, 
        measurespartmonitorstopkbn::varchar(2) as measurespartmonitorstopkbn, 
        to_number(productioncapacity,10,0)::number(10,0) as productioncapacity,
        to_number(productioncapacityupdateflg,1,0)::number(1,0) as productioncapacityupdateflg,
        mailsendkbn::varchar(2) as mailsendkbn, 
        createuserid::varchar(15) as createuserid, 
        to_timestamp(createdatetime,'YYYY-MM-DD HH24:MI:SS.FF6')::timestamp(6) as createdatetime,
        updateuserid::varchar(15) as updateuserid,
        to_timestamp(updatedatetime,'YYYY-MM-DD HH24:MI:SS.FF6')::timestamp(6) as updatedatetime,
        to_number(enforcementnum,10,0)::number(10,0) as enforcementnum,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by id
            order by line_number desc
        ) aggkey 
    from {{source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0906')}}
    where ldts = (select max(ldts) from {{source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0906')}})
)
select * exclude(aggkey) from stg_monitorjokyo
where aggkey = 1