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
-- 洗い替えであるため、pre_hookで全件削除を行う。

with dm_siyo_seisan_daisu as (
    select
        coalesce(max(syasyu),'') as syasyu,
        coalesce(max(haisya_kt),'') as haisya_kt,
        coalesce(max(spec200),'') as spec200,
        coalesce(max(daisai200),'') as daisai200,
        coalesce(max(int_cd),'') as int_cd,
        coalesce(max(ext_cd),'') as ext_cd,
        coalesce(max(dest_cd),'') as dest_cd,
        coalesce(max(dest),'') as dest,
        coalesce(max(koujyou_cd),'') as koujyou_cd,
        coalesce(max(eng_kt),'') as eng_kt,
        coalesce(max(prodkuni_cd),'') as prodkuni_cd,
        coalesce(max(psc),'') as psc,
        coalesce(max(o_idline),'') as o_idline,
        coalesce(max(sk_y),'') as sk_y,
        coalesce(max(sk_m),'') as sk_m,
        count(*) ::number(13,0) as daisu -- 台数
    from
        {{ source('vinhis_db_spec', 'raw_dm_vinhis_spec200_allsalecar') }}
    group by
        syasyu,
        haisya_kt,
        spec200,
        int_cd,
        ext_cd,
        dest_cd,
        koujyou_cd,
        eng_kt,
        prodkuni_cd,
        psc,
        o_idline,
        sk_y,
        sk_m
)
select 
  syasyu,
  haisya_kt,
  null ::varchar(2) as r_sfx_code,
  spec200,
  daisai200,
  int_cd,
  ext_cd,
  dest_cd,
  dest,
  koujyou_cd,
  eng_kt,
  prodkuni_cd,
  psc,
  o_idline,
  sk_y,
  sk_m,
  daisu,
  current_timestamp()::timestamp_ntz(9) as ldts -- 最終更新日時
from dm_siyo_seisan_daisu