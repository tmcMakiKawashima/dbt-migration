-- 1. config設定(incremental merge設定と、post_hook実装)
-- 論理削除処理(論理削除するための比較処理を実装する都合上、updateに入れ込むことができないためpost_hookで実装)

{{
    config (
        materialized = 'incremental',
        unique_key = [ 'syadai_kt', 'frmno', 'wmi', 'vds', 'mdlyr', 'vin_vds_cd' ],
        incremental_strategy = 'merge',
        post_hook = [
            "
                update {{this}}
                set
                    ldts = current_timestamp(),
                    delflg = true
                where ( syadai_kt, frmno, wmi, vds, mdlyr, vin_vds_cd ) not in (
                    select distinct
                        syadai_kt, frmno, wmi, vds, mdlyr, vin_vds_cd
                    from {{ ref('tmp30_dm_vinhis_spec200_allsalecar') }}
                )
            "
        ]
    )
}}

-- 2. 対象となるデータ抽出
-- delflg以外を対象とする。(delflgはtrueのものも混ざっているため)
with tmp_get_target as (
    select
        a.syadai_kt::varchar(9) as syadai_kt,
        a.frmno::varchar(7) as frmno,
        a.wmi::varchar(3) as wmi,
        a.vds::varchar(6) as vds,
        a.mdlyr::varchar(1) as mdlyr,
        a.vin_vds_cd::varchar(1) as vin_vds_cd,
        a.syasyu::varchar(4) as syasyu,
        a.haisya_kt::varchar(20) as haisya_kt,
        a.spec200::varchar(40000) as spec200,
        a.spec200_siyo::varchar(800) as spec200_siyo,
        a.int_cd::varchar(4) as int_cd,
        a.int_cd_iromei::varchar(25) as int_cd_iromei,
        a.ext_cd::varchar(4) as ext_cd,
        a.ext_cd_iromei::varchar(25) as ext_cd_iromei,
        a.dest_cd::varchar(5) as dest_cd,
        a.dest::varchar(10) as dest,
        a.psc::varchar(2) as psc,
        a.koujyou_cd::varchar(1) as koujyou_cd,
        a.eng_kt::varchar(8) as eng_kt,
        a.veh_plnt_code::varchar(3) as veh_plnt_code,
        a.veh_plnt_code_name::varchar(900) as veh_plnt_code_name,
        a.veh_plnt_code_name_en::varchar(900) as veh_plnt_code_name_en,
        a.seisanbasyo::varchar(6) as seisanbasyo,
        a.ktfgomeijp::varchar(40) as ktfgomeijp,
        a.ktfgomeien::varchar(40) as ktfgomeien,
        a.prodkuni_cd::varchar(3) as prodkuni_cd,
        a.o_idline::varchar(2) as o_idline,
        a.loj_y::varchar(4) as loj_y,
        a.loj_m::varchar(2) as loj_m,
        a.sk_y::varchar(4) as sk_y,
        a.sk_m::varchar(2) as sk_m
    from {{ ref('tmp30_dm_vinhis_spec200_allsalecar') }} a

    -- 追加文
    {% if is_incremental() %}
        minus
        select
            b.syadai_kt::varchar(9) as syadai_kt,
            b.frmno::varchar(7) as frmno,
            b.wmi::varchar(3) as wmi,
            b.vds::varchar(6) as vds,
            b.mdlyr::varchar(1) as mdlyr,
            b.vin_vds_cd::varchar(1) as vin_vds_cd,
            b.syasyu::varchar(4) as syasyu,
            b.haisya_kt::varchar(20) as haisya_kt,
            b.spec200::varchar(40000) as spec200,
            b.spec200_siyo::varchar(800) as spec200_siyo,
            b.int_cd::varchar(4) as int_cd,
            b.int_cd_iromei::varchar(25) as int_cd_iromei,
            b.ext_cd::varchar(4) as ext_cd,
            b.ext_cd_iromei::varchar(25) as ext_cd_iromei,
            b.dest_cd::varchar(5) as dest_cd,
            b.dest::varchar(10) as dest,
            b.psc::varchar(2) as psc,
            b.koujyou_cd::varchar(1) as koujyou_cd,
            b.eng_kt::varchar(8) as eng_kt,
            b.veh_plnt_code::varchar(3) as veh_plnt_code,
            b.veh_plnt_code_name::varchar(900) as veh_plnt_code_name,
            b.veh_plnt_code_name_en::varchar(900) as veh_plnt_code_name_en,
            b.seisanbasyo::varchar(6) as seisanbasyo,
            b.ktfgomeijp::varchar(40) as ktfgomeijp,
            b.ktfgomeien::varchar(40) as ktfgomeien,
            b.prodkuni_cd::varchar(3) as prodkuni_cd,
            b.o_idline::varchar(2) as o_idline,
            b.loj_y::varchar(4) as loj_y,
            b.loj_m::varchar(2) as loj_m,
            b.sk_y::varchar(4) as sk_y,
            b.sk_m::varchar(2) as sk_m
        from {{this}} b
    {% endif %}
)
-- 対象データに当日日付と、削除フラグfalseを設定する。
select
    syadai_kt,
    frmno,
    wmi,
    vds,
    mdlyr,
    vin_vds_cd,
    syasyu,
    haisya_kt,
    spec200,
    spec200_siyo,
    int_cd,
    int_cd_iromei,
    ext_cd,
    ext_cd_iromei,
    dest_cd,
    dest,
    psc,
    koujyou_cd,
    eng_kt,
    veh_plnt_code,
    veh_plnt_code_name,
    veh_plnt_code_name_en,
    seisanbasyo,
    ktfgomeijp,
    ktfgomeien,
    prodkuni_cd,
    o_idline,
    loj_y,
    loj_m,
    sk_y,
    sk_m,
    current_timestamp() as ldts,
    false as delflg
from tmp_get_target
