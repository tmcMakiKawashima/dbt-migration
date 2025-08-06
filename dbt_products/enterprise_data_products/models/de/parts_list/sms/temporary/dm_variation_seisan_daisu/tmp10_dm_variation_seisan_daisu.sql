with vsas as (
  select 
    syadai_kt,  -- 車台型式
    frm_no,  -- フレーム連番
    wmi,  -- WMI
    vds,  -- VDS
    mdlyr,  -- モデルレイヤー/製造年
    vin_vds_cd,  -- VINチェックディジット
    syasyu,  -- 車種コード
    haisya_kt,  -- 配車型式
    spec200,  -- SPEC200桁組合せ
    daisai200,  -- SPEC対応4桁仕様
    sk_y,  -- 終検日年
    sk_m  -- 終検日月
  from {{source('vinhis_db_spec','raw_dm_vinhis_spec200_allsalecar')}}
  -- TODO 別チーム開発中のためコメントアウト　解除後source.ymlの記載も削除忘れずに
  -- from {{ref('dm_vinhis_spec200_allsalecar')}}
),ascv as (
  select
    syadai_kt,  -- 車台型式
    frm_no,  -- フレーム連番
    wmi,  -- WMI
    vds,  -- VDS
    mdlyr,  -- モデルレイヤー/製造年
    vin_vds_cd,  -- VINチェックディジット
    kumitate,  -- 組立番号
    bui,  -- 部位
    vari,  -- バリエーション
    seppen_no_kara  -- 設変Noカラ
  -- TODO データ件数が多いため、source.ymlの参照先をテスト用に変えているため変更忘れずに
  from {{source('vinhis_db_parts','raw_dm_allsalescar_variation')}}
)
select
    vsas.syadai_kt,  -- 車台型式
    vsas.frm_no,  -- フレーム連番
    vsas.wmi,  -- WMI
    vsas.vds,  -- VDS
    vsas.mdlyr,  -- モデルレイヤー/製造年
    vsas.vin_vds_cd,  -- VINチェックディジット
    coalesce(vsas.syasyu, '') as syasyu,  -- 車種コード
    coalesce(ascv.kumitate, '') as kumitate,  -- 組立番号
    coalesce(ascv.bui, '') as bui,  -- 部位
    coalesce(ascv.vari, '') as vari,  -- バリエーション
    coalesce(ascv.seppen_no_kara, '') as seppen_no_kara,  -- 設変Noカラ
    coalesce(vsas.haisya_kt, '') as haisya_kt,  -- 配車型式
    coalesce(vsas.spec200, '') as spec200,  -- SPEC200桁組合せ
    vsas.daisai200,  -- SPEC対応4桁仕様
    coalesce(vsas.sk_y, '') as sk_y,  -- 終検日年
    coalesce(vsas.sk_m, '') as sk_m  -- 終検日月
from vsas
left join ascv
on (
    vsas.syadai_kt = ascv.syadai_kt
and vsas.frm_no = ascv.frm_no
and vsas.wmi = ascv.wmi
and vsas.vds = ascv.vds
and vsas.mdlyr = ascv.mdlyr
and vsas.vin_vds_cd = ascv.vin_vds_cd
)