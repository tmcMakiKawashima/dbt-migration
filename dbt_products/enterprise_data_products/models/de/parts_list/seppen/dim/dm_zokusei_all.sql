{{ 
  config(
    materialized='incremental',
    unique_key = ['seppenno'],
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

with zok as(
    select
        seppenno, -- 設変№
        sepsyurui, -- 設変書種類
        hakkotime, -- 発行日時
        hakkositu, -- 発行設計室
        hakkotanto, -- 発行担当者
        tel, -- 発行TEL
        fax -- 発行FAX
    from {{source('engineering_db_public','raw_tmp_m_cyp16ecizokusei')}}
), ttl as(
    select
        seppenno, -- 設変No.
        dbuhin, -- 代表部品名
        rf1, -- R/C･F/F切替制約A
        rf2, -- R/C･F/F切替制約B
        rf3, -- R/C･F/F切替制約C
        rf4, -- R/C･F/F切替制約D
        rf5, -- R/C･F/F切替制約E
        rfno, -- R/C･F/F申請No.
        rfwvta, -- R/C･F/F WVTA
        rfcoc, -- R/C・F/F 中国COC識別
        rfsyasyu, -- R/C･F/F車種
        rfsonotajp, -- R/C･F/Fその他日本語
        rfsonotaen, -- R/C･F/Fその他英語
        renraku1jp, -- 事前連絡1（日本語）
        renraku1en, -- 事前連絡1（英語）
        renraku2jp, -- 事前連絡2（日本語）
        renraku2en, -- 事前連絡2（英語）
        renraku3jp, -- 事前連絡3（日本語）
        renraku3en, -- 事前連絡3（英語）
        eibumei -- 英文設計室名称
    from {{ref('stg_eci_title')}}
), kan as(
    select
        jigyoutai, -- 生産事業体
        seppenno, -- 設変No.
        torokutime, -- 登録生認日時
    from {{ref('stg_eci_seppenkan')}}
), zok_ttl as(
    select
        zok.seppenno as seppenno, -- 設変№
        zok.sepsyurui,-- 設変書種類
        zok.hakkotime, -- 発行日時
        zok.hakkositu, -- 発行設計室
        zok.hakkotanto, -- 発行担当者
        zok.tel, -- 発行TEL
        zok.fax, -- 発行FAX
        ttl.dbuhin, -- 代表部品名
        ttl.rf1, -- R/C･F/F切替制約A
        ttl.rf2, -- R/C･F/F切替制約B
        ttl.rf3, -- R/C･F/F切替制約C
        ttl.rf4, -- R/C･F/F切替制約D
        ttl.rf5, -- R/C･F/F切替制約E
        ttl.rfno, -- R/C･F/F申請No.
        ttl.rfwvta, -- R/C･F/F WVTA
        ttl.rfcoc, -- R/C・F/F 中国COC識別
        ttl.rfsyasyu, -- R/C･F/F車種
        ttl.rfsonotajp, -- R/C･F/Fその他日本語
        ttl.rfsonotaen, -- R/C･F/Fその他英語
        ttl.renraku1jp, -- 事前連絡1（日本語）
        ttl.renraku1en, -- 事前連絡1（英語）
        ttl.renraku2jp, -- 事前連絡2（日本語）
        ttl.renraku2en, -- 事前連絡2（英語）
        ttl.renraku3jp, -- 事前連絡3（日本語）
        ttl.renraku3en, -- 事前連絡3（英語）
        ttl.eibumei -- 英文設計室名称
    from zok
    left join ttl
    on(
        zok.seppenno = ttl.seppenno
    )
)
select
    coalesce(zok_ttl.seppenno, rpad('', 10))::varchar(10) as seppenno, -- 設変No.
    coalesce(zok_ttl.sepsyurui, rpad('', 2))::varchar(2) as sepsyurui, -- 設変書種類
    coalesce(zok_ttl.hakkotime , rpad('', 14))::varchar(14) as hakkotime , -- 発行日時
    coalesce(zok_ttl.hakkositu, rpad('', 5))::varchar(5) as hakkositu, -- 発行設計室
    coalesce(zok_ttl.hakkotanto, rpad('', 10))::varchar(10) as hakkotanto, -- 発行担当者
    coalesce(zok_ttl.tel, rpad('', 12))::varchar(12) as tel, -- 発行TEL
    coalesce(zok_ttl.fax, rpad('', 12))::varchar(12) as fax, -- 発行FAX
    coalesce(zok_ttl.dbuhin, rpad('', 40))::varchar(40) as dbuhin, -- 代表部品名
    coalesce(zok_ttl.rf1, rpad('', 1))::varchar(1) as rf1, -- R/C･F/F切替制約A
    coalesce(zok_ttl.rf2, rpad('', 1))::varchar(1) as rf2, -- R/C･F/F切替制約B
    coalesce(zok_ttl.rf3, rpad('', 1))::varchar(1) as rf3, -- R/C･F/F切替制約C
    coalesce(zok_ttl.rf4, rpad('', 1))::varchar(1) as rf4, -- R/C･F/F切替制約D
    coalesce(zok_ttl.rf5, rpad('', 1))::varchar(1) as rf5, -- R/C･F/F切替制約E
    coalesce(zok_ttl.rfno, rpad('', 14))::varchar(14) as rfno, -- R/C･F/F申請No.
    coalesce(zok_ttl.rfwvta, rpad('', 2))::varchar(2) as rfwvta, -- R/C･F/F WVTA
    coalesce(zok_ttl.rfcoc, rpad('', 2))::varchar(2) as rfcoc, -- R/C・F/F 中国COC識別
    coalesce(zok_ttl.rfsyasyu, rpad('', 4))::varchar(4) as rfsyasyu, -- R/C･F/F車種
    coalesce(zok_ttl.rfsonotajp, rpad('', 50))::varchar(50) as rfsonotajp, -- R/C･F/Fその他日本語
    coalesce(zok_ttl.rfsonotaen, rpad('', 100))::varchar(100) as rfsonotaen, -- R/C･F/Fその他英語
    coalesce(zok_ttl.renraku1jp, rpad('', 20))::varchar(20) as renraku1jp, -- 事前連絡1（日本語）
    coalesce(zok_ttl.renraku1en, rpad('', 40))::varchar(40) as renraku1en, -- 事前連絡1（英語）
    coalesce(zok_ttl.renraku2jp, rpad('', 20))::varchar(20) as renraku2jp, -- 事前連絡2（日本語）
    coalesce(zok_ttl.renraku2en, rpad('', 40))::varchar(40) as renraku2en, -- 事前連絡2（英語）
    coalesce(zok_ttl.renraku3jp, rpad('', 20))::varchar(20) as renraku3jp, -- 事前連絡3（日本語）
    coalesce(zok_ttl.renraku3en, rpad('', 40))::varchar(40) as renraku3en, -- 事前連絡3（英語）
    coalesce(zok_ttl.eibumei, rpad('', 46))::varchar(46) as eibumei, -- 英文設計室名称
    coalesce(kan.torokutime, rpad('', 16))::varchar(16) as torokutime, -- 登録生認日時
    current_timestamp()::timestamp_ntz(9) as ldts -- 最終更新日時
from zok_ttl
left join kan
on(
    zok_ttl.seppenno = kan.seppenno
and kan.jigyoutai = '  '
)