{{
  config(
    materialized = 'incremental',
    unique_key = ['psc', 'plantcode', 'idno', 'lodate'],
    incremental_strategy = 'merge'
  )
}}

with stg_hostalc_allsfvam as (
  select
    rtrim(psc, ' 　')::varchar(2) as psc, -- PSC
    rtrim(plantcode, ' 　')::varchar(1) as plantcode, -- 工場コード
    rtrim(idno, ' 　')::varchar(10) as idno, -- アイデントNO
    iff(rtrim(prodplantype, ' 　')='',null,rtrim(prodplantype, ' 　'))::number(2,0) as prodplantype, -- 生産計画区分
    rtrim(idline, ' 　')::varchar(2) as idline, -- アイデントライン
    rtrim(discsign, ' 　')::varchar(1) as discsign, -- 識別記号
    rtrim(ordcycl, ' 　')::varchar(1) as ordcycl, -- オーダーサイクル
    rtrim(bdno, ' 　')::varchar(5) as bdno, -- ボデーNO
    rtrim(frcode, ' 　')::varchar(3) as frcode, -- フレーム区分
    rtrim(frseq, ' 　')::varchar(7) as frseq, -- フレーム連番
    rtrim(urn, ' 　')::varchar(10) as urn, -- URN
    rtrim(vintype2, ' 　')::varchar(2) as vintype2, -- 欧米用変換前VIN区分
    rtrim(vintype, ' 　')::varchar(1) as vintype, -- VIN区分
    rtrim(vinwmi, ' 　')::varchar(3) as vinwmi, -- WMI(製造者識別)
    rtrim(vinvds, ' 　')::varchar(6) as vinvds, -- VDS(車両仕様区分)
    rtrim(vinkata, ' 　')::varchar(9) as vinkata, -- 車台型式
    rtrim(vinfr67, ' 　')::varchar(1) as vinfr67, -- フレームシーケンスNO桁数
    rtrim(vinmy, ' 　')::varchar(1) as vinmy, -- モデルイヤー/製造年
    rtrim(maker, ' 　')::varchar(4) as maker, -- メーカーコード
    rtrim(sno, ' 　')::varchar(2) as sno, -- 仕様書NO
    rtrim(odrtype, ' 　')::varchar(1) as odrtype, -- オーダータイプ
    rtrim(dfsc, ' 　')::varchar(5) as dfsc, -- DFSC/EDNO
    rtrim(lodate, ' 　')::varchar(8) as lodate, -- ラインオフ計画日
    rtrim(packmonth, ' 　')::varchar(6) as packmonth, -- 梱包年月
    rtrim(carname, ' 　')::varchar(2) as carname, -- 車名コード
    rtrim(figure, ' 　')::varchar(1) as figure, -- 荷姿
    rtrim(desttype, ' 　')::varchar(1) as desttype, -- 仕向区分
    rtrim(destdetail, ' 　')::varchar(1) as destdetail, -- 仕向明細
    rtrim(govaprvl, ' 　')::varchar(1) as govaprvl, -- 指定適否
    rtrim(intcode, ' 　')::varchar(4) as intcode, -- 内張り
    rtrim(extcode, ' 　')::varchar(4) as extcode, -- 外鈑色
    rtrim(prdweek, ' 　')::varchar(2) as prdweek, -- プロダクションウィーク(NA)
    rtrim(prodsuffix, ' 　')::varchar(2) as prodsuffix, -- 生産サフィックス
    rtrim(salessuffix, ' 　')::varchar(2) as salessuffix, -- 販売サフィックス
    rtrim(importduty, ' 　')::varchar(1) as importduty, -- 再輸出区分
    rtrim(katacode, ' 　')::varchar(5) as katacode, -- 配車型式コード
    rtrim(katashiki, ' 　')::varchar(20) as katashiki, -- 配車型式
    rtrim(ctl1kata, ' 　')::varchar(20) as ctl1kata, -- コントロール型式
    rtrim(lokatacode, ' 　')::varchar(5) as lokatacode, -- ラインオフ型式コード
    rtrim(lokatashiki, ' 　')::varchar(20) as lokatashiki, -- ラインオフ型式
    rtrim(engbkata, ' 　')::varchar(5) as engbkata, -- エンジン基本型式
    rtrim(motbkata, ' 　')::varchar(5) as motbkata, -- モーター基本型式
    rtrim(motbkatarr, ' 　')::varchar(5) as motbkatarr, -- モーター基本型式RR
    rtrim(recepttype, ' 　')::varchar(3) as recepttype, -- 現地ベース仕様
    rtrim(kdlotcd, ' 　')::varchar(2) as kdlotcd, -- KDロットコード
    rtrim(kdlotno, ' 　')::varchar(4) as kdlotno, -- KDロットNO
    rtrim(kdlotsub, ' 　')::varchar(2) as kdlotsub, -- ロットサブNO
    rtrim(asdfrmstamp, ' 　')::varchar(17) as asdfrmstamp, -- 着工前アサイン済みフレームNO/ボデー打刻情報
    rtrim(asdvinno, ' 　')::varchar(17) as asdvinno, -- 着工前アサイン済みVIN/プレート打刻情報
    rtrim(carfamily, ' 　')::varchar(4) as carfamily, -- 車種コード
    rtrim(prdreqmonth, ' 　')::varchar(6) as prdreqmonth, -- 生産希望年月
    rtrim(brand, ' 　')::varchar(1) as brand, -- ブランド
    rtrim(katashiki2, ' 　')::varchar(20) as katashiki2, -- 第2配車型式(日野配車型式)
    spec::varchar(200) as spec, -- スペック
    rtrim(destcode, ' 　')::varchar(5) as destcode, -- 仕向地コード
    rtrim(dest, ' 　')::varchar(20) as dest, -- 仕向国
    rtrim(tecsorder, ' 　')::varchar(12) as tecsorder, -- TECSオーダーNO
    rtrim(tecskata, ' 　')::varchar(25) as tecskata, -- TECS型式
    rtrim(tecsmaker, ' 　')::varchar(5) as tecsmaker, -- TECS架装メーカーコード
    rtrim(tecsdealer, ' 　')::varchar(5) as tecsdealer, -- TECS販売店コード
    rtrim(equipmentline, ' 　')::varchar(2) as equipmentline, -- 架装ライン
    rtrim(approvalno2flag, ' 　')::varchar(1) as approvalno2flag, -- 認可NO2有リフラグ
    rtrim(vinstopmarkfr, ' 　')::varchar(1) as vinstopmarkfr, -- VIN打刻止めマーク(前)
    rtrim(vinstopmarkrr, ' 　')::varchar(1) as vinstopmarkrr, -- VIN打刻止めマーク(後)
    rtrim(narefno, ' 　')::varchar(7) as narefno, -- 北米リファレンスNO
    rtrim(bdline, ' 　')::varchar(1) as bdline, -- 着工ライン
    rtrim(proccode, ' 　')::varchar(2) as proccode, -- 生産プロセスコード
    rtrim(bctype, ' 　')::varchar(1) as bctype, -- BC車種区分
    rtrim(theftlbl, ' 　')::varchar(1) as theftlbl, -- 盗難防止ラベル枚数
    rtrim(subfrcode, ' 　')::varchar(1) as subfrcode, -- フレームサブ区分
    rtrim(subbdcode, ' 　')::varchar(1) as subbdcode, -- ボデーNOアサインサブ区分
    rtrim(nofrnoflg, ' 　')::varchar(1) as nofrnoflg, -- フレームNO無し車両サイン
    rtrim(vehcltype, ' 　')::varchar(1) as vehcltype, -- 車両区分
    rtrim(frline, ' 　')::varchar(1) as frline, -- フレーム着工ライン
    rtrim(finline, ' 　')::varchar(1) as finline, -- 抹消ライン
    rtrim(fintp, ' 　')::varchar(2) as fintp, -- 抹消TP
    rtrim(copyflg, ' 　')::varchar(1) as copyflg, -- コピー車両フラグ
    rtrim(dolylacklock1, ' 　')::varchar(2) as dolylacklock1, -- 欠車・ロック車マーク(2X10)#01
    rtrim(dolylacklock2, ' 　')::varchar(2) as dolylacklock2, -- 欠車・ロック車マーク(2X10)#02
    rtrim(dolylacklock3, ' 　')::varchar(2) as dolylacklock3, -- 欠車・ロック車マーク(2X10)#03
    rtrim(dolylacklock4, ' 　')::varchar(2) as dolylacklock4, -- 欠車・ロック車マーク(2X10)#04
    rtrim(dolylacklock5, ' 　')::varchar(2) as dolylacklock5, -- 欠車・ロック車マーク(2X10)#05
    rtrim(dolylacklock6, ' 　')::varchar(2) as dolylacklock6, -- 欠車・ロック車マーク(2X10)#06
    rtrim(dolylacklock7, ' 　')::varchar(2) as dolylacklock7, -- 欠車・ロック車マーク(2X10)#07
    rtrim(dolylacklock8, ' 　')::varchar(2) as dolylacklock8, -- 欠車・ロック車マーク(2X10)#08
    rtrim(dolylacklock9, ' 　')::varchar(2) as dolylacklock9, -- 欠車・ロック車マーク(2X10)#09
    rtrim(dolylacklock10, ' 　')::varchar(2) as dolylacklock10, -- 欠車・ロック車マーク(2X10)#10
    rtrim(paltrestcond, ' 　')::varchar(1) as paltrestcond, -- 台車制約条件コード
    rtrim(chassisline, ' 　')::varchar(1) as chassisline, -- シャシーライン
    rtrim(batbdline, ' 　')::varchar(1) as batbdline, -- 一括着工ライン
    rtrim(wctrls, ' 　')::varchar(1) as wctrls, -- 着工展開サイン
    rtrim(astbdodrs, ' 　')::varchar(1) as astbdodrs, -- 着工順序種別サイン
    rtrim(vineditors, ' 　')::varchar(1) as vineditors, -- VIN編集システムサイン
    rtrim(supplyparttype, ' 　')::varchar(2) as supplyparttype, -- 支給品区分
    rtrim(kdtype, ' 　')::varchar(1) as kdtype, -- KD車両区分
    rtrim(oembrandtype, ' 　')::varchar(1) as oembrandtype, -- 他社ブランド区分
    rtrim(bridgeprodtype, ' 　')::varchar(1) as bridgeprodtype, -- ブリッジ生産区分
    rtrim(vehcategorycode, ' 　')::varchar(2) as vehcategorycode, -- 車両識別コード
    rtrim(asmline, ' 　')::varchar(1) as asmline, -- 組立計画ライン
    rtrim(paintline, ' 　')::varchar(1) as paintline, -- 塗装計画ライン
    rtrim(fbltype, ' 　')::varchar(1) as fbltype, -- 台車区分
    rtrim(prgmngflg, ' 　')::varchar(1) as prgmngflg, -- 納期管理非対称フラグ
    rtrim(gateptn, ' 　')::varchar(1) as gateptn, -- ゲートパターン名
    rtrim(gateno, ' 　')::varchar(2) as gateno, -- ゲート背番号
    rtrim(convrtflg, ' 　')::varchar(3) as convrtflg, -- 組立ライン振り替えサイン
    rtrim(schdate, ' 　')::varchar(8) as schdate, -- VLT出力日
    rtrim(linename, ' 　')::varchar(1) as linename, -- 工場ライン名称コード
    rtrim(clrlot, ' 　')::varchar(2) as clrlot, -- カラーLOT(UK)
    rtrim(tecsmanage, ' 　')::varchar(15) as tecsmanage, -- TECS管理情報
    rtrim(delivrregn, ' 　')::varchar(3) as delivrregn, -- 陸送／航送区分
    rtrim(dlrodrno, ' 　')::varchar(17) as dlrodrno, -- 販売店オーダーNO
    rtrim(custflg, ' 　')::varchar(2) as custflg, -- 顧客サイン
    rtrim(preallocflg, ' 　')::varchar(2) as preallocflg, -- 事前振り当てサイン
    rtrim(custinf, ' 　')::varchar(2) as custinf, -- 顧客情報
    rtrim(dlrname, ' 　')::varchar(17) as dlrname, -- 販売店名称
    rtrim(wrap, ' 　')::varchar(3) as wrap, -- ラップガード
    rtrim(wrapflg, ' 　')::varchar(1) as wrapflg, -- ラップ有無フラグ
    rtrim(carryindest, ' 　')::varchar(8) as carryindest, -- 搬入先コード
    rtrim(schsndflg, ' 　')::varchar(1) as schsndflg, -- SF送信済みサイン
    rtrim(tmpseqflg, ' 　')::varchar(1) as tmpseqflg, -- 仮順序ファイルサイン
    rtrim(fixseqflg, ' 　')::varchar(1) as fixseqflg, -- 確定順序ファイルサイン
    rtrim(rejflg, ' 　')::varchar(1) as rejflg, -- リジェクト車両サイン
    rtrim(carryfwdflg, ' 　')::varchar(1) as carryfwdflg, -- 残オンスケサイン
    rtrim(seqflln, ' 　')::varchar(1) as seqflln, -- 順序ファイルライン
    rtrim(ltaddcode, ' 　')::varchar(10) as ltaddcode, -- 特別生産リードタイム加算コード
    rtrim(chasrejflg, ' 　')::varchar(1) as chasrejflg, -- シャシーリジェクトサイン
    rtrim(bdresndflg, ' 　')::varchar(1) as bdresndflg, -- ボデー再送信サイン
    rtrim(chresndflg, ' 　')::varchar(1) as chresndflg, -- シャシー再送信サイン
    rtrim(intdeliv, ' 　')::varchar(3) as intdeliv, -- 社内配車サイン
    rtrim(ecas, ' 　')::varchar(16) as ecas, -- ECASコード
    rtrim(prioritycode, ' 　')::varchar(2) as prioritycode, -- 重点フォロールート区分
    rtrim(plancutoff, ' 　')::varchar(5) as plancutoff, -- 次輸送先コード
    rtrim(seqno, ' 　')::varchar(5) as seqno, -- 順序NO
    rtrim(fixseqno, ' 　')::varchar(6) as fixseqno, -- 確定順序
    rtrim(fixbdseq, ' 　')::varchar(8) as fixbdseq, -- 確定着工通し順序
    rtrim(fixpaintseq, ' 　')::varchar(8) as fixpaintseq, -- 確定塗装通し順序
    rtrim(fixasmseq, ' 　')::varchar(8) as fixasmseq, -- 確定組立通し順序
    rtrim(seqnodate, ' 　')::varchar(8) as seqnodate, -- 確定順序決定日付
    rtrim(procqty4byte, ' 　')::varchar(4) as procqty4byte, -- 処理台数_4バイト
    rtrim(asmseqdate, ' 　')::varchar(8) as asmseqdate, -- 組立順序決定日付
    rtrim(tmpchseqno, ' 　')::varchar(6) as tmpchseqno, -- シャシー仮着工順序
    rtrim(fixchseqno, ' 　')::varchar(6) as fixchseqno, -- シャシー確定着工順序
    rtrim(fixcchseqno, ' 　')::varchar(8) as fixcchseqno, -- シャシー確定着工通し順序
    rtrim(spldstprodseqrcved, ' 　')::varchar(8) as spldstprodseqrcved, -- 支給先生産順序(受領済)
    rtrim(splsrcprodseqspled, ' 　')::varchar(8) as splsrcprodseqspled, -- 支給元生産順序(提供済)
    rtrim(shippriorank, ' 　')::varchar(1) as shippriorank, -- 船積重点ランク
    rtrim(piooption, ' 　')::varchar(1) as piooption, -- PIO(オフラインオプション)
    rtrim(loadingportcode, ' 　')::varchar(5) as loadingportcode, -- 積港コード
    rtrim(shipassignmtd, ' 　')::varchar(1) as shipassignmtd, -- 船積確定方法
    rtrim(shippingdate, ' 　')::varchar(8) as shippingdate, -- 船積計画日(D-2)
    rtrim(comm1, ' 　')::varchar(50) as comm1, -- コメント1
    rtrim(comm2, ' 　')::varchar(50) as comm2, -- コメント2
    rtrim(comm3, ' 　')::varchar(50) as comm3, -- コメント3
    rtrim(comm4, ' 　')::varchar(50) as comm4, -- コメント4
    rtrim(updateymdel14dg, ' 　')::varchar(14) as updateymdel14dg, -- 更新年月日(外部連携用)_14桁
    ldts::timestamp as ldts, -- B層取込日時
    row_number() over (partition by psc, plantcode, idno, lodate order by ldts desc, line_number desc) aggkey
  from {{ ref('substr_hostalc_all_cka01t0010') }}

  {% if is_incremental() %}
    where ldts > (select coalesce(max(ldts),'1970-01-01 00:00:00.000') from {{this}})
  {% endif %}
)
select * exclude(aggkey) from stg_hostalc_allsfvam where aggkey = 1