{{
    config (
        materialized = 'incremental',
        unique_key = 'idntno',
        incremental_strategy = 'merge',
        post_hook="
            {% if is_incremental() %}
                delete from {{this}}
                where substr(hkate_ymd, 1, 6) >= to_char(add_months(sysdate(), -1), 'yyyymm')
                and idntno not in (select idntno from {{ ref('substr_tsjfa392') }}
                where ldts >= (select max(ldts) from {{ this }}))
            {% endif %}
        "
    )
}}
-- 引当年月日が2か月以内且つ連携ファイルにidntnoが無いレコードを削除

with stg_cmf_syaryosys as (
    select
        recno::varchar(5) as recno, 
        idntno::varchar(10) as idntno, 
        siyo_siyono::varchar(2) as siyo_siyono, 
        siyo_odt::varchar(1) as siyo_odt, 
        siyo_dfscedno::varchar(5) as siyo_dfscedno, 
        siyo_sa_ymd::varchar(8) as siyo_sa_ymd, 
        taimestamp::varchar(26) as taimestamp, 
        lok_ymd::varchar(8) as lok_ymd, 
        aitesk::varchar(2) as aitesk, 
        smkbn_lok::varchar(2) as smkbn_lok, 
        kdlotcd::varchar(2) as kdlotcd, 
        kdlotno::varchar(4) as kdlotno, 
        lok_mkr::varchar(2) as lok_mkr, 
        lok_sa_ymd::varchar(8) as lok_sa_ymd, 
        lok_kkdt_ymd::varchar(8) as lok_kkdt_ymd, 
        frmkbn::varchar(3) as frmkbn, 
        frmno::varchar(7) as frmno, 
        vis_my::varchar(1) as vis_my, 
        vin_vds_cd::varchar(1) as vin_vds_cd, 
        dk_sa_ymd::varchar(8) as dk_sa_ymd, 
        loj_ymd::varchar(8) as loj_ymd, 
        loj_engno::varchar(7) as loj_engno, 
        kjcyoku::varchar(1) as kjcyoku, 
        loj_tiremkr_r::varchar(1) as loj_tiremkr_r, 
        loj_sa_ymd::varchar(8) as loj_sa_ymd, 
        k1_ymd::varchar(8) as k1_ymd, 
        k1_kmkr::varchar(2) as k1_kmkr, 
        k1_sa_ymd::varchar(8) as k1_sa_ymd, 
        k1_ksdt_ymd::varchar(8) as k1_ksdt_ymd, 
        sk_ymd::varchar(8) as sk_ymd, 
        sk_kmkr::varchar(2) as sk_kmkr, 
        smkkbn_sk::varchar(2) as smkkbn_sk, 
        hkate_ymd::varchar(8) as hkate_ymd, 
        sk_tiremkr_r::varchar(1) as sk_tiremkr_r, 
        sk_engno::varchar(7) as sk_engno, 
        sk_sa_ymd::varchar(8) as sk_sa_ymd, 
        rydt_ymd::varchar(8) as rydt_ymd, 
        sk_ksdt_ymd::varchar(8) as sk_ksdt_ymd, 
        ojdt_ymd::varchar(8) as ojdt_ymd, 
        sk_kkdt_ymd::varchar(8) as sk_kkdt_ymd, 
        dsdt_ymd::varchar(8) as dsdt_ymd, 
        kdjk_ymd::varchar(8) as kdjk_ymd, 
        sb_ymd::varchar(8) as sb_ymd, 
        vmf_siyono::varchar(2) as vmf_siyono, 
        vmf_odt::varchar(1) as vmf_odt, 
        vmf_dfscedno::varchar(5) as vmf_dfscedno, 
        hi_ktcd::varchar(5) as hi_ktcd, 
        nisgt::varchar(1) as nisgt, 
        gaihncd::varchar(4) as gaihncd, 
        utibrcd::varchar(4) as utibrcd, 
        smkcd::varchar(3) as smkcd, 
        hi_kt::varchar(15) as hi_kt, 
        dairkbn::varchar(1) as dairkbn, 
        minatcd::varchar(2) as minatcd, 
        tumikbn::varchar(1) as tumikbn, 
        sn_ltime::varchar(2) as sn_ltime, 
        hn_ltime::varchar(2) as hn_ltime, 
        knsn_ritsu::varchar(3) as knsn_ritsu, 
        chiikicd::varchar(2) as chiikicd, 
        siteitkh::varchar(1) as siteitkh, 
        lo_ktcd::varchar(5) as lo_ktcd, 
        lo_kt::varchar(15) as lo_kt, 
        frmbn::varchar(3) as frmbn, 
        ctl_kt::varchar(16) as ctl_kt, 
        mainmkr::varchar(4) as mainmkr, 
        mainln::varchar(2) as mainln, 
        hn_spec::varchar(200) as hn_spec, 
        sn_spec::varchar(200) as sn_spec, 
        syameicd::varchar(2) as syameicd, 
        khn_kt::varchar(10) as khn_kt, 
        vin_wmi::varchar(3) as vin_wmi, 
        vin_vds::varchar(6) as vin_vds, 
        my::varchar(1) as my, 
        smkmei::varchar(10) as smkmei, 
        kd_hnbtcd::varchar(2) as kd_hnbtcd, 
        njkbn::varchar(1) as njkbn, 
        trk_ymd::varchar(8) as trk_ymd, 
        dum01::varchar(1) as dum01, 
        current_timestamp::timestamp_ntz(9) as load_date, 
        ldts,
        line_number,
        row_number() over (partition by idntno order by ldts desc, line_number desc) aggkey
    from {{ ref('substr_tsjfa392') }}

    {% if is_incremental() %}
    where ldts > (select max(ldts) from {{ this }})
    {% endif %}

)
select * exclude(aggkey, line_number) from stg_cmf_syaryosys where aggkey = 1