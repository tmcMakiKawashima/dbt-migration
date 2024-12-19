with
    tmp10_dm_vehicle_generation as (
        select * from {{ ref('tmp10_dm_vehicle_generation') }}
    ),
    stg_riyosyameimaster as (
        select
            kb_model_brand, -- 車名ブランド区分
            mj_j_model_nm, -- 車名和名称
            mj_e_model_nm, -- 車名英名称
            cd_model_nm -- 車名コード
        from {{ ref('stg_riyosyameimaster') }} -- 利用車名マスタ
    )
select
    tmp10_dm_vehicle_generation.cd_model_nm,
    tmp10_dm_vehicle_generation.no_ofr_alt_pub,
    tmp10_dm_vehicle_generation.dd_mdly,
    tmp10_dm_vehicle_generation.cd_fll_mdl,
    tmp10_dm_vehicle_generation.cd_vtype,
    tmp10_dm_vehicle_generation.no_pub,
    tmp10_dm_vehicle_generation.dd_pubbnd_trmfrym,
    tmp10_dm_vehicle_generation.cd_pubbnd,
    tmp10_dm_vehicle_generation.no_pub_termfrid,
    tmp10_dm_vehicle_generation.kb_lang,
    tmp10_dm_vehicle_generation.kb_pub_type,
    tmp10_dm_vehicle_generation.kb_cont_type,
    tmp10_dm_vehicle_generation.cd_trgt,
    tmp10_dm_vehicle_generation.cd_brand,
    tmp10_dm_vehicle_generation.dt_server_opn,
    tmp10_dm_vehicle_generation.kb_pub_form,
    stg_riyosyameimaster.kb_model_brand,
    stg_riyosyameimaster.mj_j_model_nm,
    stg_riyosyameimaster.mj_e_model_nm,
    current_timestamp::timestamp_ntz as ldts -- 作成日時
from tmp10_dm_vehicle_generation
inner join stg_riyosyameimaster
  on tmp10_dm_vehicle_generation.cd_model_nm = stg_riyosyameimaster.cd_model_nm