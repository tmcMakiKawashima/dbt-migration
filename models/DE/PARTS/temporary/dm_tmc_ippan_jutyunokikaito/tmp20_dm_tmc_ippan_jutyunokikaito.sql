with
    temp10 as (
        select * from {{ ref("tmp10_dm_tmc_ippan_jutyunokikaito") }}
        ),
    bonokikkaito as (
        select 
            ORDRKEY, -- オーダーキー
            JURRSYMD, -- 受注リリース日
            max(HNNOYTIME) HNNOYTIME, -- 最新納入予定日時
            max(HNSYYTIME) HNSYYTIME, -- 最新出荷予定日時
            max(HNTOYTIME) HNTOYTIME, -- 最新到着予定日時
            max(HSNOYTIME) HSNOYTIME, -- 初回納入予定日時
            max(HSSYYTIME) HSSYYTIME, -- 初回出荷予定日時
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
            max(IPSYYTMIE) IPSYYTMIE -- インプット出荷予定日時
        from {{ref('stg_dvnp0710')}} -- BO納期回答ファイル
        where KOKAGKBN = '1' -- 国内海外区分
        group by ORDRKEY -- オーダーキー
               , JURRSYMD -- 受注リリース日
        )
select
    temp10.*,
    bo.HNNOYTIME, -- 最新納入予定日時
    bo.HNSYYTIME, -- 最新出荷予定日時
    bo.HNTOYTIME, -- 最新到着予定日時
    bo.HSNOYTIME, -- 初回納入予定日時
    bo.HSSYYTIME, -- 初回出荷予定日時
    bo.PTOPFLG, -- PTOPFLG
    bo.HSKKBN, -- 初回回答区分
    bo.HSTAYTIME, -- 初回棚入予定日時
    bo.HSTOYTIME, -- 初回到着予定日時
    bo.HOKKBN, -- 前回回答区分
    bo.HONOYTIME, -- 前回納入予定日時
    bo.HOTAYTIME, -- 前回棚入予定日時
    bo.HOSYYTIME, -- 前回出荷予定日時
    bo.HOTOYTIME, -- 前回到着予定日時
    bo.MKAITOCD, -- 未回答ＣＤ
    bo.HNKKBN, -- 最新回答区分
    bo.HNTAYTIME, -- 最新棚入予定日時
    bo.IPSYYTMIE, -- インプット出荷予定日時
    bo.ORDRKEY as dvnp0710_ORDRKEY --オーダーキー nullチェック用
from temp10
left outer join bonokikkaito bo
on temp10.ORDRKEY = bo.ORDRKEY -- オーダーキー
and temp10.JUCHUYMD = bo.JURRSYMD -- 受注日/受注リリース日