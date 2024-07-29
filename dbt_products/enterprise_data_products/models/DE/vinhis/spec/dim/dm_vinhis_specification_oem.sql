with
    tmp30 as (
        select * from {{ref('tmp30_dm_vinhis_specification_oem')}}
    ),
    spec as (
        select
            syasyu, -- SMS車種コード
            sketa, -- スペック桁
            skigo, --スペック記号
            shiyosai, -- 細目コード
            smeikana, --スペック名称カナ
            smeieiji -- スペック名称英字
        from {{ref('stg_specname')}} -- スペック名称
        where skigo <> ' '
    )
select
    tmp30.syadai_kt, -- 車台型式 stg_oemseisan
    tmp30.frmno as frm_no, -- フレームNo stg_oemseisan
    tmp30.wmi, -- WMI stg_oemseisan
    tmp30.vds, -- VDS stg_oemseisan
    tmp30.mdlyr, -- モデルイヤー stg_oemseisan
    tmp30.vin_vds_cd, -- チェックディジット stg_oemseisan
    tmp30.syasyu_cd, -- 車種コード stg_oemseisan,
    tmp30.haisyakt as haisya_kt, -- 配車型式 stg_oemseisan
    tmp30.shiyodai as daibun_cd, -- 大分類コード stg_specname
    tmp30.sketa as sketa_cd, -- スペック桁 stg_oemseisan200
    tmp30.smeikanji as dai_kanji_name, -- 大分類技術名称（漢字） stg_specname（大分類）
    tmp30.smeikana as dai_kana_name, -- 大分類技術名称（カナ） stg_specname（大分類）
    tmp30.smeieiji as dai_eiji_name, -- 大分類技術名称（英字） stg_specname（大分類）
    null as dai_catalog_name, -- 大分類カタログ名称 null
    spec.shiyosai as saimoku_cd, -- 細目コード stg_specname（細目）
    tmp30.skigo as skigo_cd, -- スペック記号 stg_oemseisan200
    spec.smeikana as sai_kana_name, -- 細目技術名称（カナ） stg_specname（細目）
    spec.smeieiji as sai_eiji_name, -- 細目技術名称（英字） stg_specname（細目）
    null as saimoku_cd_std, --  細目コード名寄せ null
    null as sai_sales_name, -- 細目営業名称 null
    null as sai_catalog_name, -- 細目カタログ名称 null
    null as gi_sotyaku_cd, -- 技術（車両仕様書）装着形態 null
    current_timestamp::timestamp_ntz as ldts -- Load Date
from tmp30
left outer join spec
    on tmp30.syasyu_cd = spec.syasyu
    and tmp30.sketa = spec.sketa
    and tmp30.skigo = spec.skigo