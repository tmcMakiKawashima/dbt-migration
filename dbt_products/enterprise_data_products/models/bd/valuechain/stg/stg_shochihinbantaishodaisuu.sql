
with stg_shochihinbantaishodaisuu as (
    select 
        to_number(id,20,0)::number(20,0) as id,
        to_number(matterid,20,0)::number(20,0) as matterid,
        areacd::varchar(3) as areacd,
        countrycd::varchar(3) as countrycd,
        to_number(measurespartnoid,20,0)::number(20,0) as measurespartnoid,
        to_number(targetnum,10,0)::number(10,0) as targetnum,
        to_number(forecasttargetnum,10,0)::number(10,0) as forecasttargetnum,
        createuserid::varchar(15) as createuserid,
        to_timestamp(createdatetime,'YYYY-MM-DD HH24:MI:SS.FF6')::timestamp(6) as createdatetime,
        updateuserid::varchar(15) as updateuserid,
        to_timestamp(updatedatetime,'YYYY-MM-DD HH24:MI:SS.FF6')::timestamp(6) as updatedatetime,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by id
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0907') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0907') }})
)
select * exclude(aggkey) from stg_shochihinbantaishodaisuu
where aggkey = 1
