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
-- 洗い替え処理で常に最新断面のみとするためpre_hookで全件削除する処理を記載
with stg_torihikitanto_kaigai_masta_judgev as (
    select
        bsykd::varchar(5) as bsykd, -- 部署コード
        trhkskkd::varchar(10) as trhkskkd, -- 取引先コード
        jsykd::varchar(3) as jsykd, -- 住所コード
        trhkskjsy::varchar(70) as trhkskjsy, -- 取引先住所
        trhkskbsymi::varchar(50) as trhkskbsymi, -- 取引先部署名
        trhksktntsmi::varchar(30) as trhksktntsmi, -- 取引先担当者名
        trhkskmradr::varchar(150) as trhkskmradr, -- 取引先メールアドレス
        synngp::varchar(8) as synngp, -- 使用年月日
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta012')}}
    where to_varchar(ldts,'yyyymmdd') = ((select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta012')}}))
)
select * from stg_torihikitanto_kaigai_masta_judgev
