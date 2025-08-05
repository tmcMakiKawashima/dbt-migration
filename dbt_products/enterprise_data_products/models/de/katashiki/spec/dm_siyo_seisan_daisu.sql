{{ 
  config(
    materialized ='incremental',
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

with dm_siyo_seisan_daisu as (
    select
        syasyu,-- 車種コード
        haisya_kt,-- 配車型式
        spec200,-- SFXコード
        max(daisai200) as daisai200,-- SPEC200桁組合せ
        int_cd,-- SPEC対応4桁仕様
        ext_cd,-- 内張コード
        dest_cd,-- 外鈑色コード
        max(dest) as dest,-- 仕向地コード
        koujyou_cd,-- 工場コード
        eng_kt,-- エンジン型式（生産管理）
        prodkuni_cd,-- 生産国コード
        psc,-- PSC
        o_idline,-- アイデントライン
        sk_y,-- 終検日年
        sk_m,-- 終検日月
        count(*)::number(13,0) as daisu -- 台数
    from
        {{ source('vinhis_db_spec','raw_dm_vinhis_spec200_allsalecar') }}
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
  coalesce(syasyu,'') as syasyu,
  coalesce(haisya_kt,'') as haisya_kt,
  null::varchar(2) as r_sfx_code,
  coalesce(spec200,'') as spec200,
  coalesce(daisai200,'') as daisai200,
  coalesce(int_cd,'') as int_cd,
  coalesce(ext_cd,'') as ext_cd,
  coalesce(dest_cd,'') as dest_cd,
  coalesce(dest,'') as dest,
  coalesce(koujyou_cd,'') as koujyou_cd,
  coalesce(eng_kt,'') as eng_kt,
  coalesce(prodkuni_cd,'') as prodkuni_cd,
  coalesce(psc,'') as psc,
  coalesce(o_idline,'') as o_idline,
  coalesce(sk_y,'') as sk_y,
  coalesce(sk_m,'') as sk_m,
  daisu,
  current_timestamp()::timestamp_ntz(9) as ldts -- 最終更新日時
from dm_siyo_seisan_daisu