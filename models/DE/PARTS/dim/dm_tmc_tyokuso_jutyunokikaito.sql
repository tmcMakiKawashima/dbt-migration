with temp40 as (
    select
        dlrcd m_dlrcd,  --メーカー仕向先cd
        yusokbn m_yusokbn,  --メーカー輸送cd
        ordeno m_ordeno,  --メーカー注文no
        juchuymd m_juchuymd,  --メーカー受注日
        jhinban m_jhinban,  --メーカー受注品番
        juchu5 m_juchusu,  --メーカー受注数
        ordesybt m_syubetsu,  --メーカーオーダー種別
        rimak1 m_rimak1,  --メーカーリマーク1
        rimak2 m_rimak2,  --メーカーリマーク2
        shinban m_shinban,  --メーカー出荷品番
        bosu5 m_bosu,  --メーカbo数
        borenymd m_boskstime,  --メーカーbo作成日時
        '' as m_mkaitocd,  --メーカー未回答cd
        '' as m_hnkkbn,  --メーカー最新回答区分
        '' as m_hnnoytime,  --メーカー最新納入予定日時
        '' as m_hntaytime,  --メーカー最新棚入予定日時
        henkaiymd m_hnsyytime,  --メーカー最新出荷予定日時
        '' as m_hntoytime,  --メーカー最新到着予定日時
        '' as m_hokkbn,  --メーカー前回回答区分
        '' as m_honoytime,  --メーカー前回納入予定日時
        '' as m_hotaytime,  --メーカー前回棚入予定日時
        '' as m_hosyytime,  --メーカー前回出荷予定日時
        '' as m_hotoytime,  --メーカー前回到着予定日時
        '' as m_hskkbn,  --メーカー初回回答区分
        '' as m_hsnoytime,  --メーカー初回納入予定日時
        '' as m_hstaytime,  --メーカー初回棚入予定日時
        hnokiktymd m_hssyytime, --メーカー初回出荷予定日時
        '' as m_hstoytime,  --メーカー初回到着予定日時
        '' as m_ptopflg,    --メーカーptopflg
        '' as m_ipsyytmie,  --メーカーインプット出荷予定日時
        '' as m_martflg,  --メーカーマル超flg
        syukkaymd m_syukkaymd,  --メーカー出荷日
        syukkasu m_syukkasu,  --メーカ出荷数
        nyukoymd,  --ｔｍｐ入庫日
        nyukosu,  --ｔｍｐ入庫数
        '' as m_kaknoukbn,  --メーカー格納拠点区分
        '' as m_thibusyocd,  --メーカー手配担当部署ｃｄ
        '' as m_thitatocd,  --メーカー手配担当者cd
        '' as m_tehaikbn,  --メーカー手配区分
        keikanissu m_keikanissu,  --メーカー経過日数
        '' as m_pendid, --ペンディングid
        0 as m_pensu, --ペンディング数
        '' as m_pentime, --ペンディング日時
        '' as m_skzflg, --出荷済flg
        '' as m_canzmflg, --キャンセル済flg
        '' as m_nokishiteiyoyakuymd, --納指予約日
        '' as m_hnskiboymd, --出荷希望日（最新）
        '' as m_hoskiboymd, --出荷希望日（前回）
        '' as m_hsskiboymd, --出荷希望日（初回/オーダー受注時点）
        0 as m_skibohenkokaisu, --出荷希望日変更回数
        '' as m_hnhonyoyakuymd, --本予約日（最新）
        '' as m_hshonyoyakuymd, --本予約日（初回）
        '' as m_hnnksyytime, --納期回答出荷予定日時（最新）
        '' as m_honksyytime, --納期回答出荷予定日時（前回）
        '' as m_hsnksyytime, --納期回答出荷予定日時（初回）
        0 as m_allnosicansu, --キャンセル数量（総量）_納指キャンセル分
        0 as m_hnnosicansu, --キャンセル総量（最新)_納指キャンセル分
        '' as m_hnnosicantime, --キャンセル日時（最新）_納指キャンセル分
        '' as m_honosicantime, --キャンセル日時（前回）_納指キャンセル分
        '' as m_hsnosicantime, --キャンセル日時（初回）_納指キャンセル分
        0 as m_nosicankaisu, --キャンセル回数_納指キャンセル分
        '' as m_iphonyoyakuymd, --ip本予約日
        '' as m_kariyoyakuymd, --仮予約日
        '' as m_hnnosikbn, --納指状態区分（最新）
        '' as m_hsnosikbn, --納指状態区分（初回）
        '' as m_honosikbn, --脳死状態区分（前回）
        '' as m_jurrsymd, --受注リリース日
        '' as m_srsirskcd, --商流仕入先cd
        '' as m_kozyocd, --工場cd
        '' as m_brsirskcd, --物流仕入先cd
        '' as m_nonukyokbn, --納入拠点区分
        '' as m_ukeirecd, --受入cd
        '' as m_nonyutni, --納入単位
        '' as m_picloke, --出庫ロケ
        '' as m_sykikicd, --職域cd
        '' as m_sksijbsy, --出庫指示場所（ラベル出力場所）
        '' as m_zaihikbn, --在非区分
        '' as m_cycle4, --サイクル
        '' as m_kjnziknisu3, --基準在庫日数
        '' as m_kjnziksu, --基準在庫数
        '' as m_anzenzaikonisu, --安全在庫日数
        '' as m_anznzksu, --安全在庫数
        '' as m_nonyult, --納入l/t
        '' as m_nbscd, --納入拠点cd
        '' as m_orosibacd, --降し場cd
        '' as m_brsirskkojocd, --物流仕入先工場cd
        '' as m_nonuhikiatnis, --納入品引当日数
        '' as m_pikcptime, --出庫完日時
        '' as m_paktime, --梱完日時
        ldts ldts -- snapshot作成用
    from {{ref('tmp40_dm_tmc_tyokuso_jutyunokikaito')}}
)
select * from temp40