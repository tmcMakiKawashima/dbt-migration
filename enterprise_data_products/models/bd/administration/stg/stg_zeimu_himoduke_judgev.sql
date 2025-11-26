{{ 
  config(
    materialized='incremental',
    incremental_strategy = 'append',
    transient = false
  )
 }}

with stg_zeimu_himoduke_judgev as (
    select
        snsid::varchar(21) as snsid, -- 申請ID
        trhkmsino::varchar(5) as trhkmsino, -- 取引明細NO
        zmjhsnsid::varchar(21) as zmjhsnsid, -- 税務情報申請ID
        zmjhedbn::varchar(3) as zmjhedbn, -- 税務情報枝番
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta019')}}
    {% if is_incremental() %}
        where to_varchar(ldts,'yyyymmdd') > (select to_varchar(coalesce(max(timestamp),'1970-01-01 00:00:00.000'),'yyyymmdd') from {{this}})
    {% endif %}
)
select * from stg_zeimu_himoduke_judgev
