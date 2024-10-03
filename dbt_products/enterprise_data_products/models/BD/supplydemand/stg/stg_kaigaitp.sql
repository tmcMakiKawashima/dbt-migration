{{
    config (
        materialized = 'incremental',
        unique_key = ['syadai_kt', 'frmno', 'wmi', 'vds', 'mdlyr', 'vin_vds_cd', 'lok_y', 'pline', 'tp', 'pretp_kbn', 'pass'],
        incremental_strategy = 'merge'
    )
}}

with stg_kaigaitp as (
    select
        mtkbn::varchar(1) as mtkbn,
        lok_y4::varchar(1) as lok_y4,
        syadai_kt::varchar(9) as syadai_kt,
        frmno::varchar(7) as frmno,
        wmi::varchar(3) as wmi,
        vds::varchar(6) as vds,
        mdlyr::varchar(1) as mdlyr,
        vin_vds_cd::varchar(1) as vin_vds_cd,
        lok_y::varchar(4) as lok_y,
        lok_m::varchar(2) as lok_m,
        lok_y || lok_m::varchar(6) as lineoffplanym,
        pline::varchar(1) as pline,
        tp::varchar(2) as tp,
        pretp_kbn::varchar(2) as pretp_kbn,
        pass::varchar(1) as pass,
        seq::varchar(2) as seq,
        bcno::varchar(3) as bcno,
        pld_y::varchar(4) as pld_y,
        pld_m::varchar(2) as pld_m,
        pld_d::varchar(2) as pld_d,
        pld_y || pld_m || pld_d || pld_mm || pld_nn::varchar(12) as pldymdmn,
        pld_c::varchar(1) as pld_c,
        pld_mm::varchar(2) as pld_mm,
        pld_nn::varchar(2) as pld_nn,
        date_y::varchar(4) as date_y,
        date_m::varchar(2) as date_m,
        date_d::varchar(2) as date_d,
        date_mm::varchar(2) as date_mm,
        date_nn::varchar(2) as date_nn,
        date_y || date_m || date_d || date_mm || date_nn::varchar(12) as dateymdmn,
        delaytime::varchar(7) as delaytime,
        tukayoyu::varchar(7) as tukayoyu,
        prodyoyu::varchar(7) as prodyoyu,
        hsuyoyu::varchar(7) as hsuyoyu,
        leadtime::varchar(7) as leadtime,
        leadtimebs::varchar(7) as leadtimebs,
        pre::varchar(1) as pre,
        end_tp::varchar(2) as end_tp,
        gentp::varchar(2) as gentp,
        keikoku::varchar(1) as keikoku,
        rireki::varchar(1) as rireki,
        createuser::varchar(13) as createuser,
        try_to_timestamp_ntz(createtime, 'yyyy/mm/dd hh24:mi:ss.ff9') as createtime, -- timestamp型
        updateuser::varchar(13) as updateuser,
        try_to_timestamp_ntz(updatetime, 'yyyy/mm/dd hh24:mi:ss.ff9') as updatetime, -- timestamp型
        ldts,
        rank() over(
                partition by
                    syadai_kt,
                    frmno,
                    wmi,
                    vds,
                    mdlyr,
                    vin_vds_cd,
                    lok_y,
                    pline,
                    tp,
                    pretp_kbn,
                    pass
                order by ldts desc
            ) aggkey
        from {{ref('substr_da5a217a')}}

        {% if is_incremental() %}
            where ldts > (select max(ldts) from {{ this }})
        {% endif %}

)
select * exclude(mtkbn, aggkey) from stg_kaigaitp where aggkey = 1 and mtkbn = 'C'