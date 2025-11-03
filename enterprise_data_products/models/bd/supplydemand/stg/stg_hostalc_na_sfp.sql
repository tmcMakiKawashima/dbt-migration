{{
  config(
    materialized = 'incremental',
    unique_key = ['psc', 'plantcode', 'lodate', 'idno', 'line', 'tp'],
    incremental_strategy = 'merge'
  )
}}

with stg_hostalc_na_sfp as (
  select
    rtrim(psc, ' 　')::varchar(2) as psc, -- PSC
    rtrim(plantcode, ' 　')::varchar(1) as plantcode, -- 工場コード
    rtrim(lodate, ' 　')::varchar(8) as lodate, -- ラインオフ計画日
    rtrim(idno, ' 　')::varchar(10) as idno, -- アイデントNO
    rtrim(line, ' 　')::varchar(1) as line, -- ライン
    rtrim(tp, ' 　')::varchar(2) as tp, -- TP
    rtrim(schymdplant, ' 　')::varchar(8) as schymdplant, -- 計画時点TP通過予定日(工場暦)
    rtrim(schshplant, ' 　')::varchar(1) as schshplant, -- 計画時点TP通過予定直(工場暦)
    rtrim(schhmplant, ' 　')::varchar(4) as schhmplant, -- 計画時点TP通過予定時分(工場暦)
    rtrim(schymddate, ' 　')::varchar(8) as schymddate, -- 計画時点TP通過予定日(自然暦)
    rtrim(schhmdate, ' 　')::varchar(4) as schhmdate, -- 計画時点TP通過予定時分(自然暦)
    rtrim(schpsseqno, ' 　')::varchar(8) as schpsseqno, -- 計画時点通過予定:通過順序通し連番
    rtrim(schkakeltaddcd, ' 　')::varchar(1) as schkakeltaddcd, -- 計画時点通過予定:定量間隔抜取区分
    rtrim(bdsschymdplant, ' 　')::varchar(8) as bdsschymdplant, -- 着工時点TP通過予定日(工場暦)
    rtrim(bdsschshplant, ' 　')::varchar(1) as bdsschshplant, -- 着工時点TP通過予定直(工場暦)
    rtrim(bdsschhmplant, ' 　')::varchar(4) as bdsschhmplant, -- 着工時点TP通過予定時分(工場暦)
    rtrim(bdsschymddate, ' 　')::varchar(8) as bdsschymddate, -- 着工時点TP通過予定日(自然暦)
    rtrim(bdsschhmdate, ' 　')::varchar(4) as bdsschhmdate, -- 着工時点TP通過予定時分(自然暦)
    rtrim(bdsschpsseqno, ' 　')::varchar(8) as bdsschpsseqno, -- 着工時点通過予定:通過順序通し連番
    rtrim(bdsschkakeaddcd, ' 　')::varchar(1) as bdsschkakeaddcd, -- 着工時点通過予定:定量間隔抜取区分
    rtrim(latschymdplant, ' 　')::varchar(8) as latschymdplant, -- 最新時点TP通過予定日(工場暦)
    rtrim(latschshplant, ' 　')::varchar(1) as latschshplant, -- 最新時点TP通過予定直(工場暦)
    rtrim(latschhmplant, ' 　')::varchar(4) as latschhmplant, -- 最新時点TP通過予定時分(工場暦)
    rtrim(latschymddate, ' 　')::varchar(8) as latschymddate, -- 最新時点TP通過予定日(自然暦)
    rtrim(latschhmdate, ' 　')::varchar(4) as latschhmdate, -- 最新時点TP通過予定時分(自然暦)
    rtrim(latpsseqno, ' 　')::varchar(8) as latpsseqno, -- 最新通過予定:通過順序通し連番
    rtrim(latkakeltaddcd, ' 　')::varchar(1) as latkakeltaddcd, -- 最新通過予定:定量間隔抜取区分
    rtrim(tmpschymdplant, ' 　')::varchar(8) as tmpschymdplant, -- 仮計画時点TP通過予定日(工場暦)
    rtrim(tmpschshplant, ' 　')::varchar(1) as tmpschshplant, -- 仮計画時点TP通過予定直(工場暦)
    rtrim(tmpschhmplant, ' 　')::varchar(4) as tmpschhmplant, -- 仮計画時点TP通過予定時分(工場暦)
    rtrim(tmpschymddate, ' 　')::varchar(8) as tmpschymddate, -- 仮計画時点TP通過予定日(自然暦)
    rtrim(tmpschhmdate, ' 　')::varchar(4) as tmpschhmdate, -- 仮計画時点TP通過予定時分(自然暦)
    rtrim(tmpschpsseqno, ' 　')::varchar(8) as tmpschpsseqno, -- 仮計画時点通過予定:通過順序通し連番
    rtrim(tmpsckakeltadcd, ' 　')::varchar(1) as tmpsckakeltadcd, -- 仮計画時点通過予定:定量間隔抜取区分
    rtrim(orgschtpymdpdt, ' 　')::varchar(8) as orgschtpymdpdt, -- 初回計画時点TP通過予定日(工場暦)
    rtrim(orgschtpshpdt, ' 　')::varchar(1) as orgschtpshpdt, -- 初回計画時点TP通過予定直(工場暦)
    rtrim(orgschtphmpdt, ' 　')::varchar(4) as orgschtphmpdt, -- 初回計画時点TP通過予定時分(工場暦)
    rtrim(orgschtpymdndt, ' 　')::varchar(8) as orgschtpymdndt, -- 初回計画時点TP通過予定日(自然暦)
    rtrim(orgschtphmndt, ' 　')::varchar(4) as orgschtphmndt, -- 初回計画時点TP通過予定時分(自然暦)
    rtrim(orgschpsseqno, ' 　')::varchar(8) as orgschpsseqno, -- 初回計画時点通過予定:通過順序通し連番
    rtrim(orgsckakeltadcd, ' 　')::varchar(1) as orgsckakeltadcd, -- 初回計画時点通過予定:定量間隔抜取区分
    rtrim(orgbdstpymdpdt, ' 　')::varchar(8) as orgbdstpymdpdt, -- 初回着工時点TP通過予定日(工場暦)
    rtrim(orgbdstpshpdt, ' 　')::varchar(1) as orgbdstpshpdt, -- 初回着工時点TP通過予定直(工場暦)
    rtrim(orgbdstphmpdt, ' 　')::varchar(4) as orgbdstphmpdt, -- 初回着工時点TP通過予定時分(工場暦)
    rtrim(orgbdstpymdndt, ' 　')::varchar(8) as orgbdstpymdndt, -- 初回着工時点TP通過予定日(自然暦)
    rtrim(orgbdstphmndt, ' 　')::varchar(4) as orgbdstphmndt, -- 初回着工時点TP通過予定時分(自然暦)
    rtrim(orgbdspsseqno, ' 　')::varchar(8) as orgbdspsseqno, -- 初回着工時点通過予定:通過順序通し連番
    rtrim(orgbdkakeltadcd, ' 　')::varchar(1) as orgbdkakeltadcd, -- 初回着工時点通過予定:定量間隔抜取区分
    rtrim(bsdlytsc, ' 　')::varchar(7) as bsdlytsc, -- 通過予定追加情報:仮計画時点予定に対する着工時の遅れ時間
    rtrim(bsdlysch, ' 　')::varchar(7) as bsdlysch, -- 計画時予定に対する着工時点の遅れ時間
    rtrim(planlt, ' 　')::varchar(7) as planlt, -- 予定リードタイム
    rtrim(ldplanbs, ' 　')::varchar(7) as ldplanbs, -- 累積予定リードタイム
    rtrim(updateymdel14dg, ' 　')::varchar(14) as updateymdel14dg, -- 更新年月日(外部連携用)_14桁
    ldts::timestamp as ldts, -- B層取込日時
    row_number() over (partition by psc, plantcode, lodate, idno, line, tp order by ldts desc, line_number desc) aggkey
  from {{ ref('substr_hostalc_na_cka01t0060') }}

  {% if is_incremental() %}
    where ldts > (select coalesce(max(ldts),'1970-01-01 00:00:00.000') from {{this}})
  {% endif %}
)
select * exclude(aggkey) from stg_hostalc_na_sfp where aggkey = 1