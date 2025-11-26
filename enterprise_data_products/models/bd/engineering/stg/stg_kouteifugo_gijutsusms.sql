{{ config(
      materialized='incremental',
      unique_key = ['ktfgo'],
      incremental_strategy = 'merge'
  )
 }}

with stg_kouteifugo_gijutsusms as (
    select
        ktfgo::varchar(6) as ktfgo, --なし
        ktbunrui::varchar(1) as ktbunrui, --なし
        jtaizoku::varchar(2) as jtaizoku, --なし
        kojozoku::varchar(1) as kojozoku, --なし
        tatezoku::varchar(1) as tatezoku, --なし
        kouhouzoku::varchar(2) as kouhouzoku, --なし
        tktgicyuzoku::varchar(2) as tktgicyuzoku, --なし
        hojyofgozoku::varchar(2) as hojyofgozoku, --なし
        tksnaiseizoku::varchar(2) as tksnaiseizoku, --なし
        busyozoku::varchar(2) as busyozoku, --なし
        ktfgomeijp::varchar(20) as ktfgomeijp, --なし
        ktfgomeien::varchar(40) as ktfgomeien, --なし
        bmkbn::varchar(1) as bmkbn, --なし
        oktfgo::varchar(3) as oktfgo, --なし
        torokuymd::varchar(8) as torokuymd, --なし
        haisiymd::varchar(8) as haisiymd, --なし
        mttime::varchar(16) as mttime, --なし
        zisikyuflg::varchar(1) as zisikyuflg, --なし
        'sms-koutei'::varchar(50) as source, --なし
        _fivetran_synced::timestamp_ntz as ldts -- timestamp型
    from {{ source('fivetran_database_idr_gijutsu_sms_dxpfy2d', 'raw_cyp26ktfgo') }}
    where _fivetran_deleted = 'false'
           
  {% if is_incremental() %}
      and _fivetran_synced > (select max(ldts) from {{this}})
  {% endif %}
)
select * from stg_kouteifugo_gijutsusms