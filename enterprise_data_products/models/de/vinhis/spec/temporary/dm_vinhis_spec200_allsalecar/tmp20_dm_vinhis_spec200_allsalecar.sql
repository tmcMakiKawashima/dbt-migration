{{ config(
    snowflake_warehouse='vinhis_l_wh01',
    materialized='table',
    transient='true'
) }}
-- 1-1. 個車生産実績から全レコードを取得
with
    tmp_get_seisan_jisseki as (
        select
            *,
            row_number() over (
                partition by
                    syadai_kt,
                    frmno,
                    wmi,
                    vds,
                    mdlyr,
                    vin_vds_cd
                order by
                    lok_y desc
            ) as latest_rank
        from {{ source('vinhis_db_public','raw_dm_allsalecar_seisanjisseki') }}
    ),

    -- 1-2. 個車生産実績から最新のラインオフ計画のレコードのみを取得
    tmp_get_seisan_jisseki_latest as (
        select * from tmp_get_seisan_jisseki where latest_rank = 1
    ),

    -- 2. 横持レコードに対して。個車生産実績から取得した各情報を結合
    tmp_join_jisseki as (
        select
            a.syadai_kt,
            a.frm_no,
            a.wmi,
            a.vds,
            a.mdlyr,
            a.vin_vds_cd,
            b.syasyu_cd as syasyu,
            b.haisya_kt,
            a.spec200,
            a.daisai200,
            b.int_cd,
            b.ext_cd,
            b.dest_cd,
            b.dest,
            b.psc,
            b.koujyou_cd,
            b.eng_kt,
            b.veh_plnt_code,
            b.prodkuni_cd,
            b.o_idline,
            b.loj_y,
            b.loj_m,
            b.sk_y,
            b.sk_m
        from {{ ref('tmp10_dm_vinhis_spec200_allsalecar') }} as a
        inner join tmp_get_seisan_jisseki_latest as b
            on
                trim(a.syadai_kt) = trim(b.syadai_kt)
                and trim(a.frm_no) = trim(b.frmno)
                and trim(a.wmi) = trim(b.wmi)
                and trim(a.vds) = trim(b.vds)
                and trim(a.mdlyr) = trim(b.mdlyr)
                and trim(a.vin_vds_cd) = trim(b.vin_vds_cd)
    ),

    -- 3. カラーNoから桁数が4桁以下のレコードのみを取得する。
    tmp_get_color_no as (
        select
            gclrno,
            iromei,
            row_number() over (
                partition by
                    trim(gclrno)
                order by
                    gclrno asc
            ) as rank
        from {{ ref('stg_color_no_sms') }}
        where
            length(trim(gclrno)) < 5
    ),

    -- 4. カラーNoの最優先レコードのみを取得する。
    tmp_get_color_no_latest as (
        select * from tmp_get_color_no where rank = 1
    )

-- 5. 項目の名称変換と、外張・内張の色名を結合し、中間テーブルとする
select distinct
    a.syadai_kt,
    a.frm_no,
    a.wmi,
    a.vds,
    a.mdlyr,
    a.vin_vds_cd,
    a.syasyu,
    a.haisya_kt,
    a.spec200,
    a.daisai200 as spec200_siyo,
    a.int_cd,
    '' as int_cd_iromei,
    a.ext_cd,
    coalesce(b.iromei, '') as ext_cd_iromei,
    a.dest_cd,
    a.dest,
    a.psc,
    a.koujyou_cd,
    a.eng_kt,
    a.veh_plnt_code,
    a.prodkuni_cd,
    a.o_idline,
    a.loj_y,
    a.loj_m,
    a.sk_y,
    a.sk_m
from tmp_join_jisseki as a
left join tmp_get_color_no_latest as b
    on trim(a.ext_cd) = trim(b.gclrno)
