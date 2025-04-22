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

with stg_seikyusofu_kokunai_masta_judgev as (
    select
        bsykd2kt::varchar(2) as bsykd2kt, -- 部署コード(上2桁)
        trhkskkd::varchar(10) as trhkskkd, -- 取引先コード
        jsykd::varchar(3) as jsykd, -- 住所コード
        sfskybnbng::varchar(7) as sfskybnbng, -- 送付先郵便番号
        sfskjsy::varchar(60) as sfskjsy, -- 送付先住所
        sfskbsy::varchar(32) as sfskbsy, -- 送付先部署
        sfsktnts::varchar(20) as sfsktnts, -- 送付先担当者
        sfskmradr::varchar(150) as sfskmradr, -- 送付先メールアドレス
        synngp::varchar(8) as synngp, -- 使用年月日
        sisyksnsy::varchar(10) as sisyksnsy, -- 最終更新者
        sisyksnsysyzkbsykd::varchar(5) as sisyksnsysyzkbsykd, -- 最終更新者所属部署コード
        mtuser::varchar(13) as mtuser, -- 更新ユーザーID
        mttime::varchar(26) as mttime, -- 更新日時
        recvdate::varchar(8) as recvdate, -- 受信日
        current_timestamp()::timestamp_ntz as timestamp -- タイムスタンプ
    from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta013')}}
    where to_varchar(ldts,'yyyymmdd') = ((select to_varchar(max(ldts),'yyyymmdd') from {{source('snowpipe_db_administration', 'raw_ktrla02kzz0kgta013')}}))
)
select * from stg_seikyusofu_kokunai_masta_judgev
