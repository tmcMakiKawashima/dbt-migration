
with stg_dairitenkey as (
    select
        to_number(id,20,0)::number(20,0) as id,
        to_number(matterid,20,0)::number(20,0) as matterid,
        cirefno::varchar(10) as cirefno, 
        campaigncd::varchar(6) as campaigncd, 
        createuserid::varchar(15) as createuserid, 
        to_timestamp(createdatetime , 'YYYY-MM-DD HH24:MI:SS.FF6')::timestamp(6) as createdatetime,
        updateuserid::varchar(15) as updateuserid, 
        to_timestamp(updatedatetime , 'YYYY-MM-DD HH24:MI:SS.FF6')::timestamp(6) as updatedatetime,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by id
            order by line_number desc
        ) aggkey 
    from {{source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0902')}}
    where ldts = (select max(ldts) from {{source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0902')}})
)
select * exclude(aggkey) from stg_dairitenkey
where aggkey = 1