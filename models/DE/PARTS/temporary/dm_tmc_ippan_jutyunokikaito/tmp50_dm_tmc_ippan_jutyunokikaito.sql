with temp30 as (
    select
        DLRCD, -- 仕向先CD
        YUSOKBN, -- 輸送CD
        ODRNO, -- オーダーNO
        JUCHUYMD, -- 受注日
        JHINBAN, -- 受注品番
        SYUBETSU, -- オーダー種別
        listagg(distinct(SHINBAN), ',') SHINBAN, -- 出荷品番
        sum(BOSU) BOSU, -- B_O数
        max(BOSKSTIME) BOSKSTIME, -- B_O作成日時
        max(HNNOYTIME) HNNOYTIME, -- 最新納入予定日時
        max(HNSYYTIME) HNSYYTIME, -- 最新出荷予定日時
        max(HNTOYTIME) HNTOYTIME, -- 最新到着予定日時
        max(HSNOYTIME) HSNOYTIME, -- 初回納入予定日時
        max(HSSYYTIME) HSSYYTIME, -- 初回出荷予定日時
        max(MARTFLG) MARTFLG, -- マル超FLG
        sum(JUCHUSU) JUCHUSU, -- 受注数
        max(RIMAK1) RIMAK1, -- リマークⅠ
        max(RIMAK2) RIMAK2, -- リマークⅡ
        max(PTOPFLG) PTOPFLG, -- PTOPFLG
        max(HSKKBN) HSKKBN, -- 初回回答区分
        max(HSTAYTIME) HSTAYTIME, -- 初回棚入予定日時
        max(HSTOYTIME) HSTOYTIME, -- 初回到着予定日時
        max(HOKKBN) HOKKBN, -- 前回回答区分
        max(HONOYTIME) HONOYTIME, -- 前回納入予定日時
        max(HOTAYTIME) HOTAYTIME, -- 前回棚入予定日時
        max(HOSYYTIME) HOSYYTIME, -- 前回出荷予定日時
        max(HOTOYTIME) HOTOYTIME, -- 前回到着予定日時
        max(MKAITOCD) MKAITOCD, -- 未回答ＣＤ
        max(HNKKBN) HNKKBN, -- 最新回答区分
        max(HNTAYTIME) HNTAYTIME, -- 最新棚入予定日時
        max(IPSYYTMIE) IPSYYTMIE, -- インプット出荷予定日時
        KAKUNOUKBN, -- 格納拠点区分
        SIIRECD -- 仕入先CD
    from {{ref('tmp30_dm_tmc_ippan_jutyunokikaito')}}
    group by 
          DLRCD -- 仕向先CD
        , YUSOKBN -- 輸送CD
        , ODRNO -- オーダーNO
        , JUCHUYMD -- 受注日
        , JHINBAN -- 受注品番
        , SYUBETSU -- オーダー種別
        , KAKUNOUKBN -- 格納拠点区分
        , SIIRECD -- 仕入先CD
),
temp40 as (
    select
        sum(NYUKOSU) NYUKOSU, -- 入庫数
        max(NYUKOYMD) NYUKOYMD, -- 入庫日
        DLRCD, -- 仕向先CD
        ORDESYBT, -- オーダー種別
        YUSOKBN, -- 輸送CD
        ORDENO, -- 注文NO
        JHINBAN, -- 受注品番
        JUCHUYMD, -- 受注日
        sum(SYUKKASU) SYUKKASU, -- 出荷数
        max(SYUKKAYMD) SYUKKAYMD -- 出荷日
    from {{ref('tmp40_dm_tmc_ippan_jutyunokikaito')}}
    group by
          DLRCD -- 仕向先CD
        , ORDESYBT -- オーダー種別
        , YUSOKBN -- 輸送CD
        , ORDENO -- 注文NO
        , JHINBAN -- 受注品番
        , JUCHUYMD -- 受注日
)
select temp30.*
     , temp40.NYUKOSU -- 入庫数
     , temp40.NYUKOYMD -- 入庫日
     , temp40.SYUKKASU -- 出荷数
     , temp40.SYUKKAYMD -- 出荷日
     , temp40.DLRCD as check_DLRCD --仕向先CD nullチェック用
from temp30
left outer join temp40
on temp30.DLRCD = temp40.DLRCD -- 仕向先CD
and temp30.SYUBETSU = temp40.ORDESYBT -- オーダー種別
and temp30.YUSOKBN = temp40.YUSOKBN -- 輸送CD
and temp30.ODRNO = temp40.ORDENO -- オーダーNO
and temp30.JUCHUYMD = temp40.JUCHUYMD -- 受注日
and temp30.JHINBAN = temp40.JHINBAN-- 受注品番
