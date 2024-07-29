-- オーダー指示ステータスファイルに注文№、受注品番、仕向先CDを付与
{{ config(snowflake_warehouse='DBT_WH') }}

with
    oder_status as (select * from {{ ref("stg_dvnp0700") }}), -- オーダー指示ステータスファイル
    order_joho as (select * from {{ ref("stg_dvnp0680") }}) -- オーダー情報ファイル
select os.*
     , oj.odrno -- オーダーNo
     , oj.jhinban -- 受注品番
     , oj.dlrcd -- 仕向先CD
from oder_status os
left outer join order_joho oj
  on os.ordrkey = oj.ordrkey
 and os.juchuymd = oj.juchuymd
