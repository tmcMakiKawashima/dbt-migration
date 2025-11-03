{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
 }}

with stg_busyo_meisai_judgev as (
    select
        snsid::varchar(21) as snsid, -- 申請ID
        trhkmsino::varchar(5) as trhkmsino, -- 取引明細NO
        bsymsino::varchar(5) as bsymsino, -- 部署明細NO
        ftnbsykd::varchar(10) as ftnbsykd, -- 負担部署コード
        ftnbsymi::varchar(40) as ftnbsymi, -- 負担部署名
        ysnbsykd::varchar(10) as ysnbsykd, -- 予算部署コード
        ysnbsymi::varchar(40) as ysnbsymi, -- 予算部署名
        prjktkd::varchar(3) as prjktkd, -- プロジェクトコード
        prjktmi::varchar(80) as prjktmi, -- プロジェクト名
        anknkd::varchar(5) as anknkd, -- 案件コード
        anknmi::varchar(30) as anknmi, -- 案件名
        sysykd::varchar(3) as sysykd, -- 車種コード
        sysymi::varchar(20) as sysymi, -- 車種名
        syhzkb::varchar(2) as syhzkb, -- 消費税区分
        syhzkbmi::varchar(100) as syhzkbmi, -- 消費税区分名
        zkmzbtkb::varchar(1) as zkmzbtkb, -- 税込税別区分
        zkmzbtkbmi::varchar(40) as zkmzbtkbmi, -- 税込税別区分名
        hntigkttn::varchar(16) as hntigkttn, -- 本体額_建値
        syhzgkttn::varchar(16) as syhzgkttn, -- 消費税額_建値
        zkmgkttn::varchar(16) as zkmgkttn, -- 税込額_建値
        hntigkenk::varchar(16) as hntigkenk, -- 本体額_円貨
        syhzgkenk::varchar(16) as syhzgkenk, -- 消費税額_円貨
        zkmgkenk::varchar(16) as zkmgkenk, -- 税込額_円貨
        nysyknhntigkttn::varchar(16) as nysyknhntigkttn, -- 入出金_本体額_建値
        nysyknsyhzgkttn::varchar(16) as nysyknsyhzgkttn, -- 入出金_消費税額_建値
        nysyknzkmgkttn::varchar(16) as nysyknzkmgkttn, -- 入出金_税込額_建値
        nysyknhntigkenk::varchar(16) as nysyknhntigkenk, -- 入出金_本体額_円貨
        nysyknsyhzgkenk::varchar(16) as nysyknsyhzgkenk, -- 入出金_消費税額_円貨
        nysyknzkmgkenk::varchar(16) as nysyknzkmgkenk, -- 入出金_税込額_円貨
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta018')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') > (select to_varchar(coalesce(max(timestamp),'1970-01-01 00:00:00.000'),'yyyymmdd') from {{this}})
    {% endif %}
)
select * from stg_busyo_meisai_judgev
