with jh as (
    select * from {{ref('stg_dvnp0680')}} -- オーダー情報ファイル
    where KOKAGKBN = '1' -- 国内海外区分
),
ss as (
    select
         ORDRKEY -- オーダーキー
        ,JUCHUYMD -- 受注日
        ,listagg(distinct(SHINBAN), ',') SHINBAN -- 出荷品番
        ,sum(BOSU) BOSU -- B_O数
        ,max(BOSKSTIME) BOSKSTIME -- B_O作成日時
        ,max(KAKNOUKBN) KAKUNOUKBN -- 格納拠点区分
    from {{ref('stg_dvnp0700')}} -- オーダー指示ステータスファイル
    group by ORDRKEY -- オーダーキー
           , JUCHUYMD -- 受注日
)
select 
     jh.ORDRKEY -- オーダーキー
    ,jh.DLRCD -- 仕向先CD
    ,jh.YUSOKBN -- 輸送CD
    ,jh.ODRNO -- オーダーNO
    ,jh.JUCHUYMD -- 受注日
    ,jh.JHINBAN -- 受注品番
    ,jh.SYUBETSU -- オーダー種別
    ,jh.JUCHUSU -- 受注数
    ,jh.RIMAK1 -- リマークⅠ
    ,jh.RIMAK2 -- リマークⅡ
    ,ss.SHINBAN -- 出荷品番
    ,ss.BOSU -- B_O数
    ,ss.BOSKSTIME -- B_O作成日時
    ,ss.KAKUNOUKBN -- 格納拠点区分
    ,ss.ORDRKEY as check_ORDRKEY --オーダーキー　nullチェック用
    ,jh.LDTS -- snapshot作成用
from jh
left outer join ss
on jh.ORDRKEY = ss.ORDRKEY -- オーダーキー
and jh.JUCHUYMD = ss.JUCHUYMD -- 受注日