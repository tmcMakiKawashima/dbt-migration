
with stg_anken as (
    select 
        to_number(matterid,20,0)::number(20,0) as matterid,
        matterno::varchar(1000) as matterno,
        mattername::varchar(256) as mattername,
        measureskbn::varchar(2) as measureskbn,
        enforcementkbn::varchar(2) as enforcementkbn,
        to_number(enforcementnum,10,0)::number(10,0) as enforcementnum,
        remarks::varchar(1000) as remarks,
        remarksforeign::varchar(1000) as remarksforeign,
        measurescategory1::varchar(2) as measurescategory1,
        measurescategory2::varchar(2) as measurescategory2,
        measurescategory3::varchar(2) as measurescategory3,
        measurescategory4::varchar(2) as measurescategory4,
        measurescategory5::varchar(2) as measurescategory5,
        measurescategory6::varchar(2) as measurescategory6,
        measurescategory7::varchar(2) as measurescategory7,
        measurescategory8::varchar(2) as measurescategory8,
        measurescategory9::varchar(2) as measurescategory9,
        measurescategory10::varchar(2) as measurescategory10,
        to_number(changerate,10,0)::number(10,0) as changerate,
        to_number(globaltargetnum,10,0)::number(10,0) as globaltargetnum,
        to_number(globalenforcementrate,5,2)::number(5,2) as globalenforcementrate,
        to_timestamp(globalmeasuresstartdate,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as globalmeasuresstartdate,
        to_number(alertnum,10,0)::number(10,0) as alertnum,
        status::varchar(2) as status,
        to_number(deleteflg,1,0)::number(1,0) as deleteflg,
        to_number(countoutsideflg,1,0)::number(1,0) as countoutsideflg,
        physicalfilename1::varchar(256) as physicalfilename1,
        logicalfilename1::varchar(256) as logicalfilename1,
        physicalfilename2::varchar(256) as physicalfilename2,
        physicalfilename3::varchar(256) as physicalfilename3,
        logicalfilename2::varchar(256) as logicalfilename2,
        logicalfilename3::varchar(256) as logicalfilename3,
        to_timestamp(reportday,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as reportday,
        measuresenforcementmanagekbn::varchar(2) as measuresenforcementmanagekbn,
        createuserid::varchar(15) as createuserid,
        to_timestamp(createdatetime,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as createdatetime,
        updateuserid::varchar(15) as updateuserid,
        to_timestamp(updatedatetime,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as updatedatetime,
        to_number(resultsrecountflg,1,0)::number(1,0) as resultsrecountflg,
        vinlistfilepath::varchar(256) as vinlistfilepath,
        expansionmatterkbn::varchar(2) as expansionmatterkbn,
        to_number(expansionprojectflg,1,0)::number(1,0) as expansionprojectflg,
        to_number(expansionfirstflg,1,0)::number(1,0) as expansionfirstflg,
        to_number(parentmatterid,20,0)::number(20,0) as parentmatterid,
        stsnotificationmailkbn::varchar(2) as stsnotificationmailkbn,
        stsnotificationmailsendkbn::varchar(2) as stsnotificationmailsendkbn,
        to_timestamp(simulationbasedate,'yyyy-mm-dd hh24:mi:ss.ff6')::timestamp(6) as simulationbasedate,
        to_number(vinupdateflg,1,0)::number(1,0) as vinupdateflg,
        to_number(demandautocreateflg,1,0)::number(1,0) as demandautocreateflg,
        to_number(capimplementationflg,1,0)::number(1,0) as capimplementationflg,
        to_number(vinreintegrationflg,1,0)::number(1,0) as vinreintegrationflg,
        ldts::timestamp_ntz(9) as ldts,
        row_number() over (
            partition by matterid
            order by line_number desc
        ) aggkey
    from {{ source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0901') }}
    where ldts = (select max(ldts) from {{ source('snowpipe_db_valuechain','raw_ktrea04tzz0kel0901') }})
)
select * exclude(aggkey) from stg_anken
where aggkey = 1
