
with stg_kuni as (
    select 
        to_number(id,20,0)::number(20,0) as id,
        to_number(matterid,20,0)::number(20,0) as matterid,
        areacd::varchar(3) as areacd,
        countrycd::varchar(3) as countrycd,
        to_number(targetnum,10,0)::number(10,0) as targetnum,
        to_number(forecasttargetnum,10,0)::number(10,0) as forecasttargetnum,
        to_timestamp(measuresstartdate,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as measuresstartdate,
        to_timestamp(reportday,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as reportday,
        status::varchar(2) as status,
        to_number(measuresenforcementnum,10,0)::number(10,0) as measuresenforcementnum,
        to_number(prioritycountryflg,1,0)::number(1,0) as prioritycountryflg,
        to_number(mailcheckflg,1,0)::number(1,0) as mailcheckflg,
        createuserid::varchar(15) as createuserid,
        to_timestamp(createdatetime,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as createdatetime,
        updateuserid::varchar(15) as updateuserid,
        to_timestamp(updatedatetime,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as updatedatetime,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by id
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0905') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0905') }})
)
select * exclude(aggkey) from stg_kuni
where aggkey = 1
