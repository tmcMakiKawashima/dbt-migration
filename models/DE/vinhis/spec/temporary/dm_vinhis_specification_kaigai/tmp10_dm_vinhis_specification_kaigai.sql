-- データ結合１
with
    kaigai as (
        select
            syadai_kt, -- 車台型式
            frmno, -- フレーム№
            wmi, -- WMI
            vds, -- VDS
            mdlyr, -- モデルイヤー
            vin_vds_cd, -- VINチェックディジット
            syasyu_cd, -- 車種コード
            haisyakt as haisya_kt -- 配車型式
        from {{ ref("stg_kaigaiseisan") }}  -- 海外新生産実績
    )
select * 
from kaigai