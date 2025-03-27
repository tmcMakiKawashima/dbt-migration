
with stg_hostalc_1n_production_progress as (
  select
    rtrim(pscexlk, ' 　')::varchar(1) as pscexlk, -- PSC(外部連携用)
    rtrim(plantcode, ' 　')::varchar(1) as plantcode, -- 工場コード
    rtrim(line, ' 　')::varchar(1) as line, -- ライン
    rtrim(tp, ' 　')::varchar(2) as tp, -- TP
    rtrim(idline, ' 　')::varchar(2) as idline, -- アイデントライン
    rtrim(ndate, ' 　')::varchar(8) as ndate, -- 暦日
    rtrim(shift, ' 　')::varchar(1) as shift, -- 直
    rtrim(ppbodies, ' 　')::varchar(4) as ppbodies, -- 生産計画台数
    rtrim(actpliniflg, ' 　')::varchar(1) as actpliniflg, -- 実行計画初期値フラグ
    rtrim(actplbodies, ' 　')::varchar(4) as actplbodies, -- 実行計画台数
    rtrim(pactbodies, ' 　')::varchar(4) as pactbodies, -- 生産実績台数
    rtrim(progdate, ' 　')::varchar(8) as progdate, -- 進度日付
    rtrim(progsh, ' 　')::varchar(1) as progsh, -- 進度直
    rtrim(progbodies, ' 　')::varchar(4) as progbodies, -- 進度台数
    rtrim(entflg, ' 　')::varchar(1) as entflg, -- 投入フラグ
    rtrim(creauser, ' 　')::varchar(20) as creauser, -- 作成者
    rtrim(creadateeln12d, ' 　')::varchar(12) as creadateeln12d, -- 作成年月日(外部連携用)_N12桁
    rtrim(updateymdeln12d, ' 　')::varchar(12) as updateymdeln12d, -- 更新年月日(外部連携用)_N12桁
    ldts::timestamp as ldts -- B層取込日時
  from {{ ref('substr_hostalc_1n_dkae06047201') }}
)
select * from stg_hostalc_1n_production_progress
where ldts = (select max(ldts) from stg_hostalc_1n_production_progress)