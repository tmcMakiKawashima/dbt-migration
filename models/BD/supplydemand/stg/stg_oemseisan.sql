{{
    config (
        materialized = 'incremental',
        unique_key = ['syadai_kt', 'frmno'],
        incremental_strategy = 'merge'
    )
}}

with stg_oemseisan as (
    select
        syadai_kt::varchar(6) as syadai_kt,
        frmno::varchar(7) as frmno,
        vin_wmi::varchar(3) as wmi,
        vin_vds::varchar(6) as vds,
        vin_vis::varchar(8) as vis,
        mdlyr::varchar(1) as mdlyr,
        vin_vds_cd::varchar(1) as vin_vds_cd,
        idntno::varchar(10) as idntno,
        siyono::varchar(2) as sno,
        odt::varchar(1) as odt,
        dfscedno::varchar(5) as dfscedno,
        syameicd::varchar(2) as syameicd,
        nisgt::varchar(1) as nisgt,
        hi_ktcd::varchar(5) as hi_ktcd,
        hi_kt::varchar(15) as haisyakt,
        lo_ktcd::varchar(5) as lo_ktcd,
        lo_kt::varchar(15) as lo_kt,
        gaihncd::varchar(4) as gaicd,
        utibrcd::varchar(4) as ucd,
        sn_spec::varchar(200) as spec,
        smkcd::varchar(3) as smkcd,
        kojyo_kbn::varchar(1) as kojyo_kbn,
        tmkr2_r::varchar(2) as tmkr2_r,
        tmkr2_s::varchar(2) as tmkr2_s,
        k1ymd::varchar(8) as k1ymd,
        sk_ymd::varchar(8) as sk_ymd,
        engno::varchar(7) as engno,
        sire_dai::varchar(4) as sire_dai,
        ltrim(frkbn, ' 　')::varchar(3) as frmkbn, -- 左ブランク
        ltrim(sms_syasyucd, ' 　')::varchar(4) as syasyu_cd, -- 左ブランク
        hnbaitncd::varchar(5) as hnbaitncd,
        haisya_y::varchar(4) as haisya_y,
        haisya_m::varchar(2) as haisya_m,
        haisya_d::varchar(2) as haisya_d,
        createuser::varchar(13) as createuser,
        createtime::varchar(26) as createtime,
        updateuser::varchar(13) as updateuser,
        try_to_timestamp_ntz(updatetime, 'yyyy/mm/dd hh24:mi:ss.ff9') as updatetime, -- timestamp
        ldts, -- B層LDTS
        rank() over(
            partition by 
                syadai_kt,
                frmno
            order by ldts desc
        ) aggkey
    from {{ref('substr_da5a215a')}}

    {% if is_incremental() %}
        where ldts > (select max(ldts) from {{ this }})
    {% endif %}

)
select * exclude(aggkey) from stg_oemseisan where aggkey = 1