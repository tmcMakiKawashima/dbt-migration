{{ config(snowflake_warehouse='DBT_WH') }}

with
  H_H as (select * from {{ ref('stg_h_hanbaikt_frmkbn') }}), -- 配車原始(フレーム区分)HUB
  LK_H as (select * from {{ ref('stg_lk_hanbaikt_frmkbn')}}), -- 配車原始(フレーム区分)LINK
  ST_H as (select * from {{ ref('stg_st_hanbaikt_frmkbn')}}), -- 配車原始(フレーム区分)SAT
  ST_J as (select * from {{ ref('stg_st_jpsalecar_frmkbn')}}) -- 日本販売個車(フレーム区分)SAT
select
  H_H.HKATA as HKATA, -- 販売型式
  LPAD(trim(H_H.FRMNO), 7, '0') as FRMNO, -- フレームNO
  ST_H.FRMKBN as FRMKBN, -- フレーム区分
  trim(ST_J.VLT_Y) as VLT_Y, -- VLT出力日年
  trim(ST_J.VLT_M) as VLT_M, -- VLT出力日月
  trim(ST_J.VLT_D) as VLT_D, -- VLT出力日日
  trim(ST_J.SK_Y) as SK_Y, -- 終検日年
  trim(ST_J.SK_M) as SK_M, -- 終検日月
  trim(ST_J.SK_D) as SK_D, -- 終検日日
  trim(ST_J.HAISYA_Y) as HAISYA_Y, -- 配車日年
  trim(ST_J.HAISYA_M) as HAISYA_M, -- 配車日月
  trim(ST_J.HAISYA_D) as HAISYA_D -- 配車日日
from ST_H -- 配車原始(フレーム区分)SAT
left outer join LK_H -- 配車原始(フレーム区分)LINK
on ST_H.MD5_HANBAIKT_LINK = LK_H.MD5_HANBAIKT_LINK
left outer join H_H -- 配車原始(フレーム区分)HUB
on LK_H.MD5_HANBAIKT_HUB = H_H.MD5_HANBAIKT_HUB
left outer join ST_J -- 日本販売個車(フレーム区分)SAT
on LK_H.MD5_JPSALECAR_HUB = ST_J.MD5_JPSALECAR_HUB
