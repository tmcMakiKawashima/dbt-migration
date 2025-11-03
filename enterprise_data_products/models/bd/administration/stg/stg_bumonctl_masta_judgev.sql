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

with stg_bumonctl_masta_judgev as (
    select
        ysnkb::varchar(2) as ysnkb, -- 予算区分
        ysnbmnkd::varchar(5) as ysnbmnkd, -- 予算部門コード
        tkyksbi::varchar(8) as tkyksbi, -- 適用開始日
        trkkd::varchar(5) as trkkd, -- 登録コード
        bukd::varchar(5) as bukd, -- 部コード
        sktbsykd::varchar(5) as sktbsykd, -- 総括部署コード
        bmnkb::varchar(2) as bmnkb, -- 部門区分
        tkysrybi::varchar(8) as tkysrybi, -- 適用終了日
        ksnbi::varchar(8) as ksnbi, -- 更新日
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp::timestamp as timestamp -- タイムスタンプ
    from {{ source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta023') }}
   where to_varchar(ldts,'yyyymmdd') = (select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta023')}})
)
select * from stg_bumonctl_masta_judgev