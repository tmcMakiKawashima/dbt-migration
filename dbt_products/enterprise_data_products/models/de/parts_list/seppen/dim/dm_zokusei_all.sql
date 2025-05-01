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
)
select
    zok.*,
    coalesce(ttl.dbuhin, rpad('', 40))::varchar(40) as dbuhin, -- 代表部品名
    coalesce(ttl.rf1, rpad('', 1))::varchar(1) as rf1, -- R/C･F/F切替制約A
    coalesce(ttl.rf2, rpad('', 1))::varchar(1) as rf2, -- R/C･F/F切替制約B
    coalesce(ttl.rf3, rpad('', 1))::varchar(1) as rf3, -- R/C･F/F切替制約C
    coalesce(ttl.rf4, rpad('', 1))::varchar(1) as rf4, -- R/C･F/F切替制約D
    coalesce(ttl.rf5, rpad('', 1))::varchar(1) as rf5, -- R/C･F/F切替制約E
    coalesce(ttl.rfno, rpad('', 14))::varchar(14) as rfno, -- R/C･F/F申請No.
    coalesce(ttl.rfwvta, rpad('', 2))::varchar(2) as rfwvta, -- R/C･F/F WVTA
    coalesce(ttl.rfcoc, rpad('', 2))::varchar(2) as rfcoc, -- R/C・F/F 中国COC識別
    coalesce(ttl.rfsyasyu, rpad('', 4))::varchar(4) as rfsyasyu, -- R/C･F/F車種
    coalesce(ttl.rfsonotajp, rpad('', 50))::varchar(50) as rfsonotajp, -- R/C･F/Fその他日本語
    coalesce(ttl.rfsonotaen, rpad('', 100))::varchar(100) as rfsonotaen, -- R/C･F/Fその他英語
    coalesce(ttl.renraku1jp, rpad('', 20))::varchar(20) as renraku1jp, -- 事前連絡1（日本語）
    coalesce(ttl.renraku1en, rpad('', 40))::varchar(40) as renraku1en, -- 事前連絡1（英語）
    coalesce(ttl.renraku2jp, rpad('', 20))::varchar(20) as renraku2jp, -- 事前連絡2（日本語）
    coalesce(ttl.renraku2en, rpad('', 40))::varchar(40) as renraku2en, -- 事前連絡2（英語）
    coalesce(ttl.renraku3jp, rpad('', 20))::varchar(20) as renraku3jp, -- 事前連絡3（日本語）
    coalesce(ttl.renraku3en, rpad('', 40))::varchar(40) as renraku3en, -- 事前連絡3（英語）
    coalesce(ttl.eibumei, rpad('', 46))::varchar(46) as eibumei, -- 英文設計室名称
    coalesce(kan.torokutime, rpad('', 16))::varchar(16) as torokutime, -- 登録生認日時
    current_timestamp()::timestamp_ntz(9) as ldts -- 最終更新日時
from zok
left join ttl
on(
    zok.seppenno = ttl.seppenno
)
left join kan
on(
    zok.seppenno = kan.seppenno
and kan.jigyoutai = '  '
)