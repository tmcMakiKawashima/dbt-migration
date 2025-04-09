
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
    from {{ref('stg_eci_hinban')}}
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
    from {{ref('stg_eci_syutuzu')}}
)
select
    hin.*,
    coalesce(stz.kokunaizu, rpad('', 2))::varchar(2) as kokunaizu,
    coalesce(stz.kaigaizu, rpad('', 2))::varchar(2) as kaigaizu,
    coalesce(stz.cadzu, rpad('', 2))::varchar(2) as cadzu,
    coalesce(stz.rddp1, rpad('', 10))::varchar(10) as rddp1,
    coalesce(stz.gojitu1, rpad('', 8))::varchar(8) as gojitu1,
    coalesce(stz.rddp2, rpad('', 10))::varchar(10) as rddp2,
    coalesce(stz.gojitu2, rpad('', 8))::varchar(8) as gojitu2,
    coalesce(stz.rddp3, rpad('', 10))::varchar(10) as rddp3,
    coalesce(stz.gojitu3, rpad('', 8))::varchar(8) as gojitu3,
    coalesce(stz.rddp4, rpad('', 10))::varchar(10) as rddp4,
    coalesce(stz.gojitu4, rpad('', 8))::varchar(8) as gojitu4,
    coalesce(stz.rddp5, rpad('', 10))::varchar(10) as rddp5,
    coalesce(stz.gojitu5, rpad('', 8))::varchar(8) as gojitu5,
    coalesce(stz.rddp6, rpad('', 10))::varchar(10) as rddp6,
    coalesce(stz.gojitu6, rpad('', 8))::varchar(8) as gojitu6,
    coalesce(stz.rddp7, rpad('', 10))::varchar(10) as rddp7,
    coalesce(stz.gojitu7, rpad('', 8))::varchar(8) as gojitu7,
    coalesce(stz.rddp8, rpad('', 10))::varchar(10) as rddp8,
    coalesce(stz.gojitu8, rpad('', 8))::varchar(8) as gojitu8,
    coalesce(stz.rddp9, rpad('', 10))::varchar(10) as rddp9,
    coalesce(stz.gojitu9, rpad('', 8))::varchar(8) as gojitu9,
    coalesce(stz.rddp10, rpad('', 10))::varchar(10) as rddp10,
    coalesce(stz.gojitu10, rpad('', 8))::varchar(8) as gojitu10,
    current_timestamp()::timestamp_ntz(9) as load_date -- 最終更新日時
from hin
left join stz
on(
    hin.seppenno = stz.seppenno
and hin.jun = stz.jun    
)