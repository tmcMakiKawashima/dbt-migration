{{ config(materialized='table') }}
with temp20 as (
    select
        tehai_DLRCD M_DLRCD,  --メーカー仕向先CD
        tehai_YUSOKBN M_YUSOKBN,  --メーカー輸送CD
        tehai_ORDENO M_ORDENO,  --メーカー注文No
        tehai_JUCHUYMD M_JUCHUYMD,  --メーカー受注日
        tehai_JHINBAN M_JHINBAN,  --メーカー受注品番
        JUCHU5 M_JUCHUSU,  --メーカー受注数
        tehai_ORDESYBT M_SYUBETSU,  --メーカーオーダー種別
        RIMAK1 M_RIMAK1,  --メーカーリマーク1
        RIMAK2 M_RIMAK2,  --メーカーリマーク2
        SHINBAN M_SHINBAN,  --メーカー出荷品番
        BOSU5 M_BOSU,  --メーカBO数
        BORENYMD M_BOSKSTIME,  --メーカーBO作成日時
        '' as M_MKAITOCD,  --メーカー未回答CD
        '' as M_HNKKBN,  --メーカー最新回答区分
        '' as M_HNNOYTIME,  --メーカー最新納入予定日時
        '' as M_HNTAYTIME,  --メーカー最新棚入予定日時
        HENKAIYMD M_HNSYYTIME,  --メーカー最新出荷予定日時
        '' as M_HNTOYTIME,  --メーカー最新到着予定日時
        '' as M_HOKKBN,  --メーカー前回回答区分
        '' as M_HONOYTIME,  --メーカー前回納入予定日時
        '' as M_HOTAYTIME,  --メーカー前回棚入予定日時
        '' as M_HOSYYTIME,  --メーカー前回出荷予定日時
        '' as M_HOTOYTIME,  --メーカー前回到着予定日時
        '' as M_HSKKBN,  --メーカー初回回答区分
        '' as M_HSNOYTIME,  --メーカー初回納入予定日時
        '' as M_HSTAYTIME,  --メーカー初回棚入予定日時
        HNOKIKTYMD M_HSSYYTIME, --メーカー初回出荷予定日時
        '' as M_HSTOYTIME,  --メーカー初回到着予定日時
        '' as M_PTOPFLG,    --メーカーPTOPFLG
        '' as M_IPSYYTMIE,  --メーカーインプット出荷予定日時
        '' as M_MARTFLG,  --メーカーマル超FLG
        SYUKKAYMD M_SYUKKAYMD,  --メーカー出荷日
        SYUKKASU M_SYUKKASU,  --メーカ出荷数
        NYUKOYMD,  --ＴＭＰ入庫日
        NYUKOSU,  --ＴＭＰ入庫数
        '' as M_KAKNOUKBN,  --メーカー格納拠点区分
        '' as M_THIBUSYOCD,  --メーカー手配担当部署ＣＤ
        '' as M_THITATOCD,  --メーカー手配担当者CD
        '' as M_TEHAIKBN,  --メーカー手配区分
        '' as M_KEIKANISSU  --メーカー経過日数
    from {{ref('tmp20_dm_tmc_tyokuso_jutyunokikaito')}}
)
select * from temp20