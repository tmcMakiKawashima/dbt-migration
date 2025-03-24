
{{ 
  config(
    materialized='incremental',
    unique_key = ['seppenno','jun'],
    incremental_strategy = 'append',
    transient = false,
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
 }}
-- 洗い替えであるため、pre_hookで全件削除を行う。

with hin as(
    select
        seppenno,--設変№
        jun,--順
        ecikbn,--区分
        olvl,--旧レベル
        nlvl,--新レベル
        ogc,--旧GC
        ngc,--新GC
        hokyukbn,--補給
        ohinban,--旧品番
        ominor,--旧マイナー
        nhinban,--新品番
        nminor,--新マイナー
        okosu,--旧個数
        nkosu,--新個数
        osentaku,--旧選択
        nsentaku,--新選択
        hinmei,--品名
        hyougo1,--変更用語Ⅰ
        hyougo2,--変更用語Ⅱ
        sonotajp,--その他（日本語）
        sonotaen,--その他（英語）
        cond,--Condition
        mototaio,--元対応
        ninsyo--認証
    from {{source('engineering_db_public', 'raw_stg_eci_hinban') }}
    --from {{ref('stg_eci_hinban')}}
),stz as(
    select
        seppenno,--設変№
        jun,--順
        kokunaizu,--紙図面/2DCAD国内
        kaigaizu,--紙図面/2DCAD海外
        cadzu,--3DCAD
        rddp1,--RDDP№1
        gojitu1,--後日出図予定日1
        rddp2,--RDDP№2
        gojitu2,--後日出図予定日2
        rddp3,--RDDP№3
        gojitu3,--後日出図予定日3
        rddp4,--RDDP№4
        gojitu4,--後日出図予定日4
        rddp5,--RDDP№5
        gojitu5,--後日出図予定日5
        rddp6,--RDDP№6
        gojitu6,--後日出図予定日6
        rddp7,--RDDP№7
        gojitu7,--後日出図予定日7
        rddp8,--RDDP№8
        gojitu8,--後日出図予定日8
        rddp9,--RDDP№9
        gojitu9,--後日出図予定日9
        rddp10,--RDDP№10
        gojitu10--後日出図予定日10
    from {{source('engineering_db_public', 'raw_stg_eci_syutuzu') }}
--from {{ref('stg_eci_syutuzu')}}
)
select
    hin.*,
    stz.* exclude(seppenno,jun) ,
    current_timestamp()::timestamp_ntz(9) as load_date -- 最終更新日時
from hin
left join stz
on(
    hin.seppenno = stz.seppenno
and hin.jun = stz.jun    
)