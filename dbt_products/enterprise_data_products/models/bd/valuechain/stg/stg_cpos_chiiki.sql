
with stg_cpos_chiiki as (
    select 
        to_number(id,20,0)::number(20,0) as id,
        to_number(matterid,20,0)::number(20,0) as matterid,
        areacd::varchar(3) as areacd,
        to_number(targetnum,10,0)::number(10,0) as targetnum,
        to_number(implementationrate,7,2)::number(7,2) as implementationrate,
        to_timestamp(measuresstartdate,'YYYY-MM-DD HH24:MI:SS.FF6')::timestamp(6) as measuresstartdate,
        to_number(deliveryperiod,10,0)::number(10,0) as deliveryperiod,
        to_number(allnecessarynum,10,0)::number(10,0) as allnecessarynum,
        to_number(monitorflg,1,0)::number(1,0) as monitorflg,
        to_number(startenforcementnum,10,0)::number(10,0) as startenforcementnum,
        to_number(expansionperiodicflg,1,0)::number(1,0) as expansionperiodicflg,
        to_number(prioritycountrysettingflg,1,0)::number(1,0) as prioritycountrysettingflg,
        createuserid::varchar(15) as createuserid,
        to_timestamp(createdatetime,'YYYY-MM-DD HH24:MI:SS.FF6')::timestamp(6) as createdatetime,
        updateuserid::varchar(15) as updateuserid,
        to_timestamp(updatedatetime,'YYYY-MM-DD HH24:MI:SS.FF6')::timestamp(6) as updatedatetime,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by id
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0903') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0903') }})
)
select * exclude(aggkey) from stg_cpos_chiiki
where aggkey = 1
