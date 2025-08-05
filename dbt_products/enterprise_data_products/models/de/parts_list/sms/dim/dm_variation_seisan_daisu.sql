
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

with vsd as(
    select 
        syasyu,  -- 車種コード
        kumitate,  -- 組立番号
        bui,  -- 部位
        vari,  -- バリエーション
        seppen_no_kara,  -- 設変Noカラ
        haisya_kt,  -- 配車型式
        spec200,  -- SPEC200桁組合せ
        daisai200,  -- SPEC対応4桁仕様
        sk_y,  -- 終検日年
        sk_m,  -- 終検日月
        daisu,  -- 台数
        daisu_spec200,  -- 台数(SPEC200)
        null::varchar(1)  as spkbn,  -- STD/OPT
        null::varchar(250) as hikisiyo,  -- 引当仕様コード
        null::varchar(200) as spec200_hikisiyo  -- SPEC200桁組合せ(引当仕様コード)
    from {{ref('tmp30_dm_variation_seisan_daisu')}}
)
select * from vsd