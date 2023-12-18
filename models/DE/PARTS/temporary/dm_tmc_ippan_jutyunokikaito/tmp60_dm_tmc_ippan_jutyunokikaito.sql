-- データ結合７
with
    temp40 as (
        select
            dlrcd, -- 仕向先CD
            syubetsu, -- オーダー種別
            yusokbn, -- 輸送CD
            odrno, -- オーダーNO
            juchuymd, -- 受注日
            jhinban, -- 受注品番
            --
            juchusu, -- 受注数
            rimak1, -- リマークⅠ
            rimak2, -- リマークⅡ
            hnskiboymd, -- 出荷希望日(最新)
            hoskiboymd, -- 出荷希望日(前回)
            hsskiboymd, -- 出荷希望日(初回/オーダー受注時点)
            skibohenkokaisu, -- 出荷希望日変更回数
            hnhonyoyakuymd, -- 本予約日(最新)
            hshonyoyakuymd, -- 本予約日(初回)
            hnnksyytime, -- 納期回答出荷予定日時(最新)
            honksyytime, -- 納期回答出荷予定日時(前回)
            hsnksyytime, -- 納期回答出荷予定日時(初回)
            allnosicansu, -- キャンセル数量(総量)_納指キャンセル分
            hnnosicansu, -- キャンセル数量(最新)_納指キャンセル分
            hnnosicantime, -- キャンセル日時(最新)_納指キャンセル分
            honosicantime, -- キャンセル日時(前回)_納指キャンセル分
            hsnosicantime, -- キャンセル日時(初回)_納指キャンセル分
            nosicankaisu, -- キャンセル回数_納指キャンセル分
            iphonyoyakuymd, -- IP本予約日
            kariyoyakuymd, -- 仮予約日
            hnnosikbn, -- 納指状態区分(最新)
            hsnosikbn, -- 納指状態区分(初回)
            honosikbn, -- 納指状態区分(前回)
            kaknoukbn, -- 格納拠点区分
            jurrsymd, -- 受注リリース日
            srsirskcd, -- 商流仕入先CD
            kozyocd, -- 工場CD
            brsirskcd, -- 物流仕入先CD
            nonukyokbn, -- 納入拠点区分
            ukeirecd, -- 受入CD
            nonyutni, -- 納入単位
            picloke, -- 出庫ロケ
            sykikicd, -- 職域CD
            sksijbsy, -- 出庫指示場所（ラベル出力場所）
            thibusyocd, -- 手配担当部署CD
            thitatocd, -- 手配担当者CD
            tehaikbn, -- 手配区分
            zaihikbn, -- 在非区分
            cycle4, -- サイクル
            kjnziknisu3, -- 基準在庫日数
            kjnziksu, -- 基準在庫数
            anzenzaikonisu, -- 安全在庫日数
            anznzksu, -- 安全在庫数
            nonyult, -- 納入L/T
            nbscd, -- 納入拠点CD
            orosibacd, -- 降し場CD
            brsirskkojocd, -- 物流仕入先工場CD
            keikanissu, -- 経過日数
            hnnoytime, -- 最新納入予定日時
            hnsyytime, -- 最新出荷予定日時
            hntoytime, -- 最新到着予定日時
            hsnoytime, -- 初回納入予定日時
            hssyytime, -- 初回出荷予定日時
            ptopflg, -- PTOPFLG
            hskkbn, -- 初回回答区分
            hstaytime, -- 初回棚入予定日時
            hstoytime, -- 初回到着予定日時
            hokkbn, -- 前回回答区分
            honoytime, -- 前回納入予定日時
            hotaytime, -- 前回棚入予定日時
            hosyytime, -- 前回出荷予定日時
            hotoytime, -- 前回到着予定日時
            mkaitocd, -- 未回答ＣＤ
            hnkkbn, -- 最新回答区分
            hntaytime, -- 最新棚入予定日時
            ipsyytmie, -- インプット出荷予定日時
            martflg, -- マル超FLG
            listagg(distinct shinban, ',') shinban, -- 出荷品番
            sum(bosu) bosu, -- B_O数
            max(boskstime) boskstime, -- B_O作成日時
            max(pendid) pendid, -- ペンディングID
            sum(pensu) pensu, -- ペンディング数
            min(pentime) pentime, -- ペンディング日時
            min(skzflg) skzflg, -- 出荷済FLG
            min(canzmflg) canzmflg, -- キャンセル済FLG
            min(m_nokishiteiyoyakuymd) m_nokishiteiyoyakuymd, -- 納指予約日
            max(pik_cp_dttm) pikcptime, -- 出庫完日時
            max(pak_dttm) paktime, -- 梱完日時
            max(ldts_snapshot) ldts -- snapshot作成用
        from {{ ref("tmp40_dm_tmc_ippan_jutyunokikaito") }}
        group by all
    ),
    temp50 as (
        select
            sum(syukkasu) syukkasu, -- 出荷数
            max(syukkaymd) syukkaymd, -- 出荷日
            max(nyukoymd) nyukoymd, -- 入庫日
            sum(nyukosu) nyukosu, -- 入庫数
            dlrcd, -- 仕向先CD
            ordesybt, -- オーダー種別
            yusokbn, -- 輸送CD
            ordeno, -- 注文No
            jhinban, -- 受注品番
            juchuymd -- 受注日
        from {{ ref("tmp50_dm_tmc_ippan_jutyunokikaito") }}
        group by all
    )
select temp40.*, 
       temp50.syukkasu,
       temp50.syukkaymd,
       temp50.nyukoymd,
       temp50.nyukosu,
       temp50.dlrcd as check_dlrcd -- 仕向先コード nullチェック用
from temp40
left outer join
    temp50
    on temp40.dlrcd = temp50.dlrcd -- 仕向先CD
    and temp40.syubetsu = temp50.ordesybt -- オーダー種別
    and temp40.yusokbn = temp50.yusokbn -- 輸送CD
    and temp40.odrno = temp50.ordeno -- オーダーNo
    and temp40.juchuymd = temp50.juchuymd -- 受注日
    and temp40.jhinban = temp50.jhinban -- 受注品番