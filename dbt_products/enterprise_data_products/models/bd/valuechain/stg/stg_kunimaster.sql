
with stg_kunimaster as (
    select
        countrycd::varchar(3) as countrycd, 
        countryname::varchar(30) as countryname, 
        groupkbn::varchar(2) as groupkbn, 
        agencycd::varchar(5) as agencycd, 
        agencyname::varchar(100) as agencyname, 
        to_number(orderapprovalflg,1,0)::number(1,0) as orderapprovalflg,
        to_number(orderreceiveflg,1,0)::number(1,0) as orderreceiveflg,
        to_number(deliveryapprovalflg,1,0)::number(1,0) as deliveryapprovalflg,
        to_number(supervisionagencyflg,1,0)::number(1,0) as supervisionagencyflg,
        to_number(ttctargetcountryflg,1,0)::number(1,0) as ttctargetcountryflg,
        createuserid::varchar(15) as createuserid, 
        to_timestamp(createdatetime,'YYYY-MM-DD HH24:MI:SS.FF6')::timestamp(6) as createdatetime,
        updateuserid::varchar(15) as updateuserid,
        to_timestamp(updatedatetime,'YYYY-MM-DD HH24:MI:SS.FF6')::timestamp(6) as updatedatetime,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by countrycd
            order by line_number desc
        ) aggkey 
    from {{source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0908')}}
    where ldts = (select max(ldts) from {{source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0908')}})
)
select * exclude(aggkey) from stg_kunimaster
where aggkey = 1