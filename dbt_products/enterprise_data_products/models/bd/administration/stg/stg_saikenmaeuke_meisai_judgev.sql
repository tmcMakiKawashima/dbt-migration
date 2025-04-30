{{
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
}}

with stg_saikenmaeuke_meisai_judgev as (
    select
        snsid::varchar(21) as snsid, -- 申請ID
        msino::varchar(5) as msino, -- 明細NO
        mukno::varchar(9) as mukno, -- 前受NO
        kngk::varchar(16) as kngk, -- 金額
        hznjtkb::varchar(1) as hznjtkb, -- 保存状態区分
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta006')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') > (select to_varchar(coalesce(max(timestamp),'1970-01-01 00:00:00.000'),'yyyymmdd') from {{this}})
    {% endif %}

)
select * from stg_saikenmaeuke_meisai_judgev