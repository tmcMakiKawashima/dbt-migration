{{
    config (
        materialized = 'incremental',
        incremental_strategy = 'append'
    )
}}

with stg_oem_syaryosys as (
    select
        cdno::varchar(1) as cdno, 
        idln::varchar(2) as idln, 
        idmm::varchar(2) as idmm, 
        iddd::varchar(2) as iddd, 
        idren::varchar(4) as idren, 
        tskbn::varchar(1) as tskbn, 
        sno::varchar(2) as sno, 
        ktcd::varchar(5) as ktcd, 
        odt::varchar(1) as odt, 
        smkcd::varchar(3) as smkcd, 
        dfsc::varchar(5) as dfsc, 
        frkbn::varchar(3) as frkbn, 
        mdlyr::varchar(1) as mdlyr, 
        kjcd::varchar(1) as kjcd, 
        dum1::varchar(6) as dum1, 
        wmi::varchar(3) as wmi, 
        vds::varchar(6) as vds, 
        mkrln::varchar(2) as mkrln, 
        smkbn::varchar(1) as smkbn, 
        smkms::varchar(1) as smkms, 
        stkh::varchar(1) as stkh, 
        dum2::varchar(6) as dum2, 
        frno::varchar(7) as frno, 
        dum3::varchar(2) as dum3, 
        ipkbn::varchar(1) as ipkbn, 
        dum4::varchar(5) as dum4, 
        kyy::varchar(2) as kyy, 
        kmm::varchar(2) as kmm, 
        kdd::varchar(2) as kdd, 
        dum5::varchar(9) as dum5, 
        current_timestamp::timestamp_ntz(9) as load_date, 
        ldts
    from {{ ref('substr_tsjfa393') }}

)
select * from stg_oem_syaryosys

{% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
{% endif %}