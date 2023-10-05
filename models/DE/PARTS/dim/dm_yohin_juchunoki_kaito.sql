with ippan as (
    select 
            M_DLRCD, -- メーカー仕向先CD
            M_YUSOKBN, -- メーカー輸送CD
            M_ORDENO, -- メーカー注文NO
            M_JUCHUYMD, -- メーカー受注日
            M_JHINBAN, -- メーカー受注品番
            -- M_JUCHUSU, -- メーカー受注数
            M_SYUBETSU, -- メーカーオーダー種別
            M_SHINBAN, -- メーカー出荷品番
            M_BOSU, -- メーカーBO数
            M_BOSKSTIME, -- メーカーBO作成日時
            M_HNNOYTIME, -- メーカー最新納入予定日時
            -- M_HNTAYTIME, -- メーカー最新棚入予定日時
            M_HNSYYTIME, -- メーカー最新出荷予定日時
            M_HNTOYTIME, -- メーカー最新到着予定日時
            -- M_HONOYTIME, -- メーカー前回納入予定日時
            -- M_HOTAYTIME, -- メーカー前回棚入予定日時
            -- M_HOSYYTIME, -- メーカー前回出荷予定日時
            -- M_HOTOYTIME, -- メーカー前回到着予定日時
            M_HSNOYTIME, -- メーカー初回納入予定日時
            -- M_HSTAYTIME, -- メーカー初回棚入予定日時
            M_HSSYYTIME, -- メーカー初回出荷予定日時
            -- M_HSTOYTIME, -- メーカー初回到着予定日時
            -- M_PTOPFLG, -- メーカーPTOPFLG
            -- M_IPSYYTMIE, -- メーカーインプット出荷予定日時
            M_MARTFLG, -- メーカーマル超FLG
            M_SYUKKAYMD, -- メーカー出荷日
            M_SYUKKASU, -- メーカー出荷数
            NYUKOYMD, -- ＴＭＰ入庫日
            NYUKOSU, -- ＴＭＰ入庫数
            M_KAKNOUKBN, -- メーカー格納拠点区分
            M_THIBUSYOCD, -- メーカー手配担当部署CD
            M_THITATOCD, -- メーカー手配担当者CD
            M_TEHAIKBN, -- メーカー手配区分
            M_KEIKANISSU, -- メーカー経過日数
            LDTS -- snapshot作成用
    from {{ref('dm_tmc_ippan_jutyunokikaito')}} -- TMC一般オーダー受注納期回答DM
    where SUBSTR(M_ORDENO,0,2) = 'ZZ' -- メーカーオーダーNO（先頭２桁）
),
tyoku as (
    select 
            M_DLRCD, -- メーカー仕向先CD
            M_YUSOKBN, -- メーカー輸送CD
            M_ORDENO, -- メーカー注文NO
            M_JUCHUYMD, -- メーカー受注日
            M_JHINBAN, -- メーカー受注品番
            -- M_JUCHUSU, -- メーカー受注数
            M_SYUBETSU, -- メーカーオーダー種別
            M_SHINBAN, -- メーカー出荷品番
            M_BOSU, -- メーカーBO数
            M_BOSKSTIME, -- メーカーBO作成日時
            M_HNNOYTIME, -- メーカー最新納入予定日時
            -- M_HNTAYTIME, -- メーカー最新棚入予定日時
            M_HNSYYTIME, -- メーカー最新出荷予定日時
            M_HNTOYTIME, -- メーカー最新到着予定日時
            -- M_HONOYTIME, -- メーカー前回納入予定日時
            -- M_HOTAYTIME, -- メーカー前回棚入予定日時
            -- M_HOSYYTIME, -- メーカー前回出荷予定日時
            -- M_HOTOYTIME, -- メーカー前回到着予定日時
            M_HSNOYTIME, -- メーカー初回納入予定日時
            -- M_HSTAYTIME, -- メーカー初回棚入予定日時
            M_HSSYYTIME, -- メーカー初回出荷予定日時
            -- M_HSTOYTIME, -- メーカー初回到着予定日時
            -- M_PTOPFLG, -- メーカーPTOPFLG
            -- M_IPSYYTMIE, -- メーカーインプット出荷予定日時
            M_MARTFLG, -- メーカーマル超FLG
            M_SYUKKAYMD, -- メーカー出荷日
            M_SYUKKASU, -- メーカー出荷数
            NYUKOYMD, -- ＴＭＰ入庫日
            NYUKOSU, -- ＴＭＰ入庫数
            M_KAKNOUKBN, -- メーカー格納拠点区分
            M_THIBUSYOCD, -- メーカー手配担当部署CD
            M_THITATOCD, -- メーカー手配担当者CD
            M_TEHAIKBN, -- メーカー手配区分
            M_KEIKANISSU, -- メーカー経過日数
            LDTS -- snapshot作成用
    from {{ref('dm_tmc_tyokuso_jutyunokikaito')}} -- TMC直送オーダー受注納期回答DM
    where SUBSTR(M_ORDENO,0,2) = 'ZZ' -- メーカーオーダーNO（先頭２桁）
)
select * from ippan
union
select * from tyoku