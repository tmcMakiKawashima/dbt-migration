{{
  config(
    materialized = 'incremental',
    unique_key = ['psc', 'plantcode', 'lodate', 'idno'],
    incremental_strategy = 'merge'
  )
}}

with stg_hostalc_allsft as (
  select
    rtrim(psc, ' 　')::varchar(2) as psc, -- PSC
    rtrim(plantcode, ' 　')::varchar(1) as plantcode, -- 工場コード
    rtrim(lodate, ' 　')::varchar(8) as lodate, -- ラインオフ計画日
    rtrim(idno, ' 　')::varchar(10) as idno, -- アイデントNO
    rtrim(prsntstatline, ' 　')::varchar(1) as prsntstatline, -- 最新通過TP:ライン
    rtrim(holdtp, ' 　')::varchar(2) as holdtp, -- 最新通過TP:TP
    rtrim(bcseqno, ' 　')::varchar(3) as bcseqno, -- 最新通過TP:BC連番
    rtrim(prsnttimes, ' 　')::varchar(1) as prsnttimes, -- 最新通過TP:通過回数
    rtrim(lattppdate, ' 　')::varchar(15) as lattppdate, -- 最新通過TP:通過工場暦
    rtrim(lattpdate, ' 　')::varchar(14) as lattpdate, -- 最新通過TP:通過自然暦
    rtrim(prsntline, ' 　')::varchar(1) as prsntline, -- 現工程:ライン
    rtrim(prsntlocat, ' 　')::varchar(2) as prsntlocat, -- 現工程:工程
    rtrim(latrpline, ' 　')::varchar(1) as latrpline, -- 最新通過RP:ライン
    rtrim(latrprp, ' 　')::varchar(2) as latrprp, -- 最新通過RP:RP
    rtrim(latrpbcno, ' 　')::varchar(3) as latrpbcno, -- 最新通過RP:BC連番
    rtrim(latrpcount, ' 　')::varchar(1) as latrpcount, -- 最新通過RP:通過回数
    rtrim(latrppdate, ' 　')::varchar(15) as latrppdate, -- 最新通過RP:通過工場暦
    rtrim(latrpdate, ' 　')::varchar(14) as latrpdate, -- 最新通過RP:通過自然暦
    rtrim(repairprocline, ' 　')::varchar(1) as repairprocline, -- 手直し現工程:ライン
    rtrim(repairprocproc, ' 　')::varchar(2) as repairprocproc, -- 手直し現工程:工程
    rtrim(repflg, ' 　')::varchar(1) as repflg, -- オンライン手直しフラグ
    rtrim(pttreftpline, ' 　')::varchar(1) as pttreftpline, -- 予定参照TP:ライン
    rtrim(pttreftptp, ' 　')::varchar(2) as pttreftptp, -- 予定参照TP:TP
    rtrim(latpointline, ' 　')::varchar(1) as latpointline, -- 最新通過ポイント:ライン
    rtrim(latpointpoint, ' 　')::varchar(2) as latpointpoint, -- 最新通過ポイント:ポイント
    rtrim(latpointbcno, ' 　')::varchar(3) as latpointbcno, -- 最新通過ポイント:BC連番
    rtrim(latpointcount, ' 　')::varchar(1) as latpointcount, -- 最新通過ポイント:通過回数
    rtrim(latpointpdate, ' 　')::varchar(15) as latpointpdate, -- 最新通過ポイント:通過工場暦
    rtrim(latpointdate, ' 　')::varchar(14) as latpointdate, -- 最新通過ポイント:通過自然暦
    rtrim(physprocessline, ' 　')::varchar(1) as physprocessline, -- 現在物理工程:ライン
    rtrim(physprocessproc, ' 　')::varchar(2) as physprocessproc, -- 現在物理工程:工程
    rtrim(delaytime, ' 　')::varchar(7) as delaytime, -- 遅れ時間
    rtrim(prgrssgn, ' 　')::varchar(1) as prgrssgn, -- 進捗警告サイン
    rtrim(csprlatest, ' 　')::varchar(7) as csprlatest, -- 最新通過TP余裕時間
    rtrim(csprbyo, ' 　')::varchar(7) as csprbyo, -- 生産余裕時間
    rtrim(csprdeli, ' 　')::varchar(7) as csprdeli, -- 配送余裕時間
    rtrim(leadtime, ' 　')::varchar(7) as leadtime, -- 実績リードタイム
    rtrim(leadtimebs, ' 　')::varchar(7) as leadtimebs, -- 累積実績リードタイム
    rtrim(rejectstatusflg, ' 　')::varchar(1) as rejectstatusflg, -- リジェクトステータスフラグ
    rtrim(frmstamp, ' 　')::varchar(17) as frmstamp, -- フレームNO/ボデー打刻情報
    rtrim(vinno, ' 　')::varchar(17) as vinno, -- VIN/プレート打刻情報
    rtrim(vincd, ' 　')::varchar(1) as vincd, -- VINチェックディジット
    rtrim(apvprnotpca, ' 　')::varchar(12) as apvprnotpca, -- APV/PR_NO(TPCA)
    rtrim(inspectsign, ' 　')::varchar(1) as inspectsign, -- 終検区分
    rtrim(accident, ' 　')::varchar(1) as accident, -- 事故配車サイン
    rtrim(holdingline, ' 　')::varchar(1) as holdingline, -- 保留ライン
    rtrim(holdingtp, ' 　')::varchar(2) as holdingtp, -- 保留TP
    rtrim(holdingcode1, ' 　')::varchar(2) as holdingcode1, -- 保留コード1
    rtrim(holdingcode2, ' 　')::varchar(2) as holdingcode2, -- 保留コード2
    rtrim(holdingcode3, ' 　')::varchar(2) as holdingcode3, -- 保留コード3
    rtrim(holdingpdatetm, ' 　')::varchar(13) as holdingpdatetm, -- 保留工場暦
    rtrim(delbasedate, ' 　')::varchar(8) as delbasedate, -- デリート基準工場暦
    rtrim(erasetime, ' 　')::varchar(14) as erasetime, -- 抹消日
    rtrim(echangtime, ' 　')::varchar(14) as echangtime, -- 巻替え日
    rtrim(amendtime, ' 　')::varchar(14) as amendtime, -- 任意変更日
    rtrim(amenddfsctime, ' 　')::varchar(14) as amenddfsctime, -- DFSC変更日
    rtrim(amendentrytime, ' 　')::varchar(14) as amendentrytime, -- 現場登録項目訂正日
    rtrim(cancelmvtm, ' 　')::varchar(14) as cancelmvtm, -- 工程取消返車日
    rtrim(jt5month, ' 　')::varchar(6) as jt5month, -- JT5完成年月
    rtrim(stschangetime, ' 　')::varchar(14) as stschangetime, -- その他ステータス変更日
    rtrim(inpttrm, ' 　')::varchar(1) as inpttrm, -- 入力端末コード
    rtrim(echangflg, ' 　')::varchar(1) as echangflg, -- 設変マーク
    rtrim(newmodelflg, ' 　')::varchar(1) as newmodelflg, -- 初号車マーク
    rtrim(spvehicleflg, ' 　')::varchar(1) as spvehicleflg, -- 特定車両マーク
    rtrim(condcd1, ' 　')::varchar(3) as condcd1, -- 監査行き条件コード#1
    rtrim(condcd2, ' 　')::varchar(3) as condcd2, -- 監査行き条件コード#2
    rtrim(condcd3, ' 　')::varchar(3) as condcd3, -- 監査行き条件コード#3
    rtrim(condcd4, ' 　')::varchar(3) as condcd4, -- 監査行き条件コード#4
    rtrim(condcd5, ' 　')::varchar(3) as condcd5, -- 監査行き条件コード#5
    rtrim(condcd6, ' 　')::varchar(3) as condcd6, -- 監査行き条件コード#6
    rtrim(condcd7, ' 　')::varchar(3) as condcd7, -- 監査行き条件コード#7
    rtrim(condcd8, ' 　')::varchar(3) as condcd8, -- 監査行き条件コード#8
    rtrim(condcd9, ' 　')::varchar(3) as condcd9, -- 監査行き条件コード#9
    rtrim(condcd10, ' 　')::varchar(3) as condcd10, -- 監査行き条件コード#10
    rtrim(combino, ' 　')::varchar(3) as combino, -- 仕様評価 組合せNO
    rtrim(combinosub, ' 　')::varchar(20) as combinosub, -- 仕様評価 組合せNOサブ
    rtrim(dockingstatus, ' 　')::varchar(1) as dockingstatus, -- ドッキングステータス
    rtrim(updateymdel14dg, ' 　')::varchar(14) as updateymdel14dg, -- 更新年月日(外部連携用)_14桁
    ldts::timestamp as ldts, -- B層取込日時
    row_number() over (partition by psc, plantcode, lodate, idno order by ldts desc, line_number desc) aggkey
  from {{ ref('substr_hostalc_all_cka01t0990') }}

  {% if is_incremental() %}
    where ldts > (select coalesce(max(ldts),'1970-01-01 00:00:00.000') from {{this}})
  {% endif %}
)
select * exclude(aggkey) from stg_hostalc_allsft where aggkey = 1