{{
    config (
        post_hook=
            'create or replace hybrid table model_db.repair.dm_vehicle_generation (
                cd_model_nm varchar(5) not null,
                no_ofr_alt_pub varchar(16) not null,
                dd_mdly varchar(4) not null,
                cd_fll_mdl varchar(20) not null,
                cd_vtype varchar(6) not null,
                no_pub varchar(10) not null,
                dd_pubbnd_trmfrym varchar(6) not null,
                cd_pubbnd varchar(6),
                no_pub_termfrid varchar(3),
                kb_lang varchar(1),
                kb_pub_type varchar(1),
                kb_cont_type varchar(2),
                cd_trgt varchar(1),
                cd_brand varchar(2),
                dt_server_opn varchar(12),
                kb_pub_form varchar(1),
                kb_model_brand varchar(1),
                mj_j_model_nm varchar(60),
                mj_e_model_nm varchar(60),
                ldts timestamp_ntz(9),
                constraint dm_vehicle_generation_cd_model_nm_no_ofr_alt_pub_dd_mdly_cd_fll_mdl_cd_vtype_no_pub_dd_pubbnd_trmfrym_uk primary key (cd_model_nm, no_ofr_alt_pub, dd_mdly, cd_fll_mdl, cd_vtype, no_pub, dd_pubbnd_trmfrym) rely
            ) as select * from {{this}}'
    )
}}

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