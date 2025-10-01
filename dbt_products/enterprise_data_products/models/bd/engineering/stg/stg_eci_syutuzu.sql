{{ 
  config(
    materialized='incremental',
    unique_key = ['seppenno','jun'],
    incremental_strategy = 'append',
    transient = false,
    pre_hook="
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
 }}
 --洗い替えのため先に全件削除する処理
 
with stg_eci_syutuzu as (
    select
        seppenno32::varchar(2) as seppenno32, -- 設変No.3,2
        seppenno::varchar(10) as seppenno, -- 設変No.
        jun::varchar(4) as jun, -- 順
        kokunaizu::varchar(2) as kokunaizu, -- 紙図面/2DCAD国内
        kaigaizu::varchar(2) as kaigaizu, -- 紙図面/2DCAD海外
        cadzu::varchar(2) as cadzu, -- 3DCAD
        rddp1::varchar(10) as rddp1, -- RDDPNo.1
        gojitu1::varchar(8) as gojitu1, -- 後日出図予定日1
        rddp2::varchar(10) as rddp2, -- RDDPNo.2
        gojitu2::varchar(8) as gojitu2, -- 後日出図予定日2
        rddp3::varchar(10) as rddp3, -- RDDPNo.3
        gojitu3::varchar(8) as gojitu3, -- 後日出図予定日3
        rddp4::varchar(10) as rddp4, -- RDDPNo.4
        gojitu4::varchar(8) as gojitu4, -- 後日出図予定日4
        rddp5::varchar(10) as rddp5, -- RDDPNo.5
        gojitu5::varchar(8) as gojitu5, -- 後日出図予定日5
        rddp6::varchar(10) as rddp6, -- RDDPNo.6
        gojitu6::varchar(8) as gojitu6, -- 後日出図予定日6
        rddp7::varchar(10) as rddp7, -- RDDPNo.7
        gojitu7::varchar(8) as gojitu7, -- 後日出図予定日7
        rddp8::varchar(10) as rddp8, -- RDDPNo.8
        gojitu8::varchar(8) as gojitu8, -- 後日出図予定日8
        rddp9::varchar(10) as rddp9, -- RDDPNo.9
        gojitu9::varchar(8) as gojitu9, -- 後日出図予定日9
        rddp10::varchar(10) as rddp10, -- RDDPNo.10
        gojitu10::varchar(8) as gojitu10, -- 後日出図予定日10
        mttime::varchar(16) as mttime, -- MT日時
        _fivetran_synced::timestamp_ntz(9) as ldts -- 最終更新日時
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp17ecisyutuzu') }}
    where _fivetran_deleted = 'false'
)
select * from stg_eci_syutuzu
