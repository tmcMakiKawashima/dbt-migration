{{ config(snowflake_warehouse='DBT_WH') }}

with
    tmp60 as (
        select
            -- オーダー情報ファイル
            dlrcd m_dlrcd, -- メーカー仕向先CD
            yusokbn m_yusokbn, -- メーカー輸送CD
            odrno m_ordeno, -- メーカー注文NO
            juchuymd m_juchuymd, -- メーカー受注日
            jhinban m_jhinban, -- メーカー受注品番
            juchusu m_juchusu, -- メーカー受注数
            syubetsu m_syubetsu, -- メーカーオーダー種別
            rimak1 m_rimak1, -- メーカーリマークⅠ
            rimak2 m_rimak2, -- メーカーリマークⅡ

            -- オーダー指示ステータスファイル
            shinban m_shinban, -- メーカー出荷品番
            bosu m_bosu, -- メーカーBO数
            boskstime m_boskstime, -- メーカーBO作成日時

            -- BO納期回答ファイル
            mkaitocd m_mkaitocd, -- メーカー未回答CD
            hnkkbn m_hnkkbn, -- メーカー最新回答区分
            hnnoytime m_hnnoytime, -- メーカー最新納入予定日時
            hntaytime m_hntaytime, -- メーカー最新棚入予定日時
            hnsyytime m_hnsyytime, -- メーカー最新出荷予定日時
            hntoytime m_hntoytime, -- メーカー最新到着予定日時
            hokkbn m_hokkbn, -- メーカー前回回答区分
            honoytime m_honoytime, -- メーカー前回納入予定日時
            hotaytime m_hotaytime, -- メーカー前回棚入予定日時
            hosyytime m_hosyytime, -- メーカー前回出荷予定日時
            hotoytime m_hotoytime, -- メーカー前回到着予定日時
            hskkbn m_hskkbn, -- メーカー初回回答区分
            hsnoytime m_hsnoytime, -- メーカー初回納入予定日時
            hstaytime m_hstaytime, -- メーカー初回棚入予定日時
            hssyytime m_hssyytime, -- メーカー初回出荷予定日時
            hstoytime m_hstoytime, -- メーカー初回到着予定日時
            ptopflg m_ptopflg, -- メーカーPTOPFLG
            ipsyytmie m_ipsyytmie, -- メーカーインプット出荷予定日時

            -- BO納期管理資料累積ファイル
            martflg m_martflg, -- メーカーマル超FLG

            -- 国内出荷実績一般
            syukkaymd m_syukkaymd, -- メーカー出荷日
            syukkasu m_syukkasu, -- メーカー出荷数

            -- 入出庫ファイル
            nyukoymd, -- ＴＭＰ入庫日

            -- オーダー指示ステータスファイル
            kaknoukbn m_kaknoukbn, -- メーカー格納拠点区分

            -- 手配かんばんマスタ
            thibusyocd m_thibusyocd, -- メーカー手配担当部署CD
            thitatocd m_thitatocd, -- メーカー手配担当者CD
            tehaikbn m_tehaikbn, -- メーカー手配区分

            -- 出荷便TBL
            keikanissu m_keikanissu, -- メーカー経過日数

            -- オーダー指示ステータスファイル
            pendid m_pendid, -- ペンディングID
            pensu m_pensu, -- ペンディング数
            pentime m_pentime, -- ペンディング日時
            skzflg m_skzflg, -- 出荷済FLG
            canzmflg m_canzmflg, -- キャンセル済FLG
            pentime m_nokishiteiyoyakuymd, -- 納指予約日

            -- 納指オーダー情報ファイル
            hnskiboymd m_hnskiboymd, -- 出荷希望日(最新)
            hoskiboymd m_hoskiboymd, -- 出荷希望日(前回)
            hsskiboymd m_hsskiboymd, -- 出荷希望日(初回/オーダー受注時点)
            skibohenkokaisu m_skibohenkokaisu, -- 出荷希望日変更回数
            hnhonyoyakuymd m_hnhonyoyakuymd, -- 本予約日(最新)
            hshonyoyakuymd m_hshonyoyakuymd, -- 本予約日(初回)
            hnnksyytime m_hnnksyytime, -- 納期回答出荷予定日時(最新)
            honksyytime m_honksyytime, -- 納期回答出荷予定日時(前回)
            hsnksyytime m_hsnksyytime, -- 納期回答出荷予定日時(初回)
            allnosicansu m_allnosicansu, -- キャンセル数量(総量)_納指キャンセル分
            hnnosicansu m_hnnosicansu, -- キャンセル数量(最新)_納指キャンセル分
            hnnosicantime m_hnnosicantime, -- キャンセル日時(最新)_納指キャンセル分
            honosicantime m_honosicantime, -- キャンセル日時(前回)_納指キャンセル分
            hsnosicantime m_hsnosicantime, -- キャンセル日時(初回)_納指キャンセル分
            nosicankaisu m_nosicankaisu, -- キャンセル回数_納指キャンセル分
            iphonyoyakuymd m_iphonyoyakuymd, -- IP本予約日
            kariyoyakuymd m_kariyoyakuymd, -- 仮予約日
            hnnosikbn m_hnnosikbn, -- 納指状態区分(最新)
            hsnosikbn m_hsnosikbn, -- 納指状態区分(初回)
            honosikbn m_honosikbn, -- 納指状態区分(前回)

            -- オーダー指示ファイル
            jurrsymd m_jurrsymd, -- 受注リリース日
            srsirskcd m_srsirskcd, -- 商流仕入先CD
            kozyocd m_kozyocd, -- 工場CD
            brsirskcd m_brsirskcd, -- 物流仕入先CD
            nonukyokbn m_nonukyokbn, -- 納入拠点区分
            ukeirecd m_ukeirecd, -- 受入CD
            nonyutni m_nonyutni, -- 納入単位
            picloke m_picloke, -- 出庫ロケ
            sykikicd m_sykikicd, -- 職域CD
            sksijbsy m_sksijbsy, -- 出庫指示場所（ラベル出力場所）

            -- 手配かんばん
            zaihikbn m_zaihikbn, -- 在非区分
            cycle4 m_cycle4, -- サイクル
            kjnziknisu3 m_kjnziknisu3, -- 基準在庫日数
            kjnziksu m_kjnziksu, -- 基準在庫数
            anzenzaikonisu m_anzenzaikonisu, -- 安全在庫日数
            anznzksu m_anznzksu, -- 安全在庫数
            nonyult m_nonyult, -- 納入L/T
            nbscd m_nbscd, -- 納入拠点CD
            orosibacd m_orosibacd, -- 降し場CD
            brsirskkojocd m_brsirskkojocd, -- 物流仕入先工場CD

            --新入出荷　出荷実績累計
            pikcptime m_pikcptime, -- 出庫完日時
            paktime m_paktime, -- 梱完日時
            
            -- オーダー情報ファイル
            ldts -- snapshot作成用
        from {{ ref("tmp60_dm_tmc_ippan_jutyunokikaito") }}
    )
select *
from tmp60