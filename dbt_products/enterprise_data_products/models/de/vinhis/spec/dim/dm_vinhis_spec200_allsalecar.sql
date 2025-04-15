

with
    add_seisan as (
        select
        --主キー項目のNULLをブランクに変換
            spec200.syadai_kt,
            spec200.frm_no,
            spec200.wmi,
            spec200.vds,
            spec200.mdlyr,
            spec200.vin_vds_cd,
            spec200.syasyu_cd as syasyu,
            spec200.haisya_kt as haisya_kt,
            coalesce(spec200.veh_plnt_code,'') as veh_plnt_code,
            spec200.spec200,
            spec200.daisai200,
            spec200.int_cd,
            spec200.int_cd_iromei,
            spec200.ext_cd,
            spec200.ext_cd_iromei,
            spec200.dest_cd,
            spec200.dest,
            spec200.psc,
            spec200.koujyou_cd,
            spec200.eng_kt,
            spec200.prodkuni_cd,
            spec200.loj_y,
            spec200.loj_m,
            spec200.sk_y,
            spec200.sk_m,
            spec200.o_idline,
            km.ktfgo, 
            sks.seisanbasyo,
            sks.kata
        from
            {{ ref('tmp10_dm_vinhis_spec200_allsalecar') }} as spec200
            --工場変換マスター(工程⇔iQAS)を結合。工程符号(上3桁)を取得する
            left join {{ source('engineering_db_public','raw_m_koujyomaster') }} as km 
            on(coalesce(spec200.veh_plnt_code,'') = km.veh_plnt_code)
            --車種型式車両組立工場を結合。生産場所を取得する
            left join {{ source('katashiki_db_basespec','raw_dm_syasyu_katashiki_syaryokoujyo') }} as sks
            on(
                trim(spec200.syasyu_cd) = trim(sks.syasyu)
                and trim(spec200.haisya_kt) = trim(sks.kata)
            )
    ),
    add_index1 as (
        select
            as1.*,
            row_number() over(
            partition by 
                as1.syadai_kt,
                as1.frm_no,
                as1.wmi,
                as1.vds,
                as1.mdlyr,
                as1.vin_vds_cd,
                as1.syasyu,
                as1.haisya_kt,
                as1.veh_plnt_code
            order by
                as1.seisanbasyo
            ) as index1
        from
            add_seisan as as1
        where
            as1.seisanbasyo like concat(trim(as1.ktfgo), '%')
    ),
    
    add_index2 as (
        select
            as2.*,
            row_number() over(
                partition by
                    as2.syadai_kt,
                    as2.frm_no,
                    as2.wmi,
                    as2.vds,
                    as2.mdlyr,
                    as2.vin_vds_cd,
                    as2.syasyu,
                    as2.haisya_kt,
                    as2.veh_plnt_code
            order by
                as2.seisanbasyo
            ) as index2
        from add_seisan as as2
    ),
    
    add_rank as (
        select
            ai2.*,
            ai1.index1,
            row_number() over (
                partition by
                    ai2.syadai_kt,
                    ai2.frm_no,
                    ai2.wmi,
                    ai2.vds,
                    ai2.mdlyr,
                    ai2.vin_vds_cd,
                    ai2.syasyu,
                    ai2.haisya_kt,
                    ai2.veh_plnt_code
                order by 
                    case 
                        when index1 is null then 1 else 0 end, index1, index2
           ) as rnk
        from
            add_index2 as ai2
            left join add_index1 ai1
            on(
                ai2.syadai_kt = ai1.syadai_kt
                and ai2.frm_no = ai1.frm_no
                and ai2.wmi = ai1.wmi
                and ai2.vds = ai1.vds
                and ai2.mdlyr = ai1.mdlyr
                and ai2.vin_vds_cd = ai1.vin_vds_cd
                and ai2.syasyu = ai1.syasyu
                and ai2.haisya_kt = ai1.haisya_kt
                and ai2.veh_plnt_code = ai1.veh_plnt_code
                and ai2.ktfgo = ai1.ktfgo
                and ai2.seisanbasyo = ai1.seisanbasyo
            )
    ),
    kl as (select * from {{ source('parts_list_db_public','raw_dm_ktfgo_list') }}),
    mst041 as (select * from {{ source('common_tbl_db_iqas_name_convert','raw_mst_041veh_plnt_code_name') }})
    
select 
    add_rank.syadai_kt,
    add_rank.frm_no,
    add_rank.wmi,
    add_rank.vds,
    add_rank.mdlyr,
    add_rank.vin_vds_cd,
    add_rank.syasyu,
    add_rank.haisya_kt,
    add_rank.veh_plnt_code,
    add_rank.spec200,
    add_rank.daisai200,
    add_rank.int_cd,
    add_rank.int_cd_iromei,
    add_rank.ext_cd,
    add_rank.ext_cd_iromei,
    add_rank.dest_cd,
    add_rank.dest,
    add_rank.psc,
    add_rank.koujyou_cd,
    add_rank.eng_kt,
    add_rank.prodkuni_cd,
    add_rank.loj_y,
    add_rank.loj_m,
    add_rank.sk_y,
    add_rank.sk_m,
    add_rank.o_idline,
    add_rank.seisanbasyo,
    kl.ktfgomeijp,
    kl.ktfgomeien,
    RIGHT(mst041.value_ja, LEN(mst041.value_ja) - 4) as value_ja,
    RIGHT(mst041.value_en, LEN(mst041.value_en) - 4) as value_en
    
from add_rank
left outer join kl
    on add_rank.seisanbasyo = kl.ktfgo
left outer join mst041
    on add_rank.veh_plnt_code = mst041.table_data_id
where add_rank.rnk = 1