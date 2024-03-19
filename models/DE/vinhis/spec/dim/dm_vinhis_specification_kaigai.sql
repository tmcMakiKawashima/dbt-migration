-- データ結合４
with
    tmp30 as (select * from {{ ref("tmp30_dm_vinhis_specification_kaigai") }}),
    spec as (
        select
            syasyu, -- 車種コード
            sketa, -- スペック桁
            skigo, -- スペック記号
            shiyosai as saimoku_cd, -- 細目コード
            smeikana as sai_kana_name, -- スペック名称カナ
            smeieiji as sai_eiji_name, -- スペック名称英字
        from {{ ref("stg_specname") }} -- スペック名称
        where skigo <> ' '
    )
select
    tmp30.syadai_kt, -- 車台型式 stg_kaigaiseisan
    tmp30.frmno, -- フレーム№ stg_kaigaiseisan
    tmp30.wmi, -- wmi stg_kaigaiseisan
    tmp30.vds, -- vds stg_kaigaiseisan
    tmp30.mdlyr, -- モデルイヤー stg_kaigaiseisan
    tmp30.vin_vds_cd, -- チェックディジット stg_kaigaiseisan
    tmp30.syasyu_cd, -- 車種コード stg_kaigaiseisan
    tmp30.haisya_kt, -- 配車型式 stg_kaigaiseisan
    tmp30.daibun_cd, -- 大分類コード stg_specname
    tmp30.sketa_cd, -- スペック桁 stg_kaigaiseisan200
    tmp30.dai_kanji_name, -- 大分類技術名称（漢字） stg_specname（大分類）
    tmp30.dai_kana_name, -- 大分類技術名称（カナ） stg_specname（大分類）
    tmp30.dai_eiji_name, -- 大分類技術名称（英字） stg_specname（大分類）
    null as dai_catalog_name, -- 大分類カタログ名称 null
    spec.saimoku_cd, -- 細目コード stg_specname（細目）
    tmp30.skigo_cd, -- スペック記号 stg_kaigaiseisan200
    spec.sai_kana_name, -- 細目技術名称（カナ） stg_specname（細目）
    spec.sai_eiji_name, -- 細目技術名称（英字） stg_specname（細目）
    null as saimoku_cd_std, -- 細目コード名寄せ null
    null as sai_sales_name, -- 細目営業名称 null
    null as sai_catalog_name, -- 細目カタログ名称 null
    null as gi_sotyaku_cd, -- 技術(車両仕様書)装着形態 null
    current_timestamp::timestamp_ntz as ldts -- load date 
from tmp30
left outer join spec
  on tmp30.syasyu_cd = spec.syasyu
 and tmp30.sketa_cd = spec.sketa
 and tmp30.skigo_cd = spec.skigo