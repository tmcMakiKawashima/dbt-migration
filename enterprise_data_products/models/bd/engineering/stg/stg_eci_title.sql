{{ 
  config(
    materialized='incremental',
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

with stg_eci_title as (
    select
        seppenno::varchar(10) as seppenno, -- 設変No.
        dbuhin::varchar(40) as dbuhin, -- 代表部品名
        rf1::varchar(1) as rf1, -- R/C･F/F切替制約A
        rf2::varchar(1) as rf2, -- R/C･F/F切替制約B
        rf3::varchar(1) as rf3, -- R/C･F/F切替制約C
        rf4::varchar(1) as rf4, -- R/C･F/F切替制約D
        rf5::varchar(1) as rf5, -- R/C･F/F切替制約E
        rfno::varchar(14) as rfno, -- R/C･F/F申請No.
        rfwvta::varchar(2) as rfwvta, -- R/C･F/F WVTA
        rfcoc::varchar(2) as rfcoc, -- R/C・F/F 中国COC識別
        rfsyasyu::varchar(4) as rfsyasyu, -- R/C･F/F車種
        rfsonotajp::varchar(50) as rfsonotajp, -- R/C･F/Fその他日本語
        rfsonotaen::varchar(100) as rfsonotaen, -- R/C･F/Fその他英語
        renraku1jp::varchar(20) as renraku1jp, -- 事前連絡1（日本語）
        renraku1en::varchar(40) as renraku1en, -- 事前連絡1（英語）
        renraku2jp::varchar(20) as renraku2jp, -- 事前連絡2（日本語）
        renraku2en::varchar(40) as renraku2en, -- 事前連絡2（英語）
        renraku3jp::varchar(20) as renraku3jp, -- 事前連絡3（日本語）
        renraku3en::varchar(40) as renraku3en, -- 事前連絡3（英語）
        genka::varchar(1) as genka, -- 原価変動
        eibumei::varchar(46) as eibumei, -- 英文設計室名称
        mttime::varchar(16) as mttime, -- MT日時
        _fivetran_synced::timestamp_ntz(9) as ldts -- B層取込日時
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp17ecititle') }}
    where _fivetran_deleted = 'false'
)
select * from stg_eci_title
