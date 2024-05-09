{{ config(snowflake_warehouse='DBT_WH') }}

with ippan as (
    select * from {{ ref('dm_tmc_ippan_jutyunokikaito') }}
    where substr(m_ordeno,0,2) = 'ZZ' -- メーカーオーダーNO（先頭２桁）
),
tyoku as (
    select * exclude(m_nonuhikiatnis, m_jsksyseiymd) from {{ ref('dm_tmc_tyokuso_jutyunokikaito') }}
    where substr(m_ordeno,0,2) = 'ZZ' -- メーカーオーダーNO（先頭２桁）
      and m_jsksyseiymd = ''
)
select  
        m_dlrcd, -- メーカー仕向先cd
        m_yusokbn, -- メーカー輸送cd
        m_ordeno, -- メーカー注文no
        m_juchuymd, -- メーカー受注日
        m_jhinban, -- メーカー受注品番
        m_juchusu, -- メーカー受注数
        m_syubetsu, -- メーカーオーダー種別
        m_shinban, -- メーカー出荷品番
        m_bosu, -- メーカーbo数
        m_boskstime, -- メーカーbo作成日時
        m_hnnoytime, -- メーカー最新納入予定日時
        m_hntaytime, -- メーカー最新棚入予定日時
        m_hnsyytime, -- メーカー最新出荷予定日時
        m_hntoytime, -- メーカー最新到着予定日時
        m_honoytime, -- メーカー前回納入予定日時
        m_hotaytime, -- メーカー前回棚入予定日時
        m_hosyytime, -- メーカー前回出荷予定日時
        m_hotoytime, -- メーカー前回到着予定日時
        m_hsnoytime, -- メーカー初回納入予定日時
        m_hstaytime, -- メーカー初回棚入予定日時
        m_hssyytime, -- メーカー初回出荷予定日時
        m_hstoytime, -- メーカー初回到着予定日時
        m_ptopflg, -- メーカーptopflg
        m_ipsyytmie, -- メーカーインプット出荷予定日時
        m_martflg, -- メーカーマル超flg
        m_syukkaymd, -- メーカー出荷日
        m_syukkasu, -- メーカー出荷数
        nyukoymd, -- ｔｍｐ入庫日
        m_kaknoukbn, -- メーカー格納拠点区分
        m_thibusyocd, -- メーカー手配担当部署cd
        m_thitatocd, -- メーカー手配担当者cd
        m_tehaikbn, -- メーカー手配区分
        m_keikanissu, -- メーカー経過日数
        m_srsirskcd, -- 商流仕入先CD
        m_kozyocd, -- 工場CD
        m_brsirskcd, -- 物流仕入先CD
        m_nonukyokbn, -- 納入拠点区分
        m_zaihikbn, -- 在非区分
        m_cycle4, -- サイクル
        m_nonyult, -- 納入L/T
        m_brsirskkojocd, -- 物流仕入先工場CD
        m_pikcptime, -- 出庫完日時
        m_paktime, -- 梱完日時
        ldts -- snapshot作成用
from (select * from ippan union all select * from tyoku)