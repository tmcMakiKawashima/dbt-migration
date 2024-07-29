with
    tmp70 as (
        select
            syadai_kt, -- 車台型式 stg_kokunaiseisan
            frmno as frm_no, -- フレーム№ stg_kokunaiseisan
            syasyu_cd, -- 車種コードstg_kokunaiseisan
            haisya_kt, -- 配車型式 stg_kokunaiseisan
            hkata as hanbai_kt, -- 販売型式 stg_haisyagenshi
            ext_cd, -- 外販色コード stg_kokunaiseisan
            int_cd, -- 内張コード stg_kokunaiseisan
            shiyodai as daibun_cd, -- 大分類コード stg_specname
            sketa as sketa_cd, -- スペック桁 stg_kokunaiseisan200
            smeikanji as dai_kanji_name, -- 大分類技術名称（漢字） stg_specname（大分類）
            dai_kana_name, -- 大分類技術名称（カナ） stg_specname（大分類）
            dai_eiji_name, -- 大分類技術名称（英字） stg_specname（大分類）
            null as dai_catalog_name, -- 大分類カタログ名称 null
            shiyosai as saimoku_cd, -- 細目コード stg_specname（細目）
            skigo as skigo_cd, -- スペック記号 stg_kokunaiseisan200
            sai_kana_name, -- 細目技術名称（カナ） stg_specname（細目）
            sai_eiji_name, -- 細目技術名称（英字） stg_specname（細目）
            case 
                when saimoku_cd_std_eiji_syasyu <> '' then saimoku_cd_std_eiji_syasyu
                when saimoku_cd_std_kana_syasyu <> '' then saimoku_cd_std_kana_syasyu
                when saimoku_cd_std_eiji <> '' then saimoku_cd_std_eiji
                else saimoku_cd_std_kana
            end saimoku_cd_std, -- 細目コード名寄せ mst_vinhis_specification_nameconvert
            null as sai_sales_name, -- 細目営業名称 null
            case 
                when saimoku_cd_std_eiji_syasyu <> '' then sai_catalog_name_eiji_syasyu
                when saimoku_cd_std_kana_syasyu <> '' then sai_catalog_name_kana_syasyu
                when saimoku_cd_std_eiji <> '' then sai_catalog_name_eiji
                else sai_catalog_name_kana
            end sai_catalog_name, -- 細目営業名称 mst_vinhis_specification_nameconvert
            null as gi_sotyaku_cd, -- 技術(車両仕様書)装着形態 null
            hsochaku as hanbai_sotyaku_cd, -- 販売装着形態 stg_hanbaihikiate
            current_timestamp::timestamp_ntz as ldts -- load date 
        from {{ ref('tmp70_dm_vinhis_specification_kokunai') }}
    )
select *
from tmp70