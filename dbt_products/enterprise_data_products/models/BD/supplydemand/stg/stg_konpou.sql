{{
    config (
        materialized = 'incremental',
        unique_key = ['knp_yr', 'idntno'],
        incremental_strategy = 'merge'
    )
}}

with stg_konpou as (
    select
        mtkbn::varchar(1) as mtkbn,
        knp_yr4::varchar(1)	as knp_yr4,
        knp_yr::varchar(4) as knp_yr,
        idntno::varchar(10) as idntno,
        syadai_kt::varchar(6) as syadai_kt,
        frmno::varchar(7) as frmno,
        vin_wmi::varchar(3) as vin_wmi,
        vin_vds::varchar(6) as vin_vds,
        vin_vis::varchar(8) as vin_vis,
        mdlyr::varchar(1) as mdlyr,
        kdlotcd::varchar(2) as kdlotcd,
        kdlotno::varchar(4) as kdlotno,
        kd_hnbtcd::varchar(2) as kd_hnbtcd,
        siyono::varchar(2) as siyono,
        syameicd::varchar(2) as syameicd,
        sms_syasyucd::varchar(4) as sms_syasyucd,
        ctl_kt::varchar(16) as ctl_kt,
        hi_ktcd::varchar(5) as hi_ktcd,
        hi_kt::varchar(15) as hi_kt,
        lo_ktcd::varchar(5) as lo_ktcd,
        lo_kt::varchar(15) as lo_kt,
        gaihncd::varchar(4) as gaihncd,
        utibrcd::varchar(4) as utibrcd,
        sn_spec::varchar(200) as sn_spec,
        smkcd::varchar(3) as smkcd,
        odt::varchar(1) as odt,
        dfscedno::varchar(5) as dfscedno,
        nisgt::varchar(1) as nisgt,
        smkbnrui::varchar(1) as smkbnrui,
        smkmeisai::varchar(1) as smkmeisai,
        siteitkh::varchar(1) as siteitkh,
        lok_y::varchar(4) as lok_y,
        lok_m::varchar(2) as lok_m,
        lok_d::varchar(2) as lok_d,
        lok_y || lok_m || lok_d::varchar(8) as lineoffplanymd,
        lok_mkr::varchar(2) as lok_mkr,
        loj_y::varchar(4) as loj_y,
        loj_m::varchar(2) as loj_m,
        loj_d::varchar(2) as loj_d,
        loj_y || loj_m || loj_d::varchar(8) as lineoffymd,
        kjcyoku::varchar(1) as kjcyoku,
        sk_kmkr::varchar(2) as sk_kmkr,
        sk_y::varchar(4) as sk_y,
        sk_m::varchar(2) as sk_m,
        sk_d::varchar(2) as sk_d,
        sk_y || sk_m || sk_d::varchar(8) as syukenymd,
        hkate_y::varchar(4) as hkate_y,
        hkate_m::varchar(2) as hkate_m,
        hkate_d::varchar(2) as hkate_d,
        hkate_y || hkate_m || hkate_d::varchar(8) as hikiateymd,
        engno::varchar(7) as engno,
        tiremkr_r::varchar(1) as tiremkr_r,
        ltrim(syukei_daisu, '0')::varchar(7) as syukei_daisu, -- 左ゼロトリム
        createuser::varchar(13) as createuser,
        try_to_timestamp_ntz(createtime, 'yyyy/mm/dd hh24:mi:ss.ff9') as createtime, -- timestamp型
        updateuser::varchar(13) as updateuser,
        try_to_timestamp_ntz(updatetime, 'yyyy/mm/dd hh24:mi:ss.ff9') as updatetime, -- timestamp型
        ldts,
        rank() over (partition by knp_yr, idntno order by ldts desc) aggkey
    from {{ ref('substr_da5a218a') }}

        {% if is_incremental() %}
            where ldts > (select max(ldts) from {{ this }})
        {% endif %}

)
select * exclude(mtkbn, aggkey) from stg_konpou where aggkey = 1 and mtkbn = 'C'