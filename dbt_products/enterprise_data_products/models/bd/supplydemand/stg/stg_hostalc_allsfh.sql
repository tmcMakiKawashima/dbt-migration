{{
  config(
    materialized = 'incremental',
    unique_key = ['psc', 'plantcode', 'lodate', 'idno', 'line', 'tp', 'prsnttptype', 'times'],
    incremental_strategy = 'merge'
  )
}}

with stg_hostalc_allsfh as (
  select
    rtrim(psc, ' 　')::varchar(2) as psc, -- PSC
    rtrim(plantcode, ' 　')::varchar(1) as plantcode, -- 工場コード
    rtrim(lodate, ' 　')::varchar(8) as lodate, -- ラインオフ計画日
    rtrim(idno, ' 　')::varchar(10) as idno, -- アイデントNO
    rtrim(line, ' 　')::varchar(1) as line, -- ライン
    rtrim(tp, ' 　')::varchar(2) as tp, -- TP
    rtrim(prsnttptype, ' 　')::varchar(2) as prsnttptype, -- 現TP区分
    rtrim(times, ' 　')::varchar(1) as times, -- 通過回数
    rtrim(hostgalctp, ' 　')::varchar(1) as hostgalctp, -- ホスト管理工程
    rtrim(actrsthostseq, ' 　')::varchar(2) as actrsthostseq, -- ホスト管理用実績SEQ
    rtrim(lastbcno, ' 　')::varchar(3) as lastbcno, -- BC連番
    rtrim(pdate, ' 　')::varchar(15) as pdate, -- 工場暦
    rtrim(ntdate, ' 　')::varchar(14) as ntdate, -- 自然暦
    rtrim(delaytime, ' 　')::varchar(7) as delaytime, -- 遅れ時間
    rtrim(prgrssgn, ' 　')::varchar(1) as prgrssgn, -- 進捗警告サイン
    rtrim(csprtp, ' 　')::varchar(7) as csprtp, -- TP通過余裕時間
    rtrim(csprbyo, ' 　')::varchar(7) as csprbyo, -- 生産余裕時間
    rtrim(csprdeli, ' 　')::varchar(7) as csprdeli, -- 配送余裕時間
    rtrim(leadtime, ' 　')::varchar(7) as leadtime, -- 実績リードタイム
    rtrim(leadtimebs, ' 　')::varchar(7) as leadtimebs, -- 累積実績リードタイム
    rtrim(cancelflg, ' 　')::varchar(1) as cancelflg, -- 取消フラグ
    rtrim(histsign, ' 　')::varchar(1) as histsign, -- 履歴サイン
    rtrim(updateymdel14dg, ' 　')::varchar(14) as updateymdel14dg, -- 更新年月日(外部連携用)_14桁
    ldts::timestamp as ldts, -- B層取込日時
    row_number() over (partition by psc, plantcode, lodate, idno, line, tp, prsnttptype, times order by ldts desc, line_number desc) aggkey
  from {{ ref('substr_hostalc_all_cka01t0050') }}

  {% if is_incremental() %}
    where ldts > (select max(ldts) from {{this}})
  {% endif %}
)
select * exclude(aggkey) from stg_hostalc_allsfh where aggkey = 1