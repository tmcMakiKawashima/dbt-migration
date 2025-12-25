{{ 
  config(
    materialized = 'incremental',
    incremental_strategy = 'merge',
    unique_key = ['syasyu' ,'haisya_kt' ,'spec200' ,'sk_y' ,'sk_m']
  )
 }}

with dm_siyo_daisu as (
    select
        syasyu,  -- 車種ｺｰﾄﾞ
        haisya_kt, -- 配車型式
        max(r_sfx_code) as r_sfx_code, -- SFXコード
        spec200, -- SPEC200桁組合せ
        max(spec200_siyo) as spec200_siyo, -- SPEC対応4桁仕様
        sk_y, -- 終検日年
        sk_m, -- 終検日月
        sum(daisu)::number(13,0) as daisu, -- 台数
        current_timestamp::timestamp_ntz(9) as ldts -- 作成日時
    from
        {{ref('dm_siyo_seisan_daisu')}}
    where
        naiji_flg != 1
    group by
        syasyu,
        haisya_kt,
        sk_y,
        sk_m,
        spec200
)
select * from dm_siyo_daisu