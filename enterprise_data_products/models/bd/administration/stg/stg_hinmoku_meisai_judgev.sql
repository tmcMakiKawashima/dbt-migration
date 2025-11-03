{{
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
}}

with stg_hinmoku_meisai_judgev as (
    select
        snsid::varchar(21) as snsid, -- 申請ID
        msino::varchar(6) as msino, -- 明細NO
        tky::varchar(80) as tky, -- 摘要
        hnbnkd::varchar(13) as hnbnkd, -- 品番コード
        hnbnmi::varchar(80) as hnbnmi, -- 品番名
        ksktsk::varchar(20) as ksktsk, -- 呼称型式
        sry::varchar(14) as sry, -- 数量
        srytnimsy::varchar(3) as srytnimsy, -- 数量単位名称
        prntkd::varchar(4) as prntkd, -- プラントコード
        prntmi::varchar(60) as prntmi, -- プラント名
        syhzkb::varchar(2) as syhzkb, -- 消費税区分
        syhzkbmsy::varchar(100) as syhzkbmsy, -- 消費税区分名称
        syhzryksy::varchar(100) as syhzryksy, -- 消費税略称
        hntigk::varchar(16) as hntigk, -- 本体額
        syhzgk::varchar(16) as syhzgk, -- 消費税額
        zkmgk::varchar(16) as zkmgk, -- 税込額
        zkmzbtkb::varchar(1) as zkmzbtkb, -- 税込税別区分
        zkmzbtkbmsy::varchar(4) as zkmzbtkbmsy, -- 税込税別区分名称
        zrt::varchar(5) as zrt, -- 税率
        hnmkmsinyrykkb::varchar(1) as hnmkmsinyrykkb, -- 品目明細入力区分
        hznjtkb::varchar(1) as hznjtkb, -- 保存状態区分
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta009')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') > (select to_varchar(coalesce(max(timestamp),'1970-01-01 00:00:00.000'),'yyyymmdd') from {{this}})
    {% endif %}
)
select * from stg_hinmoku_meisai_judgev
