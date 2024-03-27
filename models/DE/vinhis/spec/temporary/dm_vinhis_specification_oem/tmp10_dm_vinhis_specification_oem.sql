-- データ結合１
with
    oem as (
        select
            syadai_kt, -- 車台型式
            frmno, -- フレームNo
            wmi, -- WMI
            vds, -- VDS
            vis, -- VISNo.
            mdlyr, -- モデルイヤー
            vin_vds_cd, --チェックディジット
            syasyu_cd, -- SMS車種コード
            haisyakt -- 配車型式 
        from {{ref('stg_oemseisan')}} -- 仕入実績
    )
select * from oem