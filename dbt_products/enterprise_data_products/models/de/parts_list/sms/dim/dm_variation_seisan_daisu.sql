{{ 
  config(
    materialized = 'incremental',
    unique_key = ['syasyu','kumitate','bui','vari','seppen_no_kara','haisya_kt','spec200','sk_y','sk_m'],
    incremental_strategy = 'merge',
    transient = false
  )
 }}

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
        daisu_spec200  -- 台数(SPEC200)
    from {{ref('tmp30_dm_variation_seisan_daisu')}}
),
{% if is_incremental() %}
updates_vsd as (
    select
        vs.syasyu,  -- 車種コード
        vs.kumitate,  -- 組立番号
        vs.bui,  -- 部位
        vs.vari,  -- バリエーション
        vs.seppen_no_kara,  -- 設変Noカラ
        vs.haisya_kt,  -- 配車型式
        vs.spec200,  -- SPEC200桁組合せ
        vs.daisai200,  -- SPEC対応4桁仕様
        vs.sk_y,  -- 終検日年
        vs.sk_m,  -- 終検日月
        cast(vs.daisu + th.daisu as number(13,0)) as daisu,  -- 台数
        vs.daisu_spec200,  -- 台数(SPEC200)
        null::varchar(1)  as spkbn,  -- STD/OPT
        null::varchar(250) as hikisiyo,  -- 引当仕様コード
        null::varchar(200) as spec200_hikisiyo,  -- SPEC200桁組合せ(引当仕様コード)
        current_timestamp()::timestamp_ntz(9) as ldts -- 最終更新日時
    from vsd vs
    inner join {{ this }} th
    on (
        vs.syasyu = th.syasyu
    and vs.kumitate = th.kumitate
    and vs.bui = th.bui
    and vs.vari = th.vari
    and vs.seppen_no_kara = th.seppen_no_kara
    and vs.haisya_kt = th.haisya_kt
    and vs.spec200 = th.spec200
    and vs.sk_y = th.sk_y
    and vs.sk_m = th.sk_m
    )
),
{% endif %}
inserts_vsd as (
    select
        vd.*,
        null::varchar(1)  as spkbn,  -- STD/OPT
        null::varchar(250) as hikisiyo,  -- 引当仕様コード
        null::varchar(200) as spec200_hikisiyo,  -- SPEC200桁組合せ(引当仕様コード)
        current_timestamp()::timestamp_ntz(9) as ldts -- 最終更新日時
    from vsd vd
{% if is_incremental() %}
    where
        not exists (
            select 1 from {{ this }} ti
            where
                vd.syasyu = ti.syasyu
            and vd.kumitate = ti.kumitate
            and vd.bui = ti.bui
            and vd.vari = ti.vari
            and vd.seppen_no_kara = ti.seppen_no_kara
            and vd.haisya_kt = ti.haisya_kt
            and vd.spec200 = ti.spec200
            and vd.sk_y = ti.sk_y
            and vd.sk_m = ti.sk_m
        )
{% endif %}
)
select * from inserts_vsd
{% if is_incremental() %}
union all
select * from updates_vsd
{% endif %}