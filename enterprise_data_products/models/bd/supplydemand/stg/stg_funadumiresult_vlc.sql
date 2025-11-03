{{
    config (
        materialized = 'incremental',
        unique_key = ['vesselcode', 'kitencd', 'departuredate', 'vhcuniqinfo'],
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where (vesselcode, kitencd, departuredate, vhcuniqinfo) in (select vesselcode, kitencd, departuredate, vhcuniqinfo
                from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubm536loadres') }}
                where _fivetran_deleted = 'true'
                and _fivetran_synced >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 削除フラグがtrueに更新されたレコードを削除

with stg_funadumiresult_vlc as (
    select
        vesselcode::varchar(6) as vesselcode, 
        kitencd::varchar(20) as kitencd, 
        departuredate::varchar(8) as departuredate, 
        tocd::varchar(20) as tocd, 
        syohinsyano::varchar(11) as syohinsyano, 
        arrivaldate::varchar(8) as arrivaldate, 
        arrivaltime::varchar(4) as arrivaltime, 
        vesselname::varchar(120) as vesselname, 
        loaddetno::varchar(7) as loaddetno, 
        loaddate::varchar(8) as loaddate, 
        syohinsyakbn::varchar(1) as syohinsyakbn, 
        gokutivhckbn::varchar(1) as gokutivhckbn, 
        vhcuniqinfo::varchar(18) as vhcuniqinfo, 
        tsumikoucd_org::varchar(7) as tsumikoucd_org, 
        agekoucd_org::varchar(7) as agekoucd_org, 
        unloadstatus::varchar(2) as unloadstatus, 
        shipsts::varchar(2) as shipsts, 
        routeseqno::varchar(3) as routeseqno, 
        rsltdeparturedate::varchar(8) as rsltdeparturedate, 
        rsltdeparturetime::varchar(4) as rsltdeparturetime, 
        rsltarrivaldate::varchar(8) as rsltarrivaldate, 
        rsltarrivaltime::varchar(4) as rsltarrivaltime, 
        upddatetime::timestamp_ntz(9) as upddatetime, 
        upduid::varchar(20) as upduid, 
        insertdatetime::timestamp_ntz(9) as insertdatetime, 
        insertuid::varchar(20) as insertuid, 
        _fivetran_synced::timestamp_ntz(9) as ldts
    from {{ source('fivetran_database_ogg_vlc_osubsp0200db20', 'raw_cubm536loadres') }}
    where _fivetran_deleted = 'false'
)
select * from stg_funadumiresult_vlc

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}