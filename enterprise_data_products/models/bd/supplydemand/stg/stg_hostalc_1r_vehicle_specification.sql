
with stg_hostalc_1r_vehicle_specification as (
  select
    rtrim(pscexlk, ' 　')::varchar(1) as pscexlk, -- PSC(外部連携用)
    rtrim(plantcode, ' 　')::varchar(1) as plantcode, -- 工場コード
    rtrim(urn, ' 　')::varchar(10) as urn, -- URN
    rtrim(dfsc, ' 　')::varchar(5) as dfsc, -- DFSC/EDNO
    rtrim(sno, ' 　')::varchar(2) as sno, -- 仕様書NO
    rtrim(idline, ' 　')::varchar(2) as idline, -- アイデントライン
    rtrim(ctlkata, ' 　')::varchar(20) as ctlkata, -- コントロール型式
    rtrim(intcode, ' 　')::varchar(4) as intcode, -- 内張り
    rtrim(extcode, ' 　')::varchar(4) as extcode, -- 外鈑色
    spec::varchar(200) as spec, -- スペック
    rtrim(carfamily, ' 　')::varchar(4) as carfamily, -- 車種コード
    rtrim(destcode, ' 　')::varchar(5) as destcode, -- 仕向地コード
    rtrim(carname, ' 　')::varchar(2) as carname, -- 車名
    rtrim(figure, ' 　')::varchar(1) as figure, -- 荷姿
    rtrim(unittype, ' 　')::varchar(1) as unittype, -- ユニット区分
    rtrim(equipmentline, ' 　')::varchar(2) as equipmentline, -- 架装ライン
    rtrim(scndasmvtp, ' 　')::varchar(1) as scndasmvtp, -- 架装車両区分
    rtrim(lodate, ' 　')::varchar(8) as lodate, -- ラインオフ計画日
    rtrim(offopttype, ' 　')::varchar(1) as offopttype, -- オフOPT区分
    rtrim(importduty, ' 　')::varchar(1) as importduty, -- 再輸出区分
    rtrim(discsign, ' 　')::varchar(1) as discsign, -- 識別記号
    rtrim(ordcycl, ' 　')::varchar(1) as ordcycl, -- オーダーサイクル
    rtrim(odrtype, ' 　')::varchar(1) as odrtype, -- オーダータイプ
    rtrim(vehcategorycode, ' 　')::varchar(2) as vehcategorycode, -- 車両識別コード
    rtrim(updateymdel14dg, ' 　')::varchar(14) as updateymdel14dg, -- 更新年月日(外部連携用)_14桁
    ldts::timestamp as ldts -- B層取込日時
  from {{ ref('substr_hostalc_1r_dkae02072402') }}
)
select * from stg_hostalc_1r_vehicle_specification
where ldts = (select max(ldts) from stg_hostalc_1r_vehicle_specification)