{{
  config(
    materialized='incremental',
    unique_key = ['index_cls','syadai_kt','frmno','wmi','vds','vis'],
    incremental_strategy = 'merge'
  )
}}

with
    cep1002seisan_r as (
      select
        index_cls as index_cls_r,
        frame_cls,
        frame_no,
        vin_wmi,
        vin_vds,
        vin_vis
      from {{ source('fivetran_database_oraclerds_orcl_iqas_osepcs0000db20', 'raw_cep1002seisan_r') }}
      where _fivetran_deleted = 'false'
      and mode_cls <> 'D'
      group by 
        index_cls,
        frame_cls,
        frame_no,
        vin_wmi,
        vin_vds,
        vin_vis
    ),
    stg_seisanjisseki as (
      select *
      from {{ source('fivetran_database_oraclerds_orcl_iqas_osepcs0000db20', 'raw_cep1002seisan') }}
      where _fivetran_deleted = 'false'

      {% if is_incremental() %}
          and _fivetran_synced > (select max(ldts) from {{this}})
      {% endif %}

    )
select
    stg_seisanjisseki.index_cls::varchar(3) as index_cls, --なし
    rtrim(stg_seisanjisseki.frame_cls,' 　')::varchar(6) as syadai_kt, --右ブランク
    stg_seisanjisseki.frame_no::varchar(7) as frmno, --なし
    stg_seisanjisseki.vin_wmi::varchar(3) as wmi, --なし
    stg_seisanjisseki.vin_vds::varchar(6) as vds, --なし
    stg_seisanjisseki.vin_vis::varchar(8) as vis, --なし
    stg_seisanjisseki.odt::varchar(1) as odt, --なし
    stg_seisanjisseki.dfsc_edno::varchar(5) as dfsc_edno, --なし
    stg_seisanjisseki.spec_list_no::varchar(2) as sno, --なし
    stg_seisanjisseki.katashiki_code::varchar(5) as katashiki_code, --なし
    stg_seisanjisseki.spec_1_10::varchar(10) as spec_1_10, --なし
    stg_seisanjisseki.spec_11_20::varchar(10) as spec_11_20, --なし
    stg_seisanjisseki.spec_21_30::varchar(10) as spec_21_30, --なし
    stg_seisanjisseki.spec_31_40::varchar(10) as spec_31_40, --なし
    stg_seisanjisseki.spec_41_50::varchar(10) as spec_41_50, --なし
    stg_seisanjisseki.spec_51_60::varchar(10) as spec_51_60, --なし
    stg_seisanjisseki.spec_61_70::varchar(10) as spec_61_70, --なし
    stg_seisanjisseki.spec_71_80::varchar(10) as spec_71_80, --なし
    stg_seisanjisseki.spec_81_90::varchar(10) as spec_81_90, --なし
    stg_seisanjisseki.spec_91_100::varchar(10) as spec_91_100, --なし
    stg_seisanjisseki.spec_101_110::varchar(10) as spec_101_110, --なし
    stg_seisanjisseki.spec_111_120::varchar(10) as spec_111_120, --なし
    stg_seisanjisseki.spec_121_130::varchar(10) as spec_121_130, --なし
    stg_seisanjisseki.spec_131_140::varchar(10) as spec_131_140, --なし
    stg_seisanjisseki.spec_141_150::varchar(10) as spec_141_150, --なし
    stg_seisanjisseki.spec_151_160::varchar(10) as spec_151_160, --なし
    stg_seisanjisseki.spec_161_170::varchar(10) as spec_161_170, --なし
    stg_seisanjisseki.spec_171_180::varchar(10) as spec_171_180, --なし
    stg_seisanjisseki.spec_181_190::varchar(10) as spec_181_190, --なし
    stg_seisanjisseki.spec_191_200::varchar(10) as spec_191_200, --なし
    stg_seisanjisseki.business_orgn_cls::varchar(1) as business_orgn_cls, --なし
    stg_seisanjisseki.plnt_line_cls::varchar(1) as plnt_line_cls, --なし
    stg_seisanjisseki.key_no_door::varchar(6) as key_no_door, --なし
    stg_seisanjisseki.key_no_ignition::varchar(6) as key_no_ignition, --なし
    stg_seisanjisseki.prod_data_id::varchar(1) as prod_data_id_seisan, --なし
    stg_seisanjisseki.mtuser::varchar(18) as mtuser, --なし
    stg_seisanjisseki.mttime::timestamp_ntz as mttime, --timestamp型
    stg_seisanjisseki._fivetran_synced::timestamp_ntz as ldts --timestamp型
from stg_seisanjisseki
inner join cep1002seisan_r
    on stg_seisanjisseki.index_cls = cep1002seisan_r.index_cls_r
    and stg_seisanjisseki.frame_cls = cep1002seisan_r.frame_cls
    and stg_seisanjisseki.frame_no = cep1002seisan_r.frame_no
    and stg_seisanjisseki.vin_wmi = cep1002seisan_r.vin_wmi
    and stg_seisanjisseki.vin_vds = cep1002seisan_r.vin_vds
    and stg_seisanjisseki.vin_vis = cep1002seisan_r.vin_vis