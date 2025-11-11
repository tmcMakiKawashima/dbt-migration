{{ 
  config(
    materialized = 'incremental',
    incremental_strategy = 'append',
    transient = false,
    pre_hook = "
      {% if is_incremental() %}
      delete from {{this}}
      {% endif %}
    "
  )
 }}
 -- 洗い替えであるため、pre_hookで全件削除を行う。
with
    t52 as (select * from {{source('katashiki_db_spec','raw_tmp52_dm_siyo_seisan_daisu_test')}}),
    t71 as (select * from {{source('katashiki_db_spec','raw_tmp71_dm_siyo_seisan_daisu_test')}}),
    dm_siyo_seisan_daisu as (
      select
        t52.*,
        current_timestamp::timestamp_ntz(9) as ldts -- 作成日時
      from
        t52
      union all
      select
        t71.*,
        current_timestamp::timestamp_ntz(9) as ldts -- 作成日時
      from
        t71
    )
select
  syasyu as syasyu,
  haisya_kt as haisya_kt,
  r_sfx_code as r_sfx_code,
  spec200 as spec200,
  spec200_siyo as spec200_siyo,
  int_cd as int_cd,
  int_cd_iromei as int_cd_iromei,
  ext_cd as ext_cd,
  ext_cd_iromei as ext_cd_iromei,
  dest_cd as dest_cd,
  dest as dest,
  koujyou_cd as koujyou_cd,
  eng_kt as eng_kt,
  psc as psc,
  o_idline as o_idline,
  sk_y as sk_y,
  sk_m as sk_m,
  daisu as daisu,
  naiji_flg as naiji_flg,
  ldts as ldts
 from dm_siyo_seisan_daisu