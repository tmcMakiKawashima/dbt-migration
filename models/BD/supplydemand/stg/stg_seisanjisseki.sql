{{ 
  config(
    materialized='incremental',
    unique_key = ['index_cls','syadai_kt','frmno','wmi','vds','vis'],
    incremental_strategy = 'merge'
  )
 }}                                                                                               -- ① incrementalを指定

with stg_seisanjisseki as (
    select
        index_cls::varchar(3) as index_cls, --なし
        frame_cls::varchar(6) as syadai_kt, --なし
        frame_no::varchar(7) as frmno, --なし
        vin_wmi::varchar(3) as wmi, --なし
        vin_vds::varchar(6) as vds, --なし
        vin_vis::varchar(8) as vis, --なし
        odt::varchar(1) as odt, --なし
        dfsc_edno::varchar(5) as dfsc_edno, --なし
        spec_list_no::varchar(2) as sno, --なし
        katashiki_code::varchar(5) as katashiki_code, --なし
        spec_1_10::varchar(10) as spec_1_10, --なし
        spec_11_20::varchar(10) as spec_11_20, --なし
        spec_21_30::varchar(10) as spec_21_30, --なし
        spec_31_40::varchar(10) as spec_31_40, --なし
        spec_41_50::varchar(10) as spec_41_50, --なし
        spec_51_60::varchar(10) as spec_51_60, --なし
        spec_61_70::varchar(10) as spec_61_70, --なし
        spec_71_80::varchar(10) as spec_71_80, --なし
        spec_81_90::varchar(10) as spec_81_90, --なし
        spec_91_100::varchar(10) as spec_91_100, --なし
        spec_101_110::varchar(10) as spec_101_110, --なし
        spec_111_120::varchar(10) as spec_111_120, --なし
        spec_121_130::varchar(10) as spec_121_130, --なし
        spec_131_140::varchar(10) as spec_131_140, --なし
        spec_141_150::varchar(10) as spec_141_150, --なし
        spec_151_160::varchar(10) as spec_151_160, --なし
        spec_161_170::varchar(10) as spec_161_170, --なし
        spec_171_180::varchar(10) as spec_171_180, --なし
        spec_181_190::varchar(10) as spec_181_190, --なし
        spec_191_200::varchar(10) as spec_191_200, --なし
        business_orgn_cls::varchar(1) as business_orgn_cls, --なし
        plnt_line_cls::varchar(1) as plnt_line_cls, --なし
        key_no_door::varchar(6) as key_no_door, --なし
        key_no_ignition::varchar(6) as key_no_ignition, --なし
        prod_data_id::varchar(1) as prod_data_id_seisan, --なし
        mtuser::varchar(18) as mtuser, --なし
        mttime::timestamp as mttime, --timestamp型
        _fivetran_synced::timestamp as ldts --timestamp型
    from {{ source('fivetran_database_supplydemand', 'raw_cep1002seisan') }}
     where _fivetran_deleted = 'FALSE'

{% if is_incremental() %}                                                                                                              -- ② 増分の取り方を指定
    and _fivetran_synced > (select max(ldts) from {{this}})
{% endif %}

    )
select * from stg_seisanjisseki