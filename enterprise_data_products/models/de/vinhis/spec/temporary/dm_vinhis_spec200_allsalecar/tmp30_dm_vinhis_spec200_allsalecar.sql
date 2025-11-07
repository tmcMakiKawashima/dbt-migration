{{ config(
    materialized='table',
    transient='true'
) }}
-- 1. 中間テーブルに工場名称、生産場所を設定する
with tmp_join_seisanbasyo as (
    select distinct
        a.*,
        b.value_ja as veh_plnt_code_name,
        b.value_en as veh_plnt_code_name_en,
        c.ktfgo,
        d.seisanbasyo
    from {{ ref('tmp20_dm_vinhis_spec200_allsalecar') }} as a
    left join {{ source('common_tbl_db_iqas_name_convert','raw_mst_041veh_plnt_code_name') }} as b
        on trim(a.veh_plnt_code) = trim(b.table_data_id)
    left join {{ source('engineering_db_public','raw_m_koujyomaster') }} c
        on trim(a.veh_plnt_code) = trim(c.veh_plnt_code)
    left join {{ source('katashiki_db_basespec','raw_dm_syasyu_katashiki_syaryokoujyo') }} d
        on trim(a.syasyu) = trim(d.syasyu) and
        trim(a.haisya_kt) = trim(d.kata)
),

-- 2. 各レコードのランク付け用レコードの取得
tmp_get_syasyu_joho as (
    select distinct
        syasyu,
        haisya_kt,
        loj_y,
        loj_m,
        veh_plnt_code,
        ktfgo,
        seisanbasyo
    from tmp_join_seisanbasyo
),

-- 3-1. ランク付け条件1レコード取得(条件1=生産場所が型式符号と等しい)
tmp_get_joken1 as (
    select
        syasyu,
        haisya_kt,
        loj_y,
        loj_m,
        veh_plnt_code,
        ktfgo,
        seisanbasyo,
        row_number() over (
            partition by
                syasyu,
                haisya_kt,
                loj_y,
                loj_m,
                veh_plnt_code
            order by
                seisanbasyo asc
        ) as index1
    from tmp_get_syasyu_joho
    where
        seisanbasyo like concat( trim(ktfgo), '%' )
),

-- 3-2. ランク付け条件1レコードから、最も優先度の高いレコードを取得
tmp_get_joken1_latest as (
    select * from tmp_get_joken1 where index1 = 1
),

-- 4. ランク付け条件2レコード取得(条件2=全レコード)
tmp_get_joken2 as (
    select
        syasyu,
        haisya_kt,
        loj_y,
        loj_m,
        veh_plnt_code,
        ktfgo,
        seisanbasyo,
        row_number() over (
            partition by
                syasyu,
                haisya_kt,
                loj_y,
                loj_m,
                veh_plnt_code
            order by
                seisanbasyo asc
        ) as index2
    from tmp_get_syasyu_joho
),

-- 5. 条件1と条件2を結合し、条件1を最優先としたランク付けを行う
tmp_join_joken as (
    select
        a.*,
        b.index1,
        row_number() over (
            partition by
                a.syasyu,
                a.haisya_kt,
                a.loj_y,
                a.loj_m,
                a.veh_plnt_code
            order by
                case when b.index1 is null then 1 else 0 end,
                index1,
                index2
        ) as rnk
    from tmp_get_joken2 a
    left join tmp_get_joken1_latest b
        on trim(a.syasyu) = trim(b.syasyu) and
        trim(a.haisya_kt) = trim(b.haisya_kt) and
        trim(a.veh_plnt_code) = trim(b.veh_plnt_code) and
        equal_null( a.ktfgo, b.ktfgo ) and
        trim(a.loj_y) = trim(b.loj_y) and
        trim(a.loj_m) = trim(b.loj_m) and
        equal_null( a.seisanbasyo, b.seisanbasyo )
),

-- 6. 最優先となる生産場所の取得
tmp_get_seisanbasyo_latest as (
    select * from tmp_join_joken where rnk = 1
),

-- 7. 最優先となる生産場所を設定
tmp_join_rank1_seisanbasyo as (
    select
        a.syadai_kt,
        a.frm_no as frmno,
        a.wmi,
        a.vds,
        a.mdlyr,
        a.vin_vds_cd,
        a.syasyu,
        a.haisya_kt,
        a.spec200,
        a.spec200_siyo,
        a.int_cd,
        a.int_cd_iromei,
        a.ext_cd,
        a.ext_cd_iromei,
        a.dest_cd,
        a.dest,
        a.psc,
        a.koujyou_cd,
        a.eng_kt,
        a.veh_plnt_code,
        a.veh_plnt_code_name,
        a.veh_plnt_code_name_en,
        b.seisanbasyo,
        c.ktfgomeijp,
        c.ktfgomeien,
        a.prodkuni_cd,
        a.o_idline,
        a.loj_y,
        a.loj_m,
        a.sk_y,
        a.sk_m
    from tmp_join_seisanbasyo a
    left join tmp_get_seisanbasyo_latest b
        on trim(a.syasyu) = trim(b.syasyu) and
        trim(a.haisya_kt) = trim(b.haisya_kt) and
        trim(a.veh_plnt_code) = trim(b.veh_plnt_code) and
        trim(a.loj_y) = trim(b.loj_y) and
        trim(a.loj_m) = trim(b.loj_m)
    left join {{ source('parts_list_db_public','raw_dm_ktfgo_list') }} as c
        on trim(b.seisanbasyo) = trim(c.ktfgo)
)

-- 8. 重複削除
select distinct
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
    sk_m
from tmp_join_rank1_seisanbasyo
