{{
  config(
    materialized='incremental',
    unique_key = ['hinban'],
    incremental_strategy = 'merge'
  )
 }}

with stg_hinban as (
    select
        hinban::varchar(10) as hinban, -- なし
        kekka::varchar(1) as kekka, -- なし
        minor::varchar(2) as minor, -- なし
        rtrim(hinmei,' 　')::varchar(120) as hinmei, -- なし
        syasyu::varchar(4) as syasyu, -- なし
        zaisitu::varchar(41) as zaisitu, -- なし
        itaatu::varchar(40) as itaatu, -- なし
        zu::varchar(1) as zu, -- なし
        zu2d::varchar(1) as zu2d, -- なし
        zu3d::varchar(1) as zu3d, -- なし
        com21::varchar(54) as com21, -- なし
        com22::varchar(54) as com22, -- なし
        com23::varchar(54) as com23, -- なし
        com24::varchar(54) as com24, -- なし
        com29::varchar(54) as com29, -- なし
        com30::varchar(54) as com30, -- 空文字
        seppen::varchar(10) as seppen, -- なし
        try_to_timestamp_ntz(torokutime,'yyyymmddhh24missff9')::timestamp_ntz(6) as torokutime -- timestamp型
    from {{ ref('tmp_sms_api_parts_info_res_relational') }}

{% if is_incremental() %}
    where hinban not in (select hinban from {{this}})
{% endif %}

)
select * from stg_hinban