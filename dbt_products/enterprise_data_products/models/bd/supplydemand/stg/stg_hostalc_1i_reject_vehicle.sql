
with stg_hostalc_1i_reject_vehicle as (
  select
    rtrim(pscexlk, ' 　')::varchar(1) as pscexlk, -- PSC(外部連携用)
    rtrim(plantcode, ' 　')::varchar(1) as plantcode, -- 工場コード
    rtrim(idline, ' 　')::varchar(2) as idline, -- アイデントライン
    rtrim(urn, ' 　')::varchar(10) as urn, -- URN
    rtrim(lodate, ' 　')::varchar(8) as lodate, -- ラインオフ計画日
    rtrim(odrtype, ' 　')::varchar(1) as odrtype, -- オーダータイプ
    rtrim(vehcategorycode, ' 　')::varchar(2) as vehcategorycode, -- 車両識別コード
    rtrim(updateymdel14dg, ' 　')::varchar(14) as updateymdel14dg, -- 更新年月日(外部連携用)_14桁
    ldts::timestamp as ldts -- B層取込日時
  from {{ ref('substr_hostalc_1i_dkae02072401') }}
)
select * from stg_hostalc_1i_reject_vehicle
where ldts = (select max(ldts) from stg_hostalc_1i_reject_vehicle)