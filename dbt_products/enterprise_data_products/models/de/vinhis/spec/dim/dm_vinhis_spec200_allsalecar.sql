-- 1. 車両コード工場名称、生産場所付与
with tmp_add_plant as (
    select
        a.*,
        b.value_ja as veh_plnt_code_name,
        b.value_en as veh_plnt_code_name_en,
        c.ktfgo,
        d.seisanbasyo
    from {{ ref ('tmp10_dm_vinhis_spec200_allsalecar')}} a
    left join {{ source('common_tbl_db_iqas_name_convert','raw_mst_041veh_plnt_code_name') }} as b
        on trim(a.veh_plnt_code) = trim(b.table_data_id)
    left join {{ source('engineering_db_public','raw_m_koujyomaster') }} as c
        on trim(a.veh_plnt_code) = trim(c.veh_plnt_code)
    left join {{ source('vinhis_db_seppen_yokoten','raw_dm_syasyu_katashiki_syaryokoujyo') }} as d
       on trim(a.syasyu) = trim(d.syasyu) and
        trim(a.haisya_kt) = trim(d.kata)
),

-- 2. INDEX付与(条件あり)
tmp_add_index1 as (
    select
        *,
        row_number() over (
            partition by
                syasyu,
                haisya_kt,
                veh_plnt_code
            order by
                seisanbasyo asc
        ) as index1
    from tmp_add_plant
    where
        seisanbasyo like concat(trim(ktfgo), '%')
),

-- 3. INDEX付与(条件なし)
tmp_add_index2 as (
    select
        *,
        row_number() over (
            partition by
                syasyu,
                haisya_kt,
                veh_plnt_code
            order by
                seisanbasyo asc
        ) as index2
    from tmp_add_plant
),

-- 4. 優先順位付与(ランク付け)
tmp_add_rank as (
    select
        a.*,
        b.index1,
        row_number() over (
            partition by
                a.syasyu,
                a.haisya_kt,
                a.veh_plnt_code
            order by
                case when b.index1 is null then 1 else 0 end,
                index1,
                index2
        ) as rnk
    from tmp_add_index2 as a
    left join tmp_add_index1 as b
        on trim(a.syasyu) = trim(b.syasyu) and
        trim(a.haisya_kt) = trim(b.haisya_kt) and
        trim(a.veh_plnt_code) = trim(b.veh_plnt_code) and
        trim(a.ktfgo) = trim(b.ktfgo) and
        trim(a.seisanbasyo) = trim(b.seisanbasyo)
),

-- 5. 優先順位が最も高いレコードのみを対象とする
tmp_rank_target as (
    select * from tmp_add_rank where rnk = 1
)
-- 6. 工程符号を付与し出力
select
    a.syadai_kt,
    a.frm_no,
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
    a.seisanbasyo,
    b.ktfgomeijp,
    b.ktfgomeien,
    a.prodkuni_cd,
    a.o_idline,
    a.loj_y,
    a.loj_m,
    a.sk_y,
    a.sk_m
from tmp_rank_target as a
left join {{ source('parts_list_db_ritm0221441_public','raw_dm_ktfgo_list') }} as b
    on trim(a.seisanbasyo) = trim(b.ktfgo)
