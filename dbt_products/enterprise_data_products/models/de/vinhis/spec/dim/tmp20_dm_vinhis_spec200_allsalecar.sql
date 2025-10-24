-- 1. 装備(VIN×MOP)情報から車種と敗者型式のデータのみ取得
with tmp_get_union_2 as (
    select distinct
        trim(syadai_kt) as syadai_kt,
        trim(frm_no) as frm_no,
        trim(wmi) as wmi,
        trim(vds) as vds,
        trim(mdlyr) as mdlyr,
        trim(vin_vds_cd) as vin_vds_cd,
        trim(syasyu_cd) as syasyu,
        trim(haisya_kt) as haisya_kt
    from {{ source('vinhis_db_vinspec','raw_dm_vinhis_specification_union_test') }}
),

-- 2-1. 個車生産実績から全レコードを取得
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

-- 2-2. 個車生産実績から最新のラインオフ計画のレコードのみを取得
tmp_get_seisan_jisseki_latest as (
    select * from tmp_get_seisan_jisseki where latest_rank = 1
),

-- 3. 横持レコードに対して。個車生産実績から取得した各情報を結合
tmp_join_jisseki as (
    select
        a.syadai_kt,
        a.frm_no,
        a.wmi,
        a.vds,
        a.mdlyr,
        a.vin_vds_cd,
        c.syasyu,
        c.haisya_kt,
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
        b.sk_m,
        a.ldts_union,
        a.ldts_siyouhenkan,
        b.ldts_seisan,
        b.ldts_hanbai
    from {{ ref('tmp10_dm_vinhis_spec200_allsalecar') }} a
    inner join tmp_get_seisan_jisseki_latest b
        on trim(a.syadai_kt) = trim(b.syadai_kt) and
        trim(a.frm_no) = trim(b.frmno) and
        trim(a.wmi) = trim(b.wmi) and
        trim(a.vds) = trim(b.vds) and
        trim(a.mdlyr) = trim(b.mdlyr) and
        trim(a.vin_vds_cd) = trim(b.vin_vds_cd)
    left join tmp_get_union_2 c
        on trim(a.syadai_kt) = trim(c.syadai_kt) and
        trim(a.frm_no) = trim(c.frm_no) and
        trim(a.wmi) = trim(c.wmi) and
        trim(a.vds) = trim(c.vds) and
        trim(a.mdlyr) = trim(c.mdlyr) and
        trim(a.vin_vds_cd) = trim(c.vin_vds_cd)
)

-- 4. 項目の名称変換と、外張・内張の色名を結合し、中間テーブルとする
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
    b.iromei as int_cd_iromei,
    a.ext_cd,
    c.iromei as ext_cd_iromei,
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
    a.sk_m,
    a.ldts_union,
    a.ldts_siyouhenkan,
    a.ldts_seisan as ldts_seisan_jisseki,
    a.ldts_hanbai as ldts_hanbai_jisseki,
    greatest( b.ldts, c.ldts ) as ldts_color
from tmp_join_jisseki a
left join {{ ref('stg_color_no') }} b
    on trim(a.int_cd) = b.gclrno
left join {{ ref('stg_color_no') }} c
    on trim(a.ext_cd) = c.gclrno