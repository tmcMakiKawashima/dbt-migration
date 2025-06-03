with
    kokunai as (select * from {{ ref('dm_vinhis_specification_kokunai')}}), --国内新生産実績
    kaigai as (select * from {{ ref('dm_vinhis_specification_kaigai')}}), --海外新生産実績
    oem as (select * from {{ ref('dm_vinhis_specification_oem')}}) --仕入実績

select
    syadai_kt, -- 車台型式 stg_kokunaiseisan
    frm_no, -- フレームNo stg_kokunaiseisan
    '' as wmi, -- WMI ''
    '' as vds, -- vds ''
    '' as mdlyr, -- モデルイヤー ''
    '' as vin_vds_cd, -- チェックディジット ''
    syasyu_cd, -- 車種コード stg_kokunaiseisan
    haisya_kt, -- 配車型式 stg_kokunaiseisan
    hanbai_kt,--販売型式 stg_haisyagenshi
    daibun_cd, -- 大分類コード stg_specname
    sketa_cd, -- スペック桁 stg_kokunaiseisan200
    dai_kanji_name, -- 大分類技術名称（漢字） stg_specname（大分類）
    dai_kana_name, -- 大分類技術名称（カナ） stg_specname（大分類）
    dai_eiji_name, -- 大分類技術名称（英字） stg_specname（大分類）
    dai_catalog_name, -- 大分類カタログ名称 null
    saimoku_cd, -- 細目コード stg_specname（細目）
    skigo_cd, -- スペック記号 stg_kokunaiseisan200
    sai_kana_name, -- 細目技術名称（カナ） stg_specname（細目）
    sai_eiji_name, -- 細目技術名称（カナ） stg_specname（細目）
    saimoku_cd_std, -- 細目コード名寄せ mst_vinhis_specification_nameconvert
    sai_sales_name, -- 細目営業名称 null
    sai_catalog_name, -- 細目カタログ名称 mst_vinhis_specification_nameconvert
    gi_sotyaku_cd, -- 技術(車両仕様書)装着形態 null
    hanbai_sotyaku_cd, --販売装着形態 hanbaihikiate
    ldts
from kokunai
union all
select
    syadai_kt, -- 車台型式 stg_kaigaiseisan
    frm_no, -- フレームNo stg_kaigaiseisan
    wmi, -- WMI stg_kaigaiseisan
    vds, -- vds stg_kaigaiseisan
    mdlyr, -- モデルイヤー stg_kaigaiseisan
    vin_vds_cd, -- チェックディジット stg_kaigaiseisan
    syasyu_cd, -- 車種コード stg_kaigaiseisan
    haisya_kt, -- 配車型式 stg_kaigaiseisan
    '' as hanbai_kt,--販売型式 ''
    daibun_cd, -- 大分類コード stg_specname
    sketa_cd, -- スペック桁 stg_kaigaiseisan200
    dai_kanji_name, -- 大分類技術名称（漢字） stg_specname（大分類）
    dai_kana_name, -- 大分類技術名称（カナ） stg_specname（大分類）
    dai_eiji_name, -- 大分類技術名称（英字） stg_specname（大分類）
    dai_catalog_name, -- 大分類カタログ名称 null
    saimoku_cd, -- 細目コード stg_specname（細目）
    skigo_cd, -- スペック記号 stg_kaigaiseisan200
    sai_kana_name, -- 細目技術名称（カナ） stg_specname（細目）
    sai_eiji_name, -- 細目技術名称（カナ） stg_specname（細目）
    saimoku_cd_std, -- 細目コード名寄せ null
    sai_sales_name, -- 細目営業名称 null
    sai_catalog_name, -- 細目カタログ名称 null
    gi_sotyaku_cd, -- 技術(車両仕様書)装着形態 null
    '' as hanbai_sotyaku_cd, --販売装着形態 ''
    ldts
from kaigai
union all
select
    syadai_kt, -- 車台型式 stg_oemseisan
    frm_no, -- フレームNo stg_oemseisan
    wmi, -- WMI stg_oemseisan
    vds, -- vds stg_oemseisan
    mdlyr, -- モデルイヤー stg_oemseisan
    vin_vds_cd, -- チェックディジット stg_oemseisan
    syasyu_cd, -- 車種コード stg_oemseisan
    haisya_kt, -- 配車型式 stg_oemseisan
    '' as hanbai_kt,--販売型式 ''
    daibun_cd, -- 大分類コード stg_specname
    sketa_cd, -- スペック桁 stg_oemseisan200
    dai_kanji_name, -- 大分類技術名称（漢字） stg_specname（大分類）
    dai_kana_name, -- 大分類技術名称（カナ） stg_specname（大分類）
    dai_eiji_name, -- 大分類技術名称（英字） stg_specname（大分類）
    dai_catalog_name, -- 大分類カタログ名称 null
    saimoku_cd, -- 細目コード stg_specname（細目）
    skigo_cd, -- スペック記号 stg_oemseisan200
    sai_kana_name, -- 細目技術名称（カナ） stg_specname（細目）
    sai_eiji_name, -- 細目技術名称（カナ） stg_specname（細目）
    saimoku_cd_std, -- 細目コード名寄せ null
    sai_sales_name, -- 細目営業名称 null
    sai_catalog_name, -- 細目カタログ名称 null
    gi_sotyaku_cd, -- 技術(車両仕様書)装着形態 null
    '' as hanbai_sotyaku_cd, --販売装着形態 ''
    ldts
from oem