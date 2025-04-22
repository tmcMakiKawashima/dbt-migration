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
with stg_furikomikoza_masta_judgev as (
    select
        trhkskkd::varchar(10) as trhkskkd, -- 取引先コード
        id::varchar(4) as id, -- ID
        kn::varchar(3) as kn, -- 国
        gnkkd::varchar(15) as gnkkd, -- 銀行コード
        gnkkz::varchar(18) as gnkkz, -- 銀行口座
        yknsybt::varchar(2) as yknsybt, -- 預金種別
        iban::varchar(34) as iban, -- IBAN
        snsysysi::varchar(20) as snsysysi, -- 参照詳細
        kzmgn::varchar(120) as kzmgn, -- 口座名義人
        ykkshdk::varchar(8) as ykkshdk, -- 有効開始日付
        yksryhdk::varchar(8) as yksryhdk, -- 有効終了日付
        hnkhdk::varchar(8) as hnkhdk, -- 変更日付
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta011')}}
    where to_varchar(ldts,'yyyymmdd') = ((select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta011')}}))
)
select * from stg_furikomikoza_masta_judgev
