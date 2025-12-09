{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
 }}

with stg_kosaihijizen_meisai_judgev as (
    select
        snsid::varchar(21) as snsid, -- 申請ID
        kshkghjznsnsmsino::varchar(4) as kshkghjznsnsmsino, -- 交際費会議費事前申請明細NO
        kskghntrykb::varchar(2) as kskghntrykb, -- 交際会議_判定理由区分
        kskghntrykbmi::varchar(40) as kskghntrykbmi, -- 交際会議_判定理由区分名
        kskgniy::varchar(40) as kskgniy, -- 交際会議_内容
        kskgbsy::varchar(50) as kskgbsy, -- 交際会議_場所
        kskgmygks::varchar(6) as kskgmygks, -- 交際会議_土産個数
        kskgbk::varchar(40) as kskgbk, -- 交際会議_備考
        kskgkkhsbi::varchar(8) as kskgkkhsbi, -- 交際会議_効果発生日
        kskgtsysnknz::varchar(6) as kskgtsysnknz, -- 交際会議_当社参加人数
        kskgtsyftntsynz::varchar(6) as kskgtsyftntsynz, -- 交際会議_当社負担当社人数
        kskgtsytnts::varchar(30) as kskgtsytnts, -- 交際会議_当社担当者
        kskgsnpsnknz::varchar(6) as kskgsnpsnknz, -- 交際会議_先方参加人数
        kskgtsyftnsnpnz::varchar(6) as kskgtsyftnsnpnz, -- 交際会議_当社負担先方人数
        kskgaitskkisymi::varchar(80) as kskgaitskkisymi, -- 交際会議_相手先会社名
        kskgaitsksmi::varchar(50) as kskgaitsksmi, -- 交際会議_相手先氏名
        kskgkminngihkb::varchar(1) as kskgkminngihkb, -- 交際会議_公務員の該非区分
        kskgkminngihkbmi::varchar(40) as kskgkminngihkbmi, -- 交際会議_公務員の該非区分名
        kskgtsytnknk::varchar(40) as kskgtsytnknk, -- 交際会議_当社との関係
        syhzkb::varchar(2) as syhzkb, -- 消費税区分
        syhzkbmi::varchar(100) as syhzkbmi, -- 消費税区分名
        zkmzbtkb::varchar(1) as zkmzbtkb, -- 税込税別区分
        zkmzbtkbmi::varchar(40) as zkmzbtkbmi, -- 税込税別区分名
        hntigkenk::varchar(16) as hntigkenk, -- 本体額_円貨
        syhzgkenk::varchar(16) as syhzgkenk, -- 消費税額_円貨
        zkmgkenk::varchar(16) as zkmgkenk, -- 税込額_円貨
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta017')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') > (select to_varchar(coalesce(max(timestamp),'1970-01-01 00:00:00.000'),'yyyymmdd') from {{this}})
    {% endif %}
)
select * from stg_kosaihijizen_meisai_judgev
