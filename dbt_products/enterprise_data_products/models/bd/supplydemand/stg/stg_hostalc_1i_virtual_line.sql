
with stg_hostalc_1i_virtual_line as (
  select
    rtrim(pscexlk, ' 　')::varchar(1) as pscexlk, -- PSC(外部連携用)
    rtrim(plantcode, ' 　')::varchar(1) as plantcode, -- 工場コード
    rtrim(idline, ' 　')::varchar(2) as idline, -- アイデントライン
    rtrim(tp, ' 　')::varchar(2) as tp, -- TP
    rtrim(hostgalctp, ' 　')::varchar(1) as hostgalctp, -- ホスト管理工程
    rtrim(physseqno, ' 　')::varchar(8) as physseqno, -- 物理順序番号
    rtrim(dataastmt, ' 　')::varchar(1) as dataastmt, -- データ種別
    rtrim(psdatepdt, ' 　')::varchar(8) as psdatepdt, -- 通過日(工場暦)
    rtrim(psshfpdt, ' 　')::varchar(1) as psshfpdt, -- 通過直(工場暦)
    rtrim(pstmpdt, ' 　')::varchar(4) as pstmpdt, -- 通過時分(工場暦)
    rtrim(psdatendt, ' 　')::varchar(8) as psdatendt, -- 通過日(自然暦)
    rtrim(urn, ' 　')::varchar(10) as urn, -- URN
    rtrim(line, ' 　')::varchar(1) as line, -- ライン
    rtrim(lodate, ' 　')::varchar(8) as lodate, -- ラインオフ計画日
    rtrim(odrtype, ' 　')::varchar(1) as odrtype, -- オーダータイプ
    rtrim(vehcategorycode, ' 　')::varchar(2) as vehcategorycode, -- 車両識別コード
    rtrim(updateymdel14dg, ' 　')::varchar(14) as updateymdel14dg, -- 更新年月日(外部連携用)_14桁
    ldts::timestamp as ldts -- B層取込日時
  from {{ ref('substr_hostalc_1i_dkae02072301') }}
)
select * from stg_hostalc_1i_virtual_line
where ldts = (select max(ldts) from stg_hostalc_1i_virtual_line)